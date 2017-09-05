class AddBibleReferenceToResource < ActiveRecord::Migration[5.1]
  def change
    add_column :resources, :bible_reference_json, :jsonb
  end
end
