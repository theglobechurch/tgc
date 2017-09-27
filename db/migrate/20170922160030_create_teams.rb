class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.text :description
      t.belongs_to :teams, index: true, foreign_key: true
    end

    create_join_table :people, :teams do |t|
      t.primary_key :id
      t.index :person_id
      t.index :team_id
      t.jsonb :meta
    end
  end
end
