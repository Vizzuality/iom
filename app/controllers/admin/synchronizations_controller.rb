class Admin::SynchronizationsController < Admin::AdminController

  layout false

  def create
    @synchronization = Synchronization.new(params[:qqfile])

    render :json => @synchronization
  end

  def update
    @synchronization = Synchronization.create(params[:qqfile])
  end

end
