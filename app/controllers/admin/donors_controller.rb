class Admin::DonorsController < ApplicationController

  before_filter :login_required

  def index
    donors = if params[:q]
      q = "%#{params[:q].sanitize_sql!}%"
      Donor.where(["name ilike ? OR description ilike ?", q, q])
    else
      Donor
    end
    @donors = donors.paginate :per_page => 20, :order => 'created_at DESC', :page => params[:page]
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
    @donor.attributes = params[:donor]
    if @donor.save
      redirect_to edit_admin_donor_path(@donor), :flash => {:success => 'Donor has been updated successfully'}
    else
      render :action => 'edit'
    end
  end

  def destroy
    @donor = Donor.find(params[:id])
    @donor.destroy
    redirect_to admin_donors_path, :flash => {:success => 'Donor has been deleted successfully'}
  end

end
