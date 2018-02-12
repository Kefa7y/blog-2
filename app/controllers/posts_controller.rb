class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :show, :delete]
  #skip_before_action :verify_authenticity_token

   def index
     @posts = Post.all
   end

   def new
     @post = Post.new
   end

   def create
     @post = Post.new
     @post.title= post_params[:title]
     @post.body= post_params[:body]
     if @post.save
       flash[:notice] = "Successfully created post!"
       redirect_to action: 'show', id: @post.id
     else
       flash[:alert] = "Error creating new post!"
       render :new
     end
   end

   def edit
   end

   def update
     if @post.update_attributes(post_params)
       flash[:notice] = "Successfully updated post!"
       redirect_to action: 'show', id: @post.id
     else
       flash[:alert] = "Error updating post!"
       render :edit
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
   end
 end
