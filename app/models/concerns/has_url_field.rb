require 'uri'

module HasUrlField
  extend ActiveSupport::Concern

  class_methods do
    def url_field(key)

      if key.present?
        validates key, http_url: true
      end

    end
  end
  
end

class HttpUrlValidator < ActiveModel::EachValidator

  def self.compliant?(value)
    uri = URI.parse(value)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  def validate_each(record, attribute, value)
    
    unless value.empty? || (value.present? && self.class.compliant?(value))
      record.errors.add(attribute, "is not a valid HTTP URL")
    end
  end

end
