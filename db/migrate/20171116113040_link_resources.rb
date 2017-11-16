class LinkResources < ActiveRecord::Migration[5.1]
  # Create self-join to allow resources to link to resources
  def change
    add_column :resources, :parent_resource_id, :integer
    add_index :resources, :parent_resource_id
  end
end
