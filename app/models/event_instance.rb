class EventInstance < ApplicationRecord

  include HasSlug

  belongs_to :event, optional: true

  def to_s
    title
  end

end
