require 'rails_helper'

RSpec.describe 'Post', type: :system do
  context 'show page' do
    before(:each) do
      @user = User.create!(name: 'Candy', photo: '#photo_candy', bio: 'bio',
                           email: 'test@domain.com', password: 'password', posts_counter: 0)

      @user.confirm
      @post = Post.create(author: @user, title: 'Integration test', text: 'Exciting!')
      @comment = Comment.create(author: @user, post: @post, text: 'Test Comment')
      Like.create(author: @user, post: @post)
      visit new_user_session_path
      fill_in 'user_email', with: 'test@domain.com'
      fill_in 'user_password', with: 'password'
      click_button 'Log in'
      visit user_post_path(@user.id, @post.id)
    end

    after(:each) do
      User.destroy_all
    end

    it "should show post's title" do
      expect(page).to have_content 'Integration test'
    end

    it "should show post's author" do
      expect(page).to have_content @user.name
    end

    it 'should show the number of comments' do
      expect(page).to have_content 'Comments: 1'
    end

    it 'should show the number of likes' do
      expect(page).to have_content 'Likes: 1'
    end

    it 'should show the post body' do
      expect(page).to have_content 'Exciting!'
    end

    it 'should show the username of each commentor' do
      expect(page).to have_content 'Candy'
    end

    it 'should show the text comment each commentor' do
      expect(page).to have_content 'Test Comment'
    end
  end
end
