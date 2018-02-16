class CommentsController < ApplicationController

  def create
    comment = Comment.create(user_id: session[:user_id], post_id: params[:post_id],body: params[:body])
    if comment.save
      flash[:notice] = "Successfully added comment"
    else
      flash[:alert] = "Error creating new comment!"
    end
      redirect_to posts_show_path(id: params[:post_id])
  end

  def update
    comment = Comment.find(params[:id])
    if comment.update_attributes(body: params[:body])
      flash[:notice] = "Successfully updated post!"
    else
      flash[:alert] = "Error updating post!"
    end
      redirect_to posts_show_path(id: params[:post_id])
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      flash[:notice] = "Successfully deleted comment!"
    else
      flash[:alert] = "Error deleting comment!"
    end
      redirect_to posts_show_path(id: params[:post_id])
  end

end
