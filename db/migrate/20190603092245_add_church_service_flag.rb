class AddChurchServiceFlag < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :church_service, :boolean
  end
end
