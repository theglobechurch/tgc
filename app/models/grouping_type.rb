class GroupingType < ApplicationRecord
  self.table_name = "grouping_types"

  include HasSlug

  has_many :group_type_links
  has_many :groupings,
           through: :group_type_links

  validates :title, presence: true

  def to_s
    title
  end

end
