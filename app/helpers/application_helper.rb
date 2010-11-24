module ApplicationHelper

  def selected_if_current_page(url_path)
    if @organization
      if (action_name == "specific_information" || action_name == 'new' || action_name == 'edit' || action_name == 'create' || action_name == 'update') && request.path == url_path
        raw("class=\"list_selected\"")
      else
        raw("class=\"list_unselected\"")      
      end
    else
      raw("class=\"selected\"") if request.path == url_path
    end
  end

  def errors_for(obj, attribute)
    return if action_name == 'new'
    unless obj.errors[attribute].empty?
      return raw(<<-HTML
          <span class="field_error">
            <a class="error"></a>
            <div class="error_msg">
              <p><span>#{obj.errors[attribute]}</span></p>
            </div>
          </span>
      HTML
)
    end
  end

end
