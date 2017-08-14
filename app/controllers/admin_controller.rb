class AdminController < ApplicationController
  before_action :authenticate_user!

  layout 'admin'

  def index
    @graphic = Graphic.all
  end

end
