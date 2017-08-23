# rubocop:disable Metrics/LineLength
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
        "subtitle" => 'The Globe Church is all about sharing the good news of Jesus Christ to those living and working on the Southbank of London.',
      }
    when 'about/jesus'
      {
        "title" => 'All about Jesus…',
      }
    when 'when-and-where'
      {
        "title" => 'When and where',
      }
    when 'contact'
      {
        "title" => 'Get in touch',
        "subtitle" => 'Got a question? New in the area? Just want to find out more? We\'d love talk.',
        "image" => {
          "320": view_context.asset_url("static-banner/contact/contact_320.jpg"),
          "640": view_context.asset_url("static-banner/contact/contact_640.jpg"),
          "960": view_context.asset_url("static-banner/contact/contact_960.jpg"),
          "1280": view_context.asset_url("static-banner/contact/contact_1280.jpg"),
          "1920": view_context.asset_url("static-banner/contact/contact_1920.jpg"),
          "2560": view_context.asset_url("static-banner/contact/contact_2560.jpg"),
        },
      }
    else
      {
        "title" => 'The Globe Church',
        "subtitle" => 'A church for the Southbank',
      }
    end
  end

end
