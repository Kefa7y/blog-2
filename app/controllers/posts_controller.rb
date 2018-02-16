class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :show, :delete]
  before_action :find_author, only: [:show]
  skip_before_action :require_login, only: [:index]

   def index
     @posts = Post.all
   end

   def new
   end

   def create
     u = User.find_by id: session[:user_id]
     post = u.posts.create(post_params)
     if post.save
       flash[:notice] = "Successfully created post!"
       redirect_to action: 'show', id: post.id
     else
       flash[:alert] = "Error creating new post!"
       render :new
     end
   end

   def edit
   end

   def update
     if @post.user_id == session[:user_id]
       if @post.update_attributes(post_params)
         flash[:notice] = "Successfully updated post!"
         redirect_to action: 'show', id: @post.id
       else
         flash[:alert] = "Error updating post!"
         render :edit
       end
     else
       flash[:alert] = "Cannot edit others' posts!"
       redirect_to posts_index_path
     end
   end

   def show
     comments = Comment.where( post_id:@post.id)
     @comments= comments.joins(:user).select(:id,:post_id,:user_id,:body,:email)

   end

   def delete
     if @post.destroy
       flash[:notice] = "Successfully deleted post!"
       redirect_to root_path
     else
       flash[:alert] = "Error updating post!"
     end
   end

   private

   def post_params
     params.require(:post).permit(:title, :body)
   end

   def find_post
     @post = Post.find(params[:id])
   end

   def find_author
     @author = User.find(@post.user_id)[:email]
   end
 end
