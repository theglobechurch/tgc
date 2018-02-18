class EventInstance < ApplicationRecord

  include HasSlug

  belongs_to :event

  def to_s
    title
  end

end
