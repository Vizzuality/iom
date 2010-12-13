namespace :iom do
  desc 'Set projects_sites values'
  task :set_projects_sites => :environment do
    Site.all.each do |site|
      site.projects(:limit => nil, :offset => nil).each do |project| 
        ActiveRecord::Base.connection.execute("INSERT INTO projects_sites (project_id, site_id) VALUES (#{project.id},#{site.id})")
      end
    end
  end
end