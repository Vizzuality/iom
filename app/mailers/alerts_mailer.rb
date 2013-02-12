class AlertsMailer < ActionMailer::Base
  default :from => 'mappinginfo@interaction.org'

  def projects_about_to_end(contact_email, projects)
    @projects = projects
    mail(:to => contact_email, :subject => "[NGO Aid Map] Projects about to end!")
  end

  def reset_password(user_email, reset_token)
    @reset_token = reset_token
    mail(:to => user_email, :subject => "Change your NGO Aid Map password")
  end

  def six_months_since_last_login(user)
    mail(:to => user.email, :subject => "NGO Aid Map - We Miss You!")
  end

  if Rails.env.development?
    class Preview < MailView

      def projects_about_to_end
        contact_email = 'fer@ferdev.com'
        projects = Project.first(6).map do |project|
          {
            :id           => project.id,
            :name         => project.name,
            :country_name => project.countries.map(&:name).join(', ').presence || 'Spain',
            :end_date     => project.end_date.to_date
          }
        end
        ::AlertsMailer.projects_about_to_end(contact_email, projects)
      end

      def reset_password
        user = User.first
        user.send_password_reset
        ::AlertsMailer.reset_password(user.email, user.password_reset_token)
      end

      def six_months_since_last_login
        ::AlertsMailer.six_months_since_last_login(User.first)
      end
    end
  end
end
