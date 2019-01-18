# rubocop:disable LineLength
class AddCalendar < ActiveRecord::Migration[5.1]
  def change
    rename_table :event_series, :events
    rename_column :event_instances, :event_series_id, :event_id

    create_table :grouping_types do |t|
      t.string :title
      t.string :slug
      t.index :slug
    end
    
    create_table :group_type_links, id: false do |t|
      t.integer :grouping_id, null: false
      t.integer :grouping_type_id, null: false
      t.index [:grouping_id, :grouping_type_id]
      t.index [:grouping_type_id, :grouping_id]
    end

    create_table :group_event_links, id: false do |t|
      t.integer :grouping_id, null: false
      t.integer :event_id, null: false
      t.index [:grouping_id, :event_id]
      t.index [:event_id, :grouping_id]
    end

    add_column :events, :state, :string, default: 'draft'

  end
  
  def data
    # Add in a default set of records into grouping types
    GroupingType.create!([
      { title: "Preaching" },
      { title: "Focus" },
      { title: "Misc" }
    ])
    
    # Link all current groupings to preaching
    preaching = GroupingType.where(title: "Preaching").take
    Grouping.all.each do |g|
      g.grouping_types << preaching
    end


  end 

end
