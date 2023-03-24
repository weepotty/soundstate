class PagesController < ApplicationController
  def home
    @user = User.first

    render (user_signed_in? ? 'pages/home' : 'pages/landing')
  end
end
