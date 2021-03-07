xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "The Globe Church"
    xml.description "Blog"
    xml.link root_url

    @articles.each do |article|
      xml.item do
        xml.title article.title
        xml.slug article.slug
        xml.introduction article.introduction
        xml.passage article.reference_string
        xml.author do
          xml.name article.person.display_name
          xml.slug article.person.slug
          xml.bio article.person.biography_short
          xml.image request.base_url + article.person.avatar_original.remote_url
        end
        xml.lead_image request.base_url + article.lead_image[:'2560']
        xml.tag!("description") { xml.cdata!(render article.body) }
        xml.pubDate article.published_at.to_s(:rfc822)
        xml.link resource_url(article)
        xml.guid resource_url(article)
      end
    end
  end
end
