class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  respond_to :html
  layout 'application'

  attr_accessor :banner
  helper_method :banner

  def banner
    @banner || { 'title' => 'The Globe Church' }
  end
end
