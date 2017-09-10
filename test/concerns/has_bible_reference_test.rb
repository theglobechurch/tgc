# rubocop:disable Metrics/BlockLength
require 'test_helper'

class HasBibleReferenceTest < ActiveSupport::TestCase

  test_case_per_class_that_includes(HasBibleReference) do

    test "formats bible reference" do
      c = create_cls(reference_book: "Philemon",
                     reference_book_start_ch: 1,
                     reference_book_start_v: 1,
                     reference_book_end_ch: 1,
                     reference_book_end_v: 3)
      assert_equal("Philemon 1:1-3",
                   c.reference_string)

      c = create_cls(reference_book: "1 Corinthians",
                     reference_book_start_ch: 1,
                     reference_book_start_v: 1,
                     reference_book_end_ch: 3,
                     reference_book_end_v: 3)
      assert_equal("1 Corinthians 1:1-3:3",
                   c.reference_string,
                   "Should have two chapters referenced")

      c = create_cls(reference_book: "1 Corinthians",
                     reference_book_start_ch: 1,
                     reference_book_start_v: 1,
                     reference_book_end_ch: 1,
                     reference_book_end_v: 1)
      assert_equal("1 Corinthians 1:1",
                   c.reference_string,
                   "Should only be showing one verse")

      c = create_cls(reference_book: "Genesis")
      assert_equal("Genesis",
                   c.reference_string,
                   "Should just be book name")
    end

    test "won't create non-numeric chapters or verses" do
      c = build_cls(reference_book: "1 Corinthians",
                    reference_book_start_ch: 'urgh',
                    reference_book_start_v: 'what?',
                    reference_book_end_ch: 'should be',
                    reference_book_end_v: 'numeric!')
      assert_not(c.save, "Record should not save")
    end

    if cls.included_modules.include?(HasState)
      test "won't wipe bible reference on publish" do
        c = build_cls(:draft,
                      reference_book: "1 Corinthians",
                      reference_book_start_ch: 1,
                      reference_book_start_v: 1,
                      reference_book_end_ch: 3,
                      reference_book_end_v: 3)
        c.save
        assert_not_empty(c.bible_reference_json)
        c.publish
        assert_not_empty(c.bible_reference_json)
      end
    end

  end
end
