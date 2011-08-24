class HomeController < ApplicationController
  def index
    @assets = Asset.order('id desc').page params[:page]
  end
end
