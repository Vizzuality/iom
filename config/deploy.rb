require 'capistrano/ext/multistage'
require 'config/boot'
require "bundler/capistrano"
require 'rollbar/capistrano'

set :stages, %w(staging production)

APP_CONFIG = YAML.load_file("config/app_config.yml")['production']

set :rollbar_token, APP_CONFIG['rollbar_token']
set(:rollbar_env) { stage }


default_run_options[:pty] = true

set :application, 'iom'

set :scm, :git
# set :git_enable_submodules, 1
set :git_shallow_clone, 1
set :scm_user, 'ubuntu'
set :repository, "git://github.com/Vizzuality/iom.git"
ssh_options[:forward_agent] = true
set :keep_releases, 5

set :linode_staging, '178.79.131.104'
set :linode_production, '173.255.238.86'
set :user,  'ubuntu'

set :deploy_to, "/home/ubuntu/www/#{application}"

after  "deploy:update_code", :symlinks, :run_migrations, :asset_packages, :set_staging_flag
after "deploy:update", "deploy:cleanup"

desc "Restart Application"
deploy.task :restart, :roles => [:app] do
  run "touch #{current_path}/tmp/restart.txt"
end

desc "Migraciones"
task :run_migrations, :roles => [:app] do
  run <<-CMD
    export RAILS_ENV=production &&
    cd #{release_path} &&
    bundle exec rake db:migrate
  CMD
end

desc "Uploads config yml files to app server's shared config folder"
task :upload_yml_files, :roles => :app do
  run "mkdir #{deploy_to}/shared/config ; true"
  upload("config/app_config.yml", "#{deploy_to}/shared/config/app_config.yml")
end

task :symlinks, :roles => [:app] do
  run <<-CMD
    ln -s #{shared_path}/config/app_config.yml #{release_path}/config/app_config.yml;
  CMD
end

desc 'Create asset packages'
task :asset_packages, :roles => [:app] do
 run <<-CMD
   export RAILS_ENV=production &&
   cd #{release_path} &&
   bundle exec rake sass:update asset:packager:build_all
 CMD
end
