class AdminController < ApplicationController
  respond_to :html
  before_action :authenticate_user!

  layout 'admin'

  def index
    @graphic = Graphic.all
  end

end
