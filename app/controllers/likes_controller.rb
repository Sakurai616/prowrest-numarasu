class LikesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    current_user.like(@post)
    
    render turbo_stream: turbo_stream.replace(
      'like',
      partial: 'posts/like',
      locals: { post: @post },
    )
  end

  def destroy
    @post = current_user.likes.find(params[:id]).post
    current_user.unlike(@post)

    render turbo_stream: turbo_stream.replace(
      'like',
      partial: 'posts/like',
      locals: { post: @post },
    )
  end
end
