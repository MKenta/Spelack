require 'rails_helper'
require 'capybara/rails'

describe ApplicationController do
  feature 'user signs in', type: :feature do
    given!(:user) { create(:user) }
    scenario 'with valid credentials' do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      expect(page).to have_content 'Search Channel'
    end
  end

  feature 'user signs out', type: :feature do
    given!(:user) { create(:user) }
    scenario 'with valid credentials' do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      expect(page).to have_content 'Search Channel'
      click_link 'Logout'
      expect(page).to have_content 'Sign in'
    end
  end
end
