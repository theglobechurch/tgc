class Location < ApplicationRecord
  self.table_name = "locations"

  default_scope { order('name ASC') }

  before_validation do |l|
    l.name = l.name.titleize
    l.address_line_1 = l.address_line_1.titleize
    l.address_line_2 = l.address_line_2.titleize
    l.city = l.city.titleize
    l.code = l.code.upcase
  end

  def to_s
    "#{name}, #{address_line_1}, #{address_line_2}, #{city}, #{code}"
  end

  def location_str
    to_s
  end

end
