# rubocop:disable Style/PercentLiteralDelimiters
Rails.application.configure do
  config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
    # Will be replaced with new features soon
    r302 %r[^/calendar/?$], '/when-and-where'
    r302 %r[^/markdrama/?$], 'https://www.eventbrite.co.uk/e/the-mark-drama-tickets-42989512790'

    # Welcome pack links
    r301 %r[^/sundays?/?$], '/when-and-where#section:sundays'
    r301 %r[^/focus/?$], '/when-and-where#section:bible-study'
    r301 %r[^/prayer/?$], '/when-and-where#section:prayer-meeting'
    r301 %r[^/membership/?$], '/get-involved#section:membership'

    # Old site redirects
    r301 %r[^/join-us/?$], '/about'
    r301 %r[^/directions/?$], '/when-and-where'
    r301 %r[^/partner-with-us/?$], '/get-involved'
    r302 %r[^/jonty-allcock/?$], '/people/jonty-allcock'
    r302 %r[^/phil-tinker/?$], '/people/phil-tinker'
    r302 %r[^/trevor-archer/?$], '/people/trevor-archer'
  end
end
