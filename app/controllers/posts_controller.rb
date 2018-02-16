class PostsController < ApplicationController
  before_action :find_post, only: [:edit,:update,:show, :destroy]
  skip_before_action :require_login, only: [:index]

  def index
    @posts = Post.all
  end

  def new; end

  def create
    u = User.find_by id: session[:user_id]
    post = u.posts.create(post_params)
    if post.save
      flash[:notice] = 'Successfully created post!'
      respond_to do |format|
        format.html { redirect_to action: 'show', id: post.id }
        format.json { render json: post }
      end
    else
      flash[:alert] = 'Error creating new post!'
      respond_to do |format|
        format.html { render :new }
        format.json { render status: 403 }
      end
    end
  end

  def edit; end

  def update
    if @post.user_id == session[:user_id]
      if @post.update_attributes(post_params)
        flash[:notice] = 'Successfully updated post!'
        respond_to do |format|
          format.html { redirect_to action: 'show', id: @post.id }
          format.json { render json: @post }
        end
      else
        flash[:alert] = 'Error updating post!'
        respond_to do |format|
          format.html { render :edit }
          format.json { render status: 403 }
        end
      end
    else
      flash[:alert] = "Cannot edit others' posts!"
      respond_to do |format|
        format.html { redirect_to posts_index_path }
        format.json { render status: 403 }
      end
    end
  end

  def show
  end

  def destroy
    if @post.destroy
      flash[:notice] = 'Successfully deleted post!'
      respond_to do |format|
        format.html { redirect_to root_path}
        format.json { render status: 200 }
      end
    else
      flash[:alert] = 'Error deleting post!'
      respond_to do |format|
        format.html { redirect_to posts_show_path(@post.id) }
        format.json { render status: 403 }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :tags)
  end

  def find_post
    @post = Post.find(params[:id])
  end
 end
