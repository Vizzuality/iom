class Admin::DonorsController < Admin::AdminController

  def index
    donors = if params[:q]
      q = "%#{params[:q].sanitize_sql!}%"
      Donor.where(["name ilike ? OR description ilike ?", q, q])
    else
      Donor
    end
    @donors = donors.order('name asc').paginate :per_page => 20, :order => 'created_at DESC', :page => params[:page]
    respond_to do |format|
      format.html
      format.json do
        render :json => @donors.first(5).map{ |donor| {:value => donor.name.html_safe, :label => donor.name.html_safe.truncate(40), :element_id => donor.id} }.to_json
      end
    end
  end

  def new
    @donor = Donor.new
  end

  def create
    @donor = Donor.new(params[:donor])
    if @donor.save
      redirect_to edit_admin_donor_path(@donor), :flash => {:success => 'Donor has been created successfully'}
    else
      render :action => 'new'
    end
  end

  def projects
    @donor = Donor.find(params[:id])
  end

  def edit
    @donor = Donor.find(params[:id])
  end

  def update
    @donor = Donor.find(params[:id])
    if params[:site_id]
      if @site = Site.find(params[:site_id])
        @donor.attributes_for_site = {:donor_values => params[:donor], :site_id => params[:site_id]}
      end
    else
      @donor.attributes = params[:donor]
    end
    if @donor.save
      if params[:site_id]
        redirect_to donor_site_specific_information_admin_donor_path(@donor, @site), :flash => {:success => 'Donor has been updated successfully'}
      else
        redirect_to edit_admin_donor_path(@donor), :flash => {:success => 'Donor has been updated successfully'}
      end
    else
      render :action => 'edit'
    end
  end

  def destroy
    @donor = Donor.find(params[:id])
    @donor.destroy
    redirect_to admin_donors_path, :flash => {:success => 'Donor has been deleted successfully'}
  end

  def specific_information
    @donor = Donor.find(params[:id])
    @site = Site.find(params[:site_id])
    @donor.attributes = @donor.attributes_for_site(@site)
  end

  def destroy_logo
    @donor = Donor.find(params[:id])
    @donor.logo.clear
    @donor.save
    respond_to do |format|
      format.html do
        redirect_to edit_admin_donor_path(@donor), :flash => {:success => 'Donor logo has been removed successfully'}
      end
    end
  end

end
