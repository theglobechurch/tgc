module HasBibleReference
  extend ActiveSupport::Concern

  class_methods do
    def inc_bible_reference
      attr_accessor :bible_ref,
                    :reference_book,
                    :reference_book_start_ch,
                    :reference_book_end_ch,
                    :reference_book_start_v,
                    :reference_book_end_v

      validates :reference_book_start_ch,
                :reference_book_end_ch,
                :reference_book_start_v,
                :reference_book_end_v, numericality: {
                  only_integer: true,
                  allow_blank: true,
                }

      before_save do |r|
        if reference_book.present?
          r.bible_reference_json = {
            reference_book: reference_book,
            reference_book_start_ch: reference_book_start_ch,
            reference_book_start_v: reference_book_start_v,
            reference_book_end_ch: reference_book_end_ch,
            reference_book_end_v: reference_book_end_v,
          }
        end
      end
    end

  end

  def bible_reference
    if bible_reference_json.present?
      bible_reference_json
    else
      {}
    end
  end

  def reference_string
    if bible_reference_json.present?
      br = bible_reference
      if br['reference_book_start_ch'].blank?
        br['reference_book'].to_s
      elsif br['reference_book_start_ch'] == br['reference_book_end_ch']
        "#{br['reference_book']} #{br['reference_book_start_ch']}:"\
        "#{br['reference_book_start_v']}-#{br['reference_book_end_v']}"
      else
        "#{br['reference_book']} #{br['reference_book_start_ch']}:"\
        "#{br['reference_book_start_v']}-#{br['reference_book_end_ch']}:"\
        "#{br['reference_book_end_v']}"
      end
    end
  end

end
