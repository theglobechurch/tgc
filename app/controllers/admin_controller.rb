class AdminController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  layout 'admin'

  def index; end

private

  def allow_page_caching
    # Nope nope nope
  end

end
