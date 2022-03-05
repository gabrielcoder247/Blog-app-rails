require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.feature 'post show page', js: true, type: :feature do
  background do
    visit user_session_path

    bio = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    Fusce risus mi, luctus id ligula nec, malesuada rhoncus tortor.
    Ut egestas mollis erat. Aliquam imperdiet nisi ac porttitor imperdiet.
    Etiam lacus lorem, euismod eu porttitor porttitor, accumsan eget risus.
    Etiam at diam id nunc aliquet interdum ut in sapien. Sed ultrices
    eleifend massa, eget mattis magna sollicitudin fringilla.
    Mauris ac venenatis nisi, ac semper eros. Vivamus in facilisis ipsum.'

    # title = 'Cats and Dogs'

    likes = 0

    text = 'Lorem ipsum dolor sit amet,
    consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
    Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
    # rubocop:disable Layout/LineLength
    @Rob = User.create!(name: 'Rob', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: bio, email: 'willy@mail.com', posts_counter: 0, password: 'asdzxc')
    # rubocop:enable Layout/LineLength
    fill_in 'Email', with: 'willy@mail.com'
    fill_in 'Password', with: 'asdzxc'
    click_button 'Log in'

    post = @Rob.posts.create!(title: 'Hello world', text: text, CommentsCounter: 0, likes_counter: likes)
    # rubocop:disable Layout/LineLength
    lara = User.create!(name: 'Lara', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: bio, posts_counter: 0, email: 'lara@mail.com', password: 'asdzxc')
    # rubocop:enable Layout/LineLength
    Comment.create(text: 'Wow', post_id: post.id, author_id: lara.id)
    Comment.create(text: 'Big like', post_id: post.id, author_id: lara.id)
    visit "/users/#{@Rob.id}/posts/#{post.id}"
  end
  it "see the post's title" do
    expect(page).to have_content 'Hello world'
  end

  it 'can see who wrote the post.' do
    expect(page).to have_content 'Rob'
  end

  it 'can see how many comments it has.' do
    expect(page).to have_content 'Comments: 2'
  end

  it 'can see how many likes it has.' do
    expect(page).to have_content 'Likes:'
  end

  it 'can see the post body.' do
    expect(page).to have_content text
  end

  it 'can see the username of each commentor.' do
    expect(page).to have_content 'Lara'
  end

  it 'can see the comment each commentor left.' do
    expect(page).to have_content 'Wow'
    expect(page).to have_content 'Big like'
  end
end
# rubocop:enable Metrics/BlockLength
