HighVoltage.configure do |config|
  config.routes = false
  config.route_drawer = HighVoltage::RouteDrawers::Root
  config.content_path = 'static/'
end
