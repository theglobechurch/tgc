class PagesController < ApplicationController
  include HighVoltage::StaticPage

  # before_filter :authenticate
  # layout :layout_for_page

  @banner = :banner

private

  def banner
    case params[:id]
    when 'about'
      {
        "title" => 'About',
        "subtitle" => 'The Globe Church is all about sharing the good news of Jesus Christ to those living and working on the Southbank of London.'
      }
    when 'about/jesus'
      {
        "title" => 'All about Jesus…'
      }
    when 'contact'
      {
        "title" => 'Get in touch',
        "subtitle" => 'Got a question? New in the area? Just want to find out more? We\'d love talk.'
      }
    else
      {
        "title" => 'The Globe Church',
        "subtitle" => 'A church for the Southbank'
      }
    end
  end

end
