class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show search]
  before_action :set_post, only: %i[edit update destroy]

  def index
    posts = if (tag_name = params[:tag_name])
              Post.with_tag(tag_name)
            else
              Post.all
            end
    @posts = Post.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save_with_tags(tag_names: params.dig(:post, :tag_names).split(',').uniq)
      redirect_to posts_path, success: t('defaults.message.created', item: Post.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_created', item: Post.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def edit
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def update
    @post.assign_attributes(post_params)
    if @post.save_with_tags(tag_names: params.dig(:post, :tag_names).split(',').uniq)
      redirect_to post_path(@post), success: t('defaults.message.updated', item: Post.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: Post.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, success: t('defaults.message.deleted', item: Post.model_name.human), status: :see_other
  end

  def search
    @search_form = SearchPostsForm.new(search_post_params)
    @posts = @search_form.search.includes(:user).order(created_at: :desc)
  end

  private

  def post_params
    params.require(:post).permit(:image, :image_cache, :url, :title, :body)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def search_post_params
    params.fetch(:q, {}).permit(:title_or_body, :tag_name)
  end
end
