class UsersController < ApplicationController
  skip_before_action :require_login, except: [:show]

  def new
  end

  def create
    u = User.new(post_params)
    if u.save
      flash[:notice] = "Successfully created user"
      redirect_to session_new_path
    else
      flash[:alert] = "Error creating new user!"
      render :new
    end
  end


  def show
    @user = User.find session[:user_id]
  end

  private

  def post_params
    params.require(:user).permit(:email, :password)
  end
end
