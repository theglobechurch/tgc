class Admin::ResourceSerializer < ActiveModel::Serializer
  attributes :id, :title, :resource_type, :slug
end
