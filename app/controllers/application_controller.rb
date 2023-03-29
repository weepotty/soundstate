class ApplicationController < ActionController::Base

  # resource is the User instance created from users#spotify
  def after_sign_in_path_for(resource)
    load_songs_page_path
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

end
