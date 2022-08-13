require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:all) do
    @user = User.create(name: 'Cynthia', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Spain.')
    @post = Post.create(title: 'My first post', author: @user)
  end

  it 'should return comments_counter increments after saving the post' do
    expect(@post.comments_counter).to be 0

    comment = Comment.new(author: @user, post: @post)
    comment.save
    expect(@post.comments_counter).to be 1
  end
end
