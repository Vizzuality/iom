namespace :iom do
  namespace :maintenance do

    desc 'Loads countries for projects without it'
    task :load_projects_countries => :environment do
      Project.with_no_country.find_each(:batch_size => 500) do |project|
        project.countries = project.regions.map(&:country).uniq! || []
        project.save!(false)
        print '.'
      end
    end

  end
end
