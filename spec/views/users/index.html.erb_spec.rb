require 'rails_helper'

RSpec.describe 'user_index_path', type: :system do
  describe 'User_index_view' do
    before(:each) do
      @users = [User.create!(name: 'Candy', photo: '#photo_candy', bio: 'bio', email: 'candy@test.com', password: '123456', posts_counter: 0),
                User.create!(name: 'Nicole', photo: '#photo_nicole', bio: 'bio', email: 'nicole@test.com', password: 'nicole123', posts_counter: 10),
                User.create!(name: 'Lary', bio: 'bio', email: 'laryjare@test.com', password: 'password', posts_counter: 20)]

      visit new_user_session_path

      fill_in 'user_email',	with: 'Nicole@test.com'
      fill_in 'user_password',	with: 'password'
      click_button 'Log in'
    end

    after(:each) do
      User.destroy_all
    end

    it 'I can see the username of all other users.' do
      visit users_path

      @users.each do |u|
        expect(page).to have_content u.name
      end
    end

    it 'I can see the number of posts each user has written.' do
      visit users_path

      @users.each do |u|
        expect(page).to have_content('Number of posts:')

        expect(page).to have_content u.posts_counter
      end
    end

    it 'When I click on a user, I am redirected to that user s show page.' do
      visit users_path
      click_link @users[0].name
      expect(page).to have_content 'See All Posts'
    end
  end
end
