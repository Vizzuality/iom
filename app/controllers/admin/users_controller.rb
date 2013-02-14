class Admin::UsersController < Admin::AdminController
  before_filter :get_user,          :only => [:edit, :update, :destroy]
  before_filter :get_organizations, :only => [:index, :new, :edit]
  before_filter :get_sites,         :only => [:new, :edit]

  def index
    @new_user  =  User.new(params[:user])
    @users     =  User.order('id asc')
    @users     =  @users.filter_by_organization(params[:user])
    @users     =  @users.paginate :per_page => 20, :order => 'name asc', :page => params[:page]
    render :partial => 'users' and return if request.xhr?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to :admin_users
    else
      get_organizations
      get_sites
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to :admin_users
    else
      get_organizations
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

  def get_organizations
    @organizations = Organization.with_admin_user.all
  end

  def get_sites
    @sites = Site.select([:id, :name]).all
  end

end

