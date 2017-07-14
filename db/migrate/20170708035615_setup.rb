class Setup < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :code
      t.string :url
      t.timestamps
    end

    create_table :people do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :display_name
      t.string :job_title
      t.string :biography_short
      t.text :biography
      t.string :avatar_original_uid
      [150, 300, 600].each do |size|
        t.string :"avatar_#{size}_uid"
      end
      t.boolean :page # Does this person have a page about them?
      t.string :slug, index: true, unique: true
      t.timestamps # Automagically add created_at and updated_at

      t.belongs_to :location, index: true, foreign_key: true
    end

    create_table :graphics do |t|
      t.string :background_image_thumbnail_uid
      [320, 640, 960, 1280, 1920, 2560].each do |size|
        t.string :"background_image_#{size}_uid"
      end
    end

    # At some point we may want to relate resources to themselves…
    # …will deal with that headache another time
    create_table :resources do |t|
      t.string :title, null: false
      t.string :resource_type, null: false, index: true # recording | page | blog | download | link
      t.string :upload_uid
      t.string :external_reference # may be a link to a third part website?
      t.text :body
      t.text :introduction
      t.string :slug, index: true, unique: true
      t.timestamps

      t.belongs_to :people, index: true, foreign_key: true
      t.belongs_to :graphics, index: true, foreign_key: true
    end

    # Might not be needed...
    create_table :resources_meta do |t|
      t.string :meta_key, index: true, null: false
      t.text :meta_value, null: false

      t.belongs_to :resources, index: true, foreign_key: true
    end

    create_table :groupings do |t|
      t.string :title, null: false
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end

    create_table :event_series do |t|
      t.string :title
      t.text :description
      t.string :slug, index: true, unique: true

      t.belongs_to :location, index: true, foreign_key: true
      t.belongs_to :graphics, index: true, foreign_key: true
    end
    
    create_table :event_instances do |t|
      t.belongs_to :event_series, index: true, foreign_key: true
      t.belongs_to :location, index: true, foreign_key: true
      t.belongs_to :graphics, index: true, foreign_key: true

      t.datetime :start_datetime
      t.datetime :end_datetime

      t.string :title
      t.text :description

      t.string :slug, index: true, unique: true
    end

    create_join_table :series, :resources, table_name: :series_resources do |t|
      t.index :series_id
      t.index :resource_id
    end
  end
end
