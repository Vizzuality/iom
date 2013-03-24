class Admin::ProjectsSynchronizationsController < Admin::AdminController

  layout false

  def create
    synchronization = ProjectsSynchronization.new(:projects_file => params[:qqfile])
    synchronization.save

    render :json => synchronization
  end

  def update
    synchronization = ProjectsSynchronization.find(params[:id])
    synchronization.save

    render :json => synchronization
  end

end
