class CreateLivestreams < ActiveRecord::Migration[5.2]
  def change
    create_table :livestreams do |t|
      t.string :youtubeId
      t.datetime :live_at

      t.timestamps
    end
  end
end
