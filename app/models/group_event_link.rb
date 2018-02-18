class GroupEventLink < ApplicationRecord
  belongs_to :event
  belongs_to :grouping
end
