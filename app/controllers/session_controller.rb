class SessionController < ApplicationController
  skip_before_action :require_login
  def new
  end

  def create
    u = User.find_by email: post_params[:email]
    if(u.nil?)
      flash[:alert] = "User not found!"
      render :new
    else
      if(u.password == post_params[:password])
        session[:user_id] = u[:id]
        redirect_to users_show_path
      else
        flash[:alert] = "Password not correct!"
        render :new
      end
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

  private

  def post_params
    params.require(:user).permit(:email, :password)
  end
end
