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
        if article.bible_reference_json.present?
          xml.passage do
            xml.full article.reference_string
            xml.book article.bible_reference_json['reference_book']
            xml.start_chapter article.bible_reference_json['reference_book_start_ch']
            xml.start_verse article.bible_reference_json['reference_book_start_v']
            xml.end_chapter article.bible_reference_json['reference_book_end_ch']
            xml.end_verse article.bible_reference_json['reference_book_end_v']
          end
        end
        if article.person
          xml.author do
            xml.name article.person.display_name
            xml.slug article.person.slug
            xml.bio article.person.biography_short
            if article.person.avatar_original.present?
              xml.image request.base_url + article.person.avatar_original.remote_url
            end
          end
        end
        if article.lead_image
          xml.lead_image request.base_url + article.lead_image[:'2560']
        end
        if article.body.present?
          xml.tag!("description") { xml.cdata!(render article.body) }
        end
        if article.groupings.present?
          xml.series do
            xml.title article.groupings[0].title
            xml.description article.groupings[0].description
            xml.slug article.groupings[0].slug
            if article.groupings[0].graphic.present?
              xml.graphic request.base_url + article.groupings[0].graphic.background_image.remote_url
            end
          end
        end
        xml.pubDate article.published_at.to_s(:rfc822)
        xml.link resource_url(article)
        xml.guid resource_url(article)
      end
    end
  end
end
