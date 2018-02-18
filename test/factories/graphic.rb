FactoryBot.define do
  factory :graphic do
    background_image ActionDispatch::Http::UploadedFile.new(
      tempfile: File.new(Rails.root.join('test',
                                         'fixtures',
                                         'files',
                                         'southwark.jpg')),
      filename: 'testupload.jpg'
    )
  end
end
