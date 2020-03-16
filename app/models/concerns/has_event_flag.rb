module HasEventFlag
  extend ActiveSupport::Concern

  included do
    enum flag: {
      featured: "Featured",
      comission: "Co-Mission",
      fiec: "FIEC",
      monthly: "Monthly",
      social: "Social",
      special: "Special event",
      cancelled: "Cancelled"
    }, _prefix: :flag

    def event_tag
      self.class.flags[flag]
    end
  end
end
