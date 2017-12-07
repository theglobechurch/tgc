module HasState
  extend ActiveSupport::Concern

  def before_publishing
    self.published_at = Time.zone.now
    
    unless self.display_date
      self.display_date = Time.zone.now
    end
  end

  class_methods do
    def publishable
      state_machine initial: :draft do
        event :publish do
          transition draft: :published
        end

        event :expunge do
          transition %i[draft published] => :expunged
        end

        event :unexpunge do
          transition expunged: :draft
        end

        event :unpublish do
          transition published: :draft
        end

        before_transition any => :published, do: :before_publishing

      end

      %w[draft published expunged].each do |state|
        scope state, -> { with_state(state) }
      end

      scope :non_deleted, -> { without_state(:expunged) }
    end
  end

end
