class ApplicationController < ActionController::Base

  # resource is the User instance created from users#spotify
  def after_sign_in_path_for(resource)
    root_path
  end

end
