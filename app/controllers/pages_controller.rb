class PagesController < ApplicationController
  def home
    if user_signed_in?
      @nickname = current_user.nickname
      @day_period = User.day_period
      render 'pages/home'
    else
      render 'pages/landing'
    end
  end
end
