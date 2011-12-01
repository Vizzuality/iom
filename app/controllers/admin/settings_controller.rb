class Admin::SettingsController < Admin::AdminController
  before_filter :load_settings

  def edit
  end

  def update
    @settings.attributes = params[:settings]
    if @settings.save
      redirect_to edit_admin_setting_path(@settings), :flash => {:success => 'Settings have been updated successfully'}
    else
      render :action => 'edit'
    end
  end

  protected

    def load_settings
      @settings = Settings.first
    end


end
