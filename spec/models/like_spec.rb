require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:all) do
    @user = User.create(name: 'Cynthia', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Spain.')
    @post = Post.create(title: 'My first post', author: @user)
  end

  it 'should return likes_counter increments after liked the post' do
    expect(@post.likes_counter).to be 0

    like = Like.new(author: @user, post: @post)
    like.save
    expect(@post.likes_counter).to be 1
  end
end
