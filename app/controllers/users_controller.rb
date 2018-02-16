class UsersController < ApplicationController
  skip_before_action :require_login, except: [:show]

  def new
  end

  def create
    u = User.new
    if u.save(post_params)
      flash[:notice] = "Successfully created user"
      redirect_to action: 'login'
    else
      flash[:alert] = "Error creating new user!"
      render :signup
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
