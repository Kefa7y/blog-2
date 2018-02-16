class UsersController < ApplicationController
  skip_before_action :require_login, except: [:show]

  def new
  end

  def create
    u = User.new(post_params)
    if u.save
      flash[:notice] = "Successfully created user"
      respond_to do |format|
        format.html { redirect_to session_new_path}
        format.json { render json: u}
      end
    else
      flash[:alert] = "Error creating new user!"
      respond_to do |format|
        format.html { render :new}
        format.json { render status: 403}
      end
    end
  end


  def show
    @user = User.find session[:user_id]
    respond_to do |format|
      format.html
      format.json { render json: @user}
    end
  end

  private

  def post_params
    params.require(:user).permit(:email, :password)
  end
end
