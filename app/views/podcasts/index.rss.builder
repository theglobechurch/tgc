title = "Recordings from The Globe Church"
author = "The Globe Church"
description = "The Globe Church is all about Jesus. The Globe Church is made up of all sorts of people. The Globe Church is involved in the greatest mission."
keywords = "The Globe Church, Sermon, Recordings, Church"
email = "info@globe.church"
image = root_url + "img/podcast-cover.jpg"

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title title
    xml.description description
    xml.language 'en'
    xml.pubDate @recordings.first.published_at.to_s(:rfc822)
    xml.lastBuildDate @recordings.first.published_at.to_s(:rfc822)
    xml.link root_url
    xml.itunes :author, author
    xml.itunes :keywords, keywords
    xml.itunes :explicit, 'clean'
    xml.itunes :image, href: image
    xml.itunes :owner do
      xml.itunes :name, author
      xml.itunes :email, email
    end
    xml.itunes :block, 'no'
    xml.itunes :category, :text => 'News & Politics' do
      xml.itunes :category, :text => 'Religion & Spirituality' do
        xml.itunes :category, :text => 'Christianity'
      end
    end

    @recordings.each do |recording|
      xml.item do
        xml.title recording.title
        xml.description recording.introduction
        xml.pubDate recording.published_at.to_s(:rfc822)
        xml.link resource_url(recording)
        xml.guid resource_url(recording)
        xml.enclosure url: recording.upload.file.remote_url, length: recording.upload.filesize, type: 'audio/mpeg'
        xml.ppg :enclosureLegacy, url: recording.upload.file.remote_url, length: recording.upload.filesize, type: 'audio/mpeg'
        xml.ppg :enclosureSecure, url: recording.upload.file.remote_url, length: recording.upload.filesize, type: 'audio/mpeg'
        xml.media :content, url: recording.upload.file.remote_url, fileSize: recording.upload.filesize, type: 'audio/mpeg'#, duration: ###
        xml.itunes :explicit, 'clean'
        xml.itunes :author, recording.person.display_name
        xml.itunes :subtitle, truncate(recording.introduction, :length => 150)
        xml.itunes :summary, recording.introduction
        xml.itunes :explicit, 'no'
        # xml.itunes :duration, recording.duration
      end
    end
  end
end
