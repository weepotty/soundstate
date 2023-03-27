module PagesHelper
  def current?(controller, page_name)
    'current' if params[:action] == page_name && params[:controller] == controller
  end
end
