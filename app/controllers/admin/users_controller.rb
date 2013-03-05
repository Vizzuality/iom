class Admin::UsersController < Admin::AdminController
  before_filter :get_user,          :only => [:edit, :update, :destroy]
  before_filter :get_sites,         :only => [:new, :edit]

  def index
    params[:user]  = {'organization_id' => '-1'}.merge(params[:user] || {})

    @user          = User.new(params[:user])
    @users         = User.order('id asc')
    @users         = @users.filter_by_organization(params[:user])
    @users         = @users.paginate :per_page => 20, :order => 'name asc', :page => params[:page]
    @organizations = grouped_organizations
    render :partial => 'users' and return if request.xhr?

    respond_to do |format|
      format.html
      format.xls do
        send_data User.to_excel(params[:user]['organization_id']),
          :type        => 'application/vnd.ms-excel',
          :disposition => "attachment; filename=users.xls"
      end
    end
  end

  def new
    @user          = User.new
    @organizations = Organization.all
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to :admin_users
    else
      @organizations = Organization.all
      get_sites
      render :new
    end
  end

  def edit
    @organizations = Organization.all
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to :admin_users
    else
      @organizations = Organization.all
      get_sites
      render :edit
    end
  end

  def destroy
    @user.destroy

    redirect_to :admin_users
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def grouped_organizations
    [
      ['', [['All', '-1']]],
      ['', [['Interaction', nil]]],
      ['', Organization.with_admin_user.all.map{|o| [o.name, o.id]}]
    ]
  end

  def get_sites
    @sites = Site.select([:id, :name]).all
  end

  def organization_filter_active?
    params[:user].present? && params[:user][:organization_id].present?
  end
end

