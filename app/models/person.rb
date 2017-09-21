class Person < ApplicationRecord
  self.table_name = "people"

  SIZES = [150, 300, 600].freeze

  before_validation do |r|
    r.slug = "#{first_name} #{last_name}".parameterize if r.slug.blank?
    r.display_name = "#{first_name} #{last_name}" if r.display_name.blank?
  end

  include HasSlug # Validate slug and lookup by slug rather than id

  default_scope { order(last_name: :asc) }

  validates :first_name, :last_name, presence: true

  has_many :resources

  sir_trevor_content :biography

  SIZES.each do |size|
    dragonfly_accessor :"avatar_#{size}"
  end
  dragonfly_accessor :avatar_original do
    SIZES.each do |size|
      copy_to(:"avatar_#{size}") do |a|
        a.thumb("#{size}x#{size}#").encode('jpg')
      end
    end
  end

  def to_s
    "#{first_name} #{last_name}"
  end

end
