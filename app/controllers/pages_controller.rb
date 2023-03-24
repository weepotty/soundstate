class PagesController < ApplicationController
  def home
    if user_signed_in?
      render 'pages/home'
    else
      render 'pages/landing'
    end
  end
end
