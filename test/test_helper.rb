require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

FactoryGirl::SyntaxRunner.class_eval do
  include ActionDispatch::TestProcess
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in
  # alphabetical order.
  fixtures :all
  include FactoryGirl::Syntax::Methods
  # Add more helper methods to be used by all tests here...
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
