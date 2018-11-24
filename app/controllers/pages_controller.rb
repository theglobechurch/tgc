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
    if params[:id] == 'about/team'
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
        "subtitle" => 'The Globe Church is all about sharing the good news of Jesus Christ to those living, working or visiting the Southbank of London.',
        "image" => {
          "320": view_context.asset_path("static-banner/about/mark-drama_320.jpg"),
          "640": view_context.asset_path("static-banner/about/mark-drama_640.jpg"),
          "960": view_context.asset_path("static-banner/about/mark-drama_960.jpg"),
          "1280": view_context.asset_path("static-banner/about/mark-drama_1280.jpg"),
          "1920": view_context.asset_path("static-banner/about/mark-drama_1920.jpg"),
          "2560": view_context.asset_path("static-banner/about/mark-drama_2560.jpg"),
        },
      }
    when 'about/team'
      {
        "title" => 'Elders and Staff',
        "subtitle" => 'The Globe Church is about the whole church family living as disciples of Christ, but a few people have especially committed to serve the church and work to see its vision flourish…',
        "image" => {
          "320": view_context.asset_path("static-banner/about/staff_320.jpg"),
          "640": view_context.asset_path("static-banner/about/staff_640.jpg"),
          "960": view_context.asset_path("static-banner/about/staff_960.jpg"),
          "1280": view_context.asset_path("static-banner/about/staff_1280.jpg"),
          "1920": view_context.asset_path("static-banner/about/staff_1920.jpg"),
          "2560": view_context.asset_path("static-banner/about/staff_2560.jpg"),
        },
      }
    when 'about/doctrinal-basis'
      {
        "title" => 'What we believe',
        "subtitle" => 'Doctrinal basis',
        "size" => 'small',
        "image" => {
          "320": view_context.asset_path("static-banner/the-globe-church-blog_320.jpg"),
          "640": view_context.asset_path("static-banner/the-globe-church-blog_640.jpg"),
          "960": view_context.asset_path("static-banner/the-globe-church-blog_960.jpg"),
          "1280": view_context.asset_path("static-banner/the-globe-church-blog_1280.jpg"),
          "1920": view_context.asset_path("static-banner/the-globe-church-blog_1920.jpg"),
          "2560": view_context.asset_path("static-banner/the-globe-church-blog_2560.jpg"),
        },
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
    when 'weekofprayer'
      {
        "title" => 'Week of Prayer',
        "subtitle" => '3rd – 8th December',
        "image" => {
          "320": view_context.asset_path("static-banner/weekofprayer_320.jpg"),
          "640": view_context.asset_path("static-banner/weekofprayer_640.jpg"),
          "960": view_context.asset_path("static-banner/weekofprayer_960.jpg"),
          "1280": view_context.asset_path("static-banner/weekofprayer_1280.jpg"),
          "1920": view_context.asset_path("static-banner/weekofprayer_1920.jpg"),
          "2560": view_context.asset_path("static-banner/weekofprayer_2560.jpg"),
        },
      }
    when 'privacy'
      {
        "title" => 'Privacy Policy',
        "subtitle" => 'Where your data is kept and how it is used…',
      }
    else
      {
        "title" => 'The Globe Church',
        "subtitle" => 'A church for the Southbank',
      }
    end
  end

end
