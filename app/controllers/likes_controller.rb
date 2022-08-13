class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    post = Post.find(params[:post_id])
    @like = Like.new(author: current_user, post:)

    if @like.save
      flash[:notice] = 'You have successfully liked the post.'
      redirect_to user_post_path(current_user, post)
    else
      flash[:alert] = 'Can not like'
      redirect_to { new_user_post(current_user) }
    end
  end
end
