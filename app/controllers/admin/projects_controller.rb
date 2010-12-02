class Admin::ProjectsController < ApplicationController

  before_filter :login_required

  def index

    @conditions = {}
    template = 'index'

    if params[:q]
      q = "%#{params[:q].sanitize_sql!}%"
      projects = Project.where(["name ilike ? OR description ilike ?", q, q])
      from = ["projects"]
      unless params[:status].blank?
        if params[:status] == 'active'
          @conditions['active'] = {'status' => 'active'}
          projects = projects.where("end_date > ?", Date.today.to_s(:db))
        elsif params[:status] == 'closed'
          @conditions['closed'] = {'status' => 'closed'}
          projects = projects.where("end_date < ?", Date.today.to_s(:db))
        end
      end
      unless params[:country].blank?
        if country = Country.find(params[:country])
          @conditions[country.name] = {'country' => params[:country]}
          from << 'countries_projects'
          projects = projects.from(from.join(',')).where("countries_projects.country_id = #{country.id} AND countries_projects.project_id = projects.id")
        end
      end
      unless params[:cluster].blank?
        if cluster = Cluster.find(params[:cluster])
          @conditions[cluster.name] = {'cluster' => params[:cluster]}
          from << 'clusters_projects'
          projects = projects.from(from.join(',')).where("clusters_projects.cluster_id = #{cluster.id} AND clusters_projects.project_id = projects.id")
        end
      end
      unless params[:sector].blank?
        if sector = Sector.find(params[:sector])
          @conditions[sector.name] = {'sector' => params[:sector]}
          from << 'projects_sectors'
          projects = projects.from(from.join(',')).where("projects_sectors.sector_id = #{sector.id} AND projects_sectors.project_id = projects.id")
        end
      end
      @projects = projects.paginate :per_page => 20, :order => 'created_at DESC', :page => params[:page]
    elsif params[:organization_id]
      template = 'projects'
      @organization = Organization.find(params[:organization_id])
      @projects = @organization.projects.paginate :per_page => 20, :order => 'created_at DESC', :page => params[:page]
    else
      @projects = Project.paginate :per_page => 20, :order => 'created_at DESC', :page => params[:page]
    end

    respond_to do |format|
      format.html{ render :template => "admin/organizations/#{template}" }
      format.csv do
        send_data @projects.to_csv,
          :type => 'text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=#{@organization.name}_projects.csv"
      end
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.valid? && @project.save
      redirect_to edit_admin_project_path(@project), :flash => {:success => 'Project has been created successfully'}
    else
      render :action => 'new'
    end
  end

  def donations
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    @project.attributes = params[:project]
    if @project.save
      redirect_to edit_admin_project_path(@project), :flash => {:success => 'Project has been updated successfully'}
    else
      render :action => 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to admin_projects_path, :flash => {:success => 'Project has been deleted successfully'}
  end

end
