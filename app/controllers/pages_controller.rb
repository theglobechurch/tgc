# rubocop:disable Metrics/LineLength,Metrics/MethodLength,Metrics/AbcSize,Metrics/CyclomaticComplexity
class PagesController < ApplicationController
  include HighVoltage::StaticPage

  # before_filter :authenticate
  # layout :layout_for_page

  @banner = :banner

  helper_method :additional

  def additional
    @additional = page_data
  end

private

  def page_data
    if params[:id] == 'about'
      {
        'eldership': Person.team('Eldership'),
        'staff': Person.team('Staff'),
      }
    end
  end

  def banner
    case params[:id]
    when 'about'
      {
        "title" => 'About',
        "image" => {
          "320": view_context.asset_path("static-banner/church_320.jpg"),
          "640": view_context.asset_path("static-banner/church_640.jpg"),
          "960": view_context.asset_path("static-banner/church_960.jpg"),
          "1280": view_context.asset_path("static-banner/church_1280.jpg"),
          "1920": view_context.asset_path("static-banner/church_1920.jpg"),
          "2560": view_context.asset_path("static-banner/church_2560.jpg"),
        },
      }
    when 'about/doctrinal-basis'
      {
        "title" => 'What we believe',
        "subtitle" => 'Doctrinal basis',
        "size" => 'small',
      }
    when 'when-and-where'
      {
        "title" => 'What we do',
        "image" => {
          "320": view_context.asset_path("static-banner/about_320.jpg"),
          "640": view_context.asset_path("static-banner/about_640.jpg"),
          "960": view_context.asset_path("static-banner/about_960.jpg"),
          "1280": view_context.asset_path("static-banner/about_1280.jpg"),
          "1920": view_context.asset_path("static-banner/about_1920.jpg"),
          "2560": view_context.asset_path("static-banner/about_2560.jpg"),
        },
      }
    when 'get-involved'
      {
        "title" => 'Get involved',
        "image" => {
          "320": view_context.asset_path("static-banner/the-globe-church-training_320.jpg"),
          "640": view_context.asset_path("static-banner/the-globe-church-training_640.jpg"),
          "960": view_context.asset_path("static-banner/the-globe-church-training_960.jpg"),
          "1280": view_context.asset_path("static-banner/the-globe-church-training_1280.jpg"),
          "1920": view_context.asset_path("static-banner/the-globe-church-training_1920.jpg"),
          "2560": view_context.asset_path("static-banner/the-globe-church-training_2560.jpg"),
        },
      }
    when 'contact'
      {
        "title" => 'Get in touch',
        "subtitle" => 'Got a question? New in the area? Just want to find out more? We\'d love talk.',
        "image" => {
          "320": view_context.asset_path("static-banner/contact/contact_320.jpg"),
          "640": view_context.asset_path("static-banner/contact/contact_640.jpg"),
          "960": view_context.asset_path("static-banner/contact/contact_960.jpg"),
          "1280": view_context.asset_path("static-banner/contact/contact_1280.jpg"),
          "1920": view_context.asset_path("static-banner/contact/contact_1920.jpg"),
          "2560": view_context.asset_path("static-banner/contact/contact_2560.jpg"),
        },
      }
    when 'christmas'
      {
        "title" => 'Christmas 2017',
        "subtitle" => 'Carol services near London Bridge and Waterloo',
        "image" => {
          "320": view_context.asset_path("static-banner/christmas/christmas_320.jpg"),
          "640": view_context.asset_path("static-banner/christmas/christmas_640.jpg"),
          "960": view_context.asset_path("static-banner/christmas/christmas_960.jpg"),
          "1280": view_context.asset_path("static-banner/christmas/christmas_1280.jpg"),
          "1920": view_context.asset_path("static-banner/christmas/christmas_1920.jpg"),
          "2560": view_context.asset_path("static-banner/christmas/christmas_2560.jpg"),
        },
      }
    when 'wonder'
      {
        "title" => 'Have You Ever Wondered?',
        "subtitle" => 'When we were kids, there was one thing we used to be good at: WONDER',
        "image" => {
          "320": view_context.asset_path("static-banner/wonder/have-you-ever-wondered_320.jpg"),
          "640": view_context.asset_path("static-banner/wonder/have-you-ever-wondered_640.jpg"),
          "960": view_context.asset_path("static-banner/wonder/have-you-ever-wondered_960.jpg"),
          "1280": view_context.asset_path("static-banner/wonder/have-you-ever-wondered_1280.jpg"),
          "1920": view_context.asset_path("static-banner/wonder/have-you-ever-wondered_1920.jpg"),
          "2560": view_context.asset_path("static-banner/wonder/have-you-ever-wondered_2560.jpg"),
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
