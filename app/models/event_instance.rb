class EventInstance < ApplicationRecord

  # include HasSlug

  belongs_to :event, optional: true

  belongs_to :graphic,
             optional: true,
             foreign_key: :graphics_id

  validate :end_after_start
  validates :start_datetime, :end_datetime, :presence => true

  def to_s
    title
  end

private
  def end_after_start
    return if end_datetime.blank? || start_datetime.blank?
   
    if end_datetime < start_datetime
      errors.add(:end_datetime, "must be after the start date") 
    end 
   end
end
