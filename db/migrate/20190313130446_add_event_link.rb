class AddEventLink < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :link_url, :text
    add_column :event_instances, :link_url, :text
  end
end
