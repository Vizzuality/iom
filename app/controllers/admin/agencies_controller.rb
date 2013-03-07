class Admin::AgenciesController < Admin::AdminController
  before_filter :get_donor, :only => :index

  def index
    @agencies = if @donor.present?
                  @donor.agencies.order('name asc').all
                else
                  if params[:q].present? || params[:filter_donor_id].present?
                    @agencies = Agency
                    if params[:q].present?
                      q = "%#{params[:q].sanitize_sql!}%"
                      @agencies = @agencies.where(["name ilike ?", q])
                    end
                    if params[:filter_donor_id].present?
                      @agencies = @agencies.where(["donor_id =?", params[:filter_donor_id]])
                      @donor_filter = Donor.find(params[:filter_donor_id])
                    end
                  else
                    @agencies = Agency
                  end

                  @agencies = @agencies.order('name asc').all
                end

    @agencies = @agencies.paginate :per_page => 20,
                                                     :order => 'created_at DESC',
                                                     :page => params[:page]
    @donors = [['All', nil]] + Donor.all.map{|d| [d.name, d.id]}
  end

  def new
    @agency = Agency.new
    @donors = Donor.all.map{|d| [d.name, d.id]}
  end

  def create
    @agency = Agency.new(params[:agency])
    if @agency.save
      flash[:notice] = 'Agency created successfully.'
      redirect_to edit_admin_agency_path(@agency), :flash => {:success => 'Agency created successfully.'}
    else
      render :action => 'new'
    end
  end

  def edit
    @agency = Agency.find(params[:id])
    @donors = Donor.all.map{|d| [d.name, d.id]}
  end

  def update
    @agency = Agency.find(params[:id])
    @agency.attributes = params[:agency]
    if @agency.save
      flash[:notice] = 'Agency updated successfully.'
      redirect_to edit_admin_agency_path(@agency), :flash => {:success => 'Agency updated successfully.'}
    else
      render :action => 'edit'
    end
  end

  def destroy
    @agency = Agency.find(params[:id])
    @agency.destroy
    redirect_to admin_agencies_path, :flash => {:success => 'Agency deleted successfully'}
  end

  private

  def get_donor
    @donor = Donor.find(params[:donor_id]) if params[:donor_id]
  end
end
