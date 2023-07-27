class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show search like_rank]
  before_action :set_post, only: %i[edit update destroy]

  def index
    posts = if (tag_name = params[:tag_name])
              Post.with_tag(tag_name)
            elsif (organization_name = params[:organization_name])
              Post.with_organization(organization_name)
            else
              Post.all
            end
    @posts = posts.includes(:user).order(created_at: :desc).page(params[:page])
    @organizations = Organization.all
    @organization_posts = Post.includes(:organization).where(organization_id: params[:organization_id]).order(created_at: :desc).page(params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save_with_tags(tag_names: params.dig(:post, :tag_names).split(',').uniq)
      redirect_to posts_path, success: t('defaults.message.created', item: Post.model_name.human)
    else
      flash.now[:error] = t('defaults.message.not_created', item: Post.model_name.human)
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
      flash.now[:error] = t('defaults.message.not_updated', item: Post.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, success: t('defaults.message.deleted', item: Post.model_name.human), status: :see_other
  end

  def search
    @search_form = SearchPostsForm.new(search_post_params)
    @posts = @search_form.search.includes(:user).order(created_at: :desc).page(params[:page])
    @organizations = Organization.all
  end

  def like_rank
    posts = Post.includes(:liking_users).sort{|a,b| b.liking_users.size <=> a.liking_users.size}
    @posts = Kaminari.paginate_array(posts).page(params[:page])
  end

  def my_posts
    my_posts = Post.where(user_id: current_user.id).includes(:user).order("created_at DESC")
    @my_posts = Kaminari.paginate_array(my_posts).page(params[:page])
  end

  private

  def post_params
    params.require(:post).permit(:image, :image_cache, :url, :title, :body, :organization_id)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def search_post_params
    params.fetch(:q, {}).permit(:title_or_body, :tag_name)
  end
end
