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
      t.string :background_image_uid
      t.string :background_image_thumbnail_uid
      t.string :background_image_thumbnail_2x_uid
      [320, 640, 960, 1280, 1920, 2560].each do |size|
        t.string :"background_image_#{size}_uid"
      end
      t.timestamps
    end

    create_table :uploads do |t|
      t.string :file_uid, null: false
      t.string :filesize
      t.jsonb :meta, null: false, default: '{}'
      t.timestamps
    end
    add_index  :uploads, :meta, using: :gin

    # At some point we may want to relate resources to themselves…
    # …will deal with that headache another time
    create_table :resources do |t|
      t.string :title, null: false
      t.string :state, default: 'draft'
      t.string :resource_type, null: false, index: true # recording | page | blog | download | link
      t.string :external_reference # may be a link to a third part website?
      t.text :body
      t.text :introduction
      t.string :slug, index: true, unique: true
      t.datetime :published_at
      t.datetime :display_date
      t.timestamps

      t.belongs_to :people, index: true, foreign_key: true
      t.belongs_to :graphics, index: true, foreign_key: true
      t.belongs_to :uploads, index: true, foreign_key: true
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
      t.string :group_type, null: false, index: true # series | resource | etc      
      t.datetime :start_date
      t.datetime :end_date
      t.string :slug, index: true, unique: true
      t.string :state, default: 'draft'
      t.datetime :published_at
      t.timestamps

      t.belongs_to :graphics, index: true, foreign_key: true
    end

    create_table :resource_grouping_joins do |t|
      t.integer :resource_id, index: true
      t.integer :grouping_id, index: true
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

    ### DEVISE SETUP
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
