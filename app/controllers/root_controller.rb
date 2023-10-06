class RootController < ApplicationController
  skip_before_action :authenticate_user!
    
  def home
    if user_signed_in?
      @post  = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @comments = Comment.where(post_id: params[:post_id])
    end
  end
end
