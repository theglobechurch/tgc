module HasResourceType
  extend ActiveSupport::Concern

  RESOURCE_TYPES = %w[recording page blog download link].freeze

  included do
    delegate :RESOURCE_TYPES, to: :class
  end

  class_methods do
    def available_resource_types
      self::RESOURCE_TYPES
    end
  end
end
