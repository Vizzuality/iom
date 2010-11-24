module ApplicationHelper

  def selected_if_current_page(url_path)
    raw("class=\"selected\"") if request.path == url_path
  end

end
