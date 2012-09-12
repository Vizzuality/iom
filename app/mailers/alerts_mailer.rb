class AlertsMailer < ActionMailer::Base
  default :from => "from@example.com"

  def projects_about_to_finish(project)
    print '.'
    @user = project.primary_organization.user || User.admin
    mail(:to => @user.email, :subject => "Project #{project.name} is about to finish!")
  end
end
