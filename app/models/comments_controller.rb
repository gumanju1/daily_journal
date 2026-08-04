class CommentsController < ApplicationController
  before_action :authenticate_user
  before_action :set_entry

  def create
    @comment = @entry.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @entry, notice: "Comment added successfully."
    else
      redirect_to @entry, alert: "Unable to add comment."
    end
  end

  def destroy
    @comment = @entry.comments.find(params[:id])

    if @comment.user == current_user
      @comment.destroy
      redirect_to @entry, notice: "Comment deleted successfully."
    else
      redirect_to @entry, alert: "You are not authorized to delete this comment."
    end
  end

  private

  def set_entry
    @entry = Entry.find(params[:entry_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
