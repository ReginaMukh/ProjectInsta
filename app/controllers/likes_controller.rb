class LikesController < ApplicationController

def create
  @like = current_user.likes.create(like_params)
    if @like.save
    redirect_to request.referrer || root_url
    else
      flash.now[:alert] = "Error"
    end
end
        
def destroy
  @like = Like.find(params[:id])
  @like.destroy
  redirect_to request.referrer || root_url
end

private

def like_params
  params.require(:like).permit(:post_id)
end
  
end
