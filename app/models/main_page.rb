class MainPage < Page

  default_scope where(:site_id => nil)

  def self.model_name
    Page.model_name
  end

end
