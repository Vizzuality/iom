class Admin::ProjectsController < ApplicationController

  before_filter :login_required

  def index
    @conditions = {}

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
      unless params[:country].blank? || params[:country] == "0"
        if country = Country.find_by_id(params[:country])
          @conditions[country.name] = {'country' => params[:country]}
          from << 'countries_projects'
          projects = projects.from(from.join(',')).where("countries_projects.country_id = #{country.id} AND countries_projects.project_id = projects.id")
        end
      end
      unless params[:cluster].blank? || params[:cluster] == '0'
        if cluster = Cluster.find_by_id(params[:cluster])
          @conditions[cluster.name] = {'cluster' => params[:cluster]}
          from << 'clusters_projects'
          projects = projects.from(from.join(',')).where("clusters_projects.cluster_id = #{cluster.id} AND clusters_projects.project_id = projects.id")
        end
      end
      unless params[:sector].blank? || params[:sector] == '0'
        if sector = Sector.find_by_id(params[:sector])
          @conditions[sector.name] = {'sector' => params[:sector]}
          from << 'projects_sectors'
          projects = projects.from(from.join(',')).where("projects_sectors.sector_id = #{sector.id} AND projects_sectors.project_id = projects.id")
        end
      end
      @projects = projects.paginate :per_page => 20, :order => 'created_at DESC', :page => params[:page]
    elsif params[:organization_id]
      template      = 'admin/organizations/projects'
      @organization = Organization.find(params[:organization_id])
      projects      = @organization.projects
      @projects     = projects.paginate :per_page => 20, :order => 'created_at DESC', :page => params[:page]
    else
      projects  = Project.all
      @projects = Project.paginate :per_page => 20, :order => 'created_at DESC', :page => params[:page]
    end

    respond_to do |format|
      format.html do
        render :template => template if template.present?
      end
      format.csv do
        if projects.present?
          send_data projects.serialize_to_csv,
            :type => 'text/csv; charset=iso-8859-1; header=present',
            :disposition => "attachment; filename=#{@organization.name}_projects.csv"
        end
      end
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    set_project_geometry
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
    set_project_geometry
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

  def remove_point
    @project = Project.find(params[:id])
    the_geom = @project.the_geom.dup
    if params[:position].to_i >= the_geom.points.size
      render :nothing => true and return
    end
    the_geom.delete_at(params[:position].to_i)
    @project.the_geom = the_geom
    @project.save!
    respond_to do |format|
      format.html do
        redirect_to edit_admin_project_path(@project,:anchor => 'map'), :flash => {:success => 'Project has been deleted successfully'}
      end
      format.js do
        render :update do |page|
          page << "$('li#point_#{params[:position]}').fadeOut().remove();"
        end
      end
    end
  end

  private

    def set_project_geometry
      if params[:project_geometry]
        points = []
        params[:project_geometry].tr('(','').tr(')','').split(',').in_groups_of(2) do |point|
          points << Point.from_x_y(point[1].strip.to_f, point[0].strip.to_f)
        end
        @project.the_geom = MultiPoint.from_points(points)
      end
    end

end
