class CommentsController < ApplicationController
def create
  @post = Post.find(params[:post_id])
  params = comment_params.merge({ user: current_user })
  @comment = @post.comments.build(params)
    if @comment.save
      redirect_to request.referrer || root_url
    else
      flash[:alert] = "Error"
    end
end
    
def destroy
  @comment = Comment.find(params[:id])
  @comment.destroy
  redirect_to request.referrer || root_url
end

private

def comment_params
  params.require(:comment).permit(:body)
end

end
