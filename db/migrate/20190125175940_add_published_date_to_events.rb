class AddPublishedDateToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :published_at, :datetime
  end
end
