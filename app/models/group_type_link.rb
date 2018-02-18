class GroupTypeLink < ApplicationRecord
  belongs_to :grouping_type
  belongs_to :grouping
end
