class HomeController < ApplicationController
  def index
    render :nothing => true, :layout => 'application'
  end
end
