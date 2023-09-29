class PostsController < ApplicationController
  before_action :correct_user,   only: :destroy

  def new
    @post = Post.new
  end
  
  def show
    @post = Post.find(params[:id])
  end

  # POST /posts or /posts.json
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

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
      if @post.update(post_params)
        redirect_to post_url(@post), notice: "Post was successfully updated."
      else
      render :edit, status: :unprocessable_entity
      end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
      flash[:success] = "Публикация удалена"
      redirect_to request.referrer || root_url
  end

  private

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:content, :picture)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
  end