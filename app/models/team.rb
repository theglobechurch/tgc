class Team < ApplicationRecord

  default_scope { order(name: :asc) }

  validates :name, presence: true

  has_many :people_team
  has_many :people,
           through: :people_team

  sir_trevor_content :description

  def to_s
    name
  end

end
