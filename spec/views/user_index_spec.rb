require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.feature 'User page', js: true, type: :feature do
  background do
    visit new_user_session_path
    @first_user = User.create(name: 'Sammie',
                              photo: 'https://hips.hearstapps.com/hbz.h-cdn.co/assets/cm...',
                              bio: 'stuff about sammie',
                              posts_counter: 0, email: 'sammie@gmail.com',
                              password: 'abcde')

    @second_user = User.create(name: 'Alice',
                               photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                               bio: 'stuff about alice',
                               posts_counter: 0, email: 'alice@gmail.com', password: 'abcdefg')

    fill_in 'user_email', with: @second_user.email
    fill_in 'user_password', with: @second_user.password
    click_button 'Log in'
  end

  describe 'Details of user' do
    it 'has view for all users' do
      users = User.all
      visit users_path
      users.each do |user|
        expect(page).to have_content(user.name)
      end
    end

    it 'has each user profile picture' do
      users = User.all
      visit users_path
      users.each do |_user|
        expect(page.body).to include('<img class="user-photo" src="https://unsplash.com/photos/F_-0BxGuVvo">')
      end
    end

    it 'shows posts count per user' do
      users = User.all
      visit users_path
      users.each do |user|
        expect(page).to have_content(user.posts_counter)
      end
    end
  end

  describe 'When a user is clicked, ' do
    it 'redirects to the user main page' do
      users = User.all
      click_link users[0].name
      expect(current_path).to eql(user_path(id: users[0].id))
    end
  end
end
# rubocop:enable Metrics/BlockLength
