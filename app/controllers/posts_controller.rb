class PostsController < ApplicationController
  before_action :correct_user,   only: :destroy

  def new
    @post = Post.new
  end
  
  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
      if @post.update(post_params)
        flash[:success] = "Profile updated"
        redirect_to root_url
      else
        render 'edit'
      end
  end

  def create
    @post = current_user.posts.build(post_params)
      if @post.save
        flash[:success] = "publication created!"
        redirect_to root_url
      else
        @feed_items = []
        render 'root/home'
      end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "Публикация удалена"
    redirect_to request.referrer || root_url
  end

  private

  def post_params
    params.require(:post).permit(:content, :picture)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end