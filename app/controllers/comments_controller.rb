class CommentsController < ApplicationController

  

  # POST /comments or /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    if @comment.save
      redirect_to request.referrer || root_url
    else
      render 'root/home'
    end
  end
    


  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to request.referrer || root_url
  
  end

  private


    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end

  
end
