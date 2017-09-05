class Person < ApplicationRecord
  self.table_name = "people"

  before_validation do |r|
    r.slug = "#{first_name} #{last_name}".parameterize if r.slug.blank?
    r.display_name = "#{first_name} #{last_name}" if r.display_name.blank?
  end

  include HasSlug # Validate slug and lookup by slug rather than id

  default_scope { order(last_name: :asc) }

  validates :first_name, :last_name, presence: true

  has_many :resources

  def to_s
    "#{first_name} #{last_name}"
  end

end
