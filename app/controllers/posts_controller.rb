class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :show, :delete]
  skip_before_action :require_login, only: [:index]

   def index
     posts = Post.all
     @posts = posts.joins(:user).select(:id,:title,:body,:email)

   end

   def new
   end

   def create
     u = User.find_by id: session[:user_id]
     post = u.posts.create(title:  post_params[:title],body: post_params[:body] )
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
   end

   def destroy
     if @post.destroy
       flash[:notice] = "Successfully deleted post!"
       redirect_to posts_path
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
     @author = User.find(@post.user_id)[:email]
   end
 end
