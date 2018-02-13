class UsersController < ApplicationController

  def signup
  end

  def login
  end

  def profile
    @user = session[:user]
  end

  def api_login
    u = User.find_by email: post_params[:email]
    if(u == null)
      flash[:alert] = "User not found!"
      render :login
    else
      if(u.password == post_params[:password])
        session[:user] = u
        redirect_to action: 'profile'
      else
        flash[:alert] = "Password not correct!"
        render :login
      end
    end


  end

  private

  def post_params
    params.require(:user).permit(:email, :password)
  end
end
