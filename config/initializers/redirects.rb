# rubocop:disable Style/PercentLiteralDelimiters
Rails.application.configure do
  config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
    # Will be replaced with new features soon
    r302 %r[^/calendar/?$], '/events'
    r302 %r[^/markdrama/?$], 'https://www.eventbrite.com/e/the-mark-drama-tickets-42989512790?aff=tgc'
    r302 %r[^/stewardship/?$], 'https://www.give.net/20181404'

    # Welcome pack links
    r301 %r[^/sundays?/?$], '/events#section:sundays'
    r301 %r[^/focus/?$], '/events#section:bible-study'
    r301 %r[^/prayer/?$], '/events#section:prayer-meeting'
    r301 %r[^/membership/?$], '/get-involved#section:membership'
    r301 %r[^/giving/?$], '/get-involved#section:giving'
    r301 %r[^/one21/?$], '/resources/one21-launch'

    # Old site redirects
    r301 %r[^/join-us/?$], '/about'
    r301 %r[^/directions/?$], '/events'
    r301 %r[^/partner-with-us/?$], '/get-involved'
    r302 %r[^/jonty-allcock/?$], '/people/jonty-allcock'
    r302 %r[^/phil-tinker/?$], '/people/phil-tinker'
    r302 %r[^/trevor-archer/?$], '/people/trevor-archer'
  end
end
