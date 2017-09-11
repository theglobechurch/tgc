# rubocop:disable Style/PercentLiteralDelimiters
Rails.application.configure do
  config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
    # Will be replaced with new features soon
    r302 %r[^/calendar/?$], '/when-and-where'
    r302 %r[^/blog/?$], '/'
    r302 %r[^/jonty-allcock/?$], '/'
    r302 %r[^/phil-tinker/?$], '/'
    r302 %r[^/trevor-archer/?$], '/'

    # Welcome pack links
    r301 %r[^/sundays?/?$], '/when-and-where#section:sundays'
    r301 %r[^/focus/?$], '/when-and-where#section:bible-study'
    r301 %r[^/prayer/?$], '/when-and-where#section:prayer-meeting'
    r301 %r[^/membership/?$], '/get-involved#section:membership'

    # Old site redirects
    r301 %r[^/join-us/?$], '/about'
    r301 %r[^/directions/?$], '/when-and-where'
    r301 %r[^/partner-with-us/?$], '/get-involved'
  end
end
