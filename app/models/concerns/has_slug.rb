module HasSlug

  extend ActiveSupport::Concern

  included do
    validates :slug, presence: true,
                     format: {with: /\A[[:lower:][:digit:]]
                                       [-[:lower:][:digit:]]*
                                       [[:lower:][:digit:]]\z/x},
                     uniqueness: true
    validate :validate_slug_unchanged

    delegate :generate_slug_from, to: :class
  end

  def to_param
    slug
  end

  def slug_can_be_changed?
    !(respond_to?(:published_at) ? published_at? : persisted?)
  end

  class_methods do
    def slug_find(s)
      find_by! slug: s
    end

    def generate_slug_from
      :title
    end
  end

private

  def validate_slug_unchanged
    if slug_changed? && !slug_was.nil? && !slug_can_be_changed?
      errors.add :slug, :cannot_be_changed_after_publication
    end
  end

end
