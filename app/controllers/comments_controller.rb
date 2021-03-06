class CommentsController < ApplicationController
  before_action :require_login

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      flash[:notice] = "Your comment was saved!"
      redirect_to trail_path(@comment.trail_id)
    else
      flash[:notice] = "Comment was not saved!"
      redirect_to trail_path(@comment.trail_id)
    end
  end

  protected
  def require_login
    unless current_user
      flash[:notice] = "You must be logged in to comment!"
      redirect_to root_path
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:description, :trail_id).merge(user_id: current_user.id)
  end
end
