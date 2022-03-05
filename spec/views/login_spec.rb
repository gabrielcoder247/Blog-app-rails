require 'rails_helper'
RSpec.describe 'Login page', js: true, type: :feature do
  describe 'Login Page requirements' do
    it 'has username and password inputs, and Log in button' do
      visit new_user_session_path
      expect(page).to have_field('user_email')
      expect(page).to have_field('user_password')
      expect(page).to have_button('Log in')
    end
  end

  describe 'When the submit button is clicked' do
    it 'submits with out username and password inputs' do
      visit new_user_session_path
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      click_button 'Log in'
      expect(page).to have_content('Sign up')
    end

    it 'has incorrect username and password' do
      visit new_user_session_path
      fill_in 'user_email', with: 'sam@gmail.com'
      fill_in 'user_password', with: '0000'
      click_button 'Log in'
      expect(page).to have_content('Forgot your password')
    end
  end
end
