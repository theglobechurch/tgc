module HasGroupType
  extend ActiveSupport::Concern

  GROUP_TYPES = %w[series resource].freeze

  included do
    delegate :GROUP_TYPES, to: :class
  end

  class_methods do
    def available_group_types
      self::GROUP_TYPES
    end
  end
end
