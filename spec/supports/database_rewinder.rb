RSpec.configure do |config|
  config.before(:suite) do
    DatabaseRewinder.clean_all
    system('rake db:seed RAILS_ENV=test')
  end

  config.after(:each) do
    DatabaseRewinder.clean
  end
end
