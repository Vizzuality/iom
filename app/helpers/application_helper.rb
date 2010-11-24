module ApplicationHelper

  def selected_if_current_page(url_path)
    raw("class=\"selected\"") if request.path == url_path
  end

  def errors_for(obj, attribute)
    return if action_name == 'new'
    if obj.errors[attribute]
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
