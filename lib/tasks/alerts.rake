namespace :iom do

  namespace :alerts do

    desc 'Send an email alert to all project administration whose projects are about to end'
    task :projects_about_to_finish => :environment do
      about_to_finish = Project.where('end_date <= ? AND end_date >= ?', 7.days.since, Time.now)
      about_to_finish.each { |project| AlertsMailer.projects_about_to_finish(project) }
    end

  end

end
