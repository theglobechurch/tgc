class Person < ApplicationRecord
  self.table_name = "people"

  include HasSlug # Validate slug and lookup by slug rather than id

  default_scope { order(last_name: :asc) }

  validates :first_name, :last_name, presence: true

  def to_s
    "#{first_name} #{last_name}"
  end

end
