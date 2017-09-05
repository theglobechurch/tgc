module Admin::BibleHelper

  OT = [
    "Genesis", "Exodus",
    "Leviticus", "Numbers",
    "Deuteronomy", "Joshua",
    "Judges", "Ruth",
    "1 Samuel", "2 Samuel",
    "1 Kings", "2 Kings",
    "1 Chronicles", "2 Chronicles",
    "Ezra", "Nehemiah",
    "Esther", "Job",
    "Psalms", "Proverbs",
    "Ecclesiastes", "Song of Solomon",
    "Isaiah", "Jeremiah",
    "Lamentations", "Ezekiel",
    "Daniel", "Hosea",
    "Joel", "Amos",
    "Obadiah", "Jonah",
    "Micah", "Nahum",
    "Habakkuk", "Zephaniah",
    "Haggai", "Zechariah",
    "Malachi"
  ].freeze

  NT = [
    "Matthew", "Mark",
    "Luke", "John",
    "Acts", "Romans",
    "1 Corinthians", "2 Corinthians",
    "Galatians", "Ephesians",
    "Philippians", "Colossians",
    "1 Thessalonians", "2 Thessalonians",
    "1 Timothy", "2 Timothy",
    "Titus", "Philemon",
    "Hebrews", "James",
    "1 Peter", "2 Peter",
    "1 John", "2 John",
    "3 John", "Jude",
    "Revelation"
  ].freeze

  def book_picker(f, testaments = 'both')
    if testaments != 'both'
      books = OT if testaments == 'ot'
      books = NT if testaments == 'nt'
    else
      books = OT + NT
    end

    f.select("reference_book",
             books,
             {selected: f.object.bible_reference['reference_book'],
              include_blank: true},
             class: 'form__input form__input--select')
  end

  def reference_picker(f, html_options = {})
    content_tag(:div, html_options) do
      concat(book_picker(f))
      concat(
        f.text_field(:reference_book_start_ch,
                     value: f.object.bible_reference['reference_book_start_ch'],
                     class: 'form__input',
                     placeholder: 'Start chapter')
      )
      concat(
        f.text_field(:reference_book_start_v,
                     value: f.object.bible_reference['reference_book_start_v'],
                     class: 'form__input',
                     placeholder: 'Start verse')
      )
      concat(
        f.text_field(:reference_book_end_ch,
                     value: f.object.bible_reference['reference_book_end_ch'],
                     class: 'form__input',
                     placeholder: 'End chapter')
      )
      concat(
        f.text_field(:reference_book_end_v,
                     value: f.object.bible_reference['reference_book_end_v'],
                     class: 'form__input',
                     placeholder: 'End verse')
      )
    end
  end

end
