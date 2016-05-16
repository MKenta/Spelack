FactoryGirl.define do
  factory :user do
    password = FFaker::Internet.password(8)
    email                 { FFaker::Internet.email }
    password              password
    password_confirmation password
    nickname              { FFaker::Name.name }
    first_name            { FFaker::Name.first_name }
    last_name             { FFaker::Name.last_name }
    confirmed_at          { Time.zone.now }
    confirmation_sent_at  { Time.zone.now }
    confirmation_token    '9zdxfHWNyJXDGqKCwNn5'
    # factory_girlのファイルではfixture_pathを見てくれないので頭からパスを定義して上げる必要があった。
    # avatar { fixture_file_upload("#{::Rails.root}/spec/fixtures/default_avatar.png", "image/png") }
    # end
    # avatar                { fixture_file_upload('spec/support/images/default_avatar.png', 'image/png') }
    # avatar { fixture_file_upload("#{::Rails.root}/spec/support/images/default_avatar.png", 'image/png') } }
    # avatar { File.new("#{Rails.root}/spec/support/images/default_avatar.png") }
  end
end
