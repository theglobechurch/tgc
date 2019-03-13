class AddEventTags < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :flag, :string
    add_column :event_instances, :flag, :string

    add_index :events, :flag
    add_index :event_instances, :flag
  end
end
