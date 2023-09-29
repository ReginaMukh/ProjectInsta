class RootController < ApplicationController
    skip_before_action :authenticate_user!
    def home
        if user_signed_in?
            @post  = current_user.posts.build
            @feed_items = current_user.feed.paginate(page: params[:page])
            @comment_items = @post.commentfeed.build
          end
    end
end
