require File.expand_path('../../config/environment', __dir__)
require 'rails/test_help'
# Rails.application.load_seed

# Simple seed data
GroupingType.delete_all
GroupingType.create(title: 'Preaching')
GroupingType.create(title: 'Focus')

FactoryBot::SyntaxRunner.class_eval do
  include ActionDispatch::TestProcess
end

Dir.glob(Rails.root.join('test', 'helpers', '*.rb')).each do |f|
  require f
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in
  # alphabetical order.
  fixtures :all
  include FactoryBot::Syntax::Methods
end

# Monkey-patch dragonfly for speed
require 'dragonfly/content'
module Dragonfly
  class Content
    # Skip image processing (resizing etc) in tests.
    def shell_update(*)
      self
    end
  end
end
