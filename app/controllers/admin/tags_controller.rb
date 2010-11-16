class Admin::TagsController < ApplicationController

  before_filter :login_required

  def index
    term = params[:term].strip
    @tags = if term.blank?
      []
    else
      Tag.where("name like '#{term}%'")
    end
    respond_to do |format|
      format.json do
        render :json => @tags.map{ |tag| {:name => tag.name, :count => tag.count, :id => tag.id} }.to_json
      end
    end
  end

end
