class UploadSerializer < ActiveModel::Serializer
  attributes :id, :url, :meta, :filesize

  def url
    object.file.try(:remote_url)
  end

end
