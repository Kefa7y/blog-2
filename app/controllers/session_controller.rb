class SessionController < ApplicationController

  def new
  end

  def create
    u = User.find_by email: post_params[:email]
    if(u.nil?)
      flash[:alert] = "User not found!"
      render :login
    else
      if(u.password == post_params[:password])
        session[:user_id] = u[:id]
        redirect_to action: 'profile'
      else
        flash[:alert] = "Password not correct!"
        render :login
      end
    end
  end

  def delete
    session.delete(:user_id)
    redirect_to root_path
  end
end
