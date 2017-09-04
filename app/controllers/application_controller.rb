class ApplicationController < ActionController::Base
  before_action :allow_page_caching
  protect_from_forgery with: :exception
  respond_to :html
  layout 'application'

  attr_accessor :banner
  helper_method :banner

  def banner
    @banner || {}
  end

private

  def allow_page_caching
    expires_in(15.minutes, public: true) if Rails.env.production?
  end

end
