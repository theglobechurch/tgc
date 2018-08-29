title = "Recordings from The Globe Church"
author = "The Globe Church"
description = "The Globe Church is all about Jesus. The Globe Church is made up of all sorts of people. The Globe Church is involved in the greatest mission."
keywords = "The Globe Church, Sermon, Recordings, Church"
email = "info@globe.church"
image = root_url + "assets/podcast-cover.jpg"

xml.instruct! :xml, version: "1.0"
xml.rss "xmlns:itunes": "http://www.itunes.com/dtds/podcast-1.0.dtd",
        "xmlns:media": "http://search.yahoo.com/mrss/",
        "xmlns:ppg": "http://bbc.co.uk/2009/01/ppgRss",
        "xmlns:atom": "http://www.w3.org/2005/Atom",
        :version => "2.0" do
  xml.channel do
    xml.title title
    xml.description description
    xml.language 'en-gb'
    xml.pubDate @recordings.first.display_date.to_s(:rfc822)
    xml.lastBuildDate @recordings.first.display_date.to_s(:rfc822)
    xml.link root_url
    xml.image do
      xml.url image
      xml.title title
      xml.link root_url
    end
    xml.itunes :author, author
    xml.itunes :summary, description
    xml.itunes :keywords, keywords
    xml.itunes :explicit, 'no'
    xml.itunes :image, href: image
    xml.itunes :owner do
      xml.itunes :name, author
      xml.itunes :email, email
    end
    xml.itunes :block, 'no'
    xml.itunes :category, :text => 'Religion & Spirituality' do
      xml.itunes :category, :text => 'Christianity'
    end

    @recordings.each do |recording|
      recording_url = root_url + recording.upload.file.remote_url[1..-1]
      xml.item do
        xml.title recording.title
        xml.description recording.introduction
        xml.pubDate recording.display_date.to_s(:rfc822)
        xml.link resource_url(recording)
        xml.guid resource_url(recording)
        xml.enclosure url: recording_url, length: recording.upload.filesize, type: 'audio/mpeg'
        xml.ppg :enclosureLegacy, url: recording_url, length: recording.upload.filesize, type: 'audio/mpeg'
        xml.ppg :enclosureSecure, url: recording_url, length: recording.upload.filesize, type: 'audio/mpeg'
        xml.media :content, url: recording_url, fileSize: recording.upload.filesize, type: 'audio/mpeg'#, duration: ###
        xml.itunes :explicit, 'clean'
        xml.itunes :author, recording.person.display_name
        xml.itunes :subtitle, truncate(recording.introduction, length: 150)
        xml.itunes :summary, recording.introduction
        xml.itunes :explicit, 'no'
        # xml.itunes :duration, recording.duration
      end
    end
  end
end
