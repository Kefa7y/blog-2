class CommentsController < ApplicationController

  def create
    comment = Comment.create(user_id: session[:user_id], post_id: params[:post_id])
    comment.body = params[:body]
    if comment.save
      flash[:notice] = "Successfully created user"
    else
      flash[:alert] = "Error creating new user!"
    end
    redirect_to controller: 'posts',action: 'show', id: params[:post_id]
  end

  def update
  end

  def delete
  end

end
