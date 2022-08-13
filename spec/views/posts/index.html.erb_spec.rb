require 'rails_helper'

RSpec.describe 'Post', type: :system do
  describe 'Index page' do
    before(:each) do
      @user = User.create!(name: 'Candy', photo: '#photo_candy', bio: 'bio',
                           email: 'test@domain.com', password: 'password', posts_counter: 0)
      10.times do |i|
        @post = Post.create(author: @user, title: "#{i}/ Post ", text: "Exciting #{i} post")
      end

      @comment = Comment.create(post: @post, author: @user, text: 'Test Comment')

      Like.create(author: @user, post: @post)

      visit new_user_session_path
      fill_in 'user_email', with: 'test@domain.com'
      fill_in 'user_password', with: 'Temmy1234'
      click_button 'Log in'
      visit user_posts_path(@user.id)
    end
    after(:each) do
      User.destroy_all
    end

    it "should display the user's photo" do
      expect(page.find("#user_#{@user.id} img")['src']).to have_content @user.photo
    end

    it "should display the user's name" do
      expect(page).to have_content @user.name
    end

    it 'should show post title' do
      expect(page).to have_content '9/ Post'
    end

    it "should show the post's body." do
      expect(page).to have_content 'Exciting 9 post'
    end

    it 'should show the first comments on a post' do
      expect(page).to have_content 'Test Comment'
    end
    it 'should display the number of comments the user has written' do
      expect(page).to have_content 'Number of posts: 10'
    end

    it 'should display how many likes a post has.' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content 'Like'
    end

    it 'should show see a section for pagination if there are more posts than fit on the view.' do
      expect(page).to have_content 'Pagination'
    end
  end
end
