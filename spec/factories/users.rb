FactoryGirl.define do
  factory :user do
    password = FFaker::Internet.password(8)
    email                 { FFaker::Internet.email }
    password              password
    password_confirmation password
    nickname              { FFaker::BaconIpsum.characters(15) }
    first_name            { FFaker::Name.first_name }
    last_name             { FFaker::Name.last_name }
    confirmed_at          { Time.zone.now }
    confirmation_sent_at  { Time.zone.now }
    confirmation_token    '9zdxfHWNyJXDGqKCwNn5'
  end
end
