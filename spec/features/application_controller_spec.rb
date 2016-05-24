require 'rails_helper'
require 'capybara/rails'

describe ApplicationController do
  feature 'user signs in', type: :feature do
    given!(:user) { create(:user) }
    scenario 'with valid credentials' do
      visit new_user_session_path
      # binding.pry
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'Log in'
      expect(page).to have_content 'Channel List'
    end
  end

  feature 'user signs out', type: :feature do
    given!(:user) { create(:user) }
    scenario 'with valid credentials' do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'Log in'
      expect(page).to have_content 'Channel List'
      click_link 'ログアウト'
      expect(page).to have_content 'Log in'
    end
  end
end
