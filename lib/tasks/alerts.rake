namespace :iom do

  namespace :alerts do

    desc 'Send an email alert to all project administration whose projects are about to end'
    task :projects_about_to_end => :environment do
      about_to_end = Project.where('end_date <= ?', 1.month.since.advance(:days => -1))

      to = {}
      about_to_end.each do |project|
        project.cached_sites.each do |site|
          email = begin
                    project.primary_organization.site_specific_information[site.id.to_s][:contact_email].presence || 'mappinginfo@interaction.org'
                  rescue
                    project.primary_organization.contact_email.presence || 'mappinginfo@interaction.org'
                  end

          to[email] = [] unless to.has_key?(email)
          to[email] << {
            :id           => project.id,
            :name         => project.name,
            :country_name => project.countries.map(&:name).join(', '),
            :end_date     => project.end_date
          }
          to[email].uniq!
        end
      end

      to.each { |email, projects| AlertsMailer.projects_about_to_end(email, projects).deliver }
    end

  end

end
