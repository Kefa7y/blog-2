class UsersController < ApplicationController
  skip_before_action :require_login, except: [:profile]

  def signup
  end

  def create
    u = User.new
    u.email = post_params[:email]
    u.password = post_params[:password]
    if u.save
      flash[:notice] = "Successfully created user"
      redirect_to action: 'login'
    else
      flash[:alert] = "Error creating new user!"
      render :signup
    end
  end

  def login
  end

  def logout
    session.delete(:user_id)
    redirect_to root_path
  end

  def profile
    @user = u = User.find_by id: session[:user_id]
  end

  def api_login
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

  private

  def post_params
    params.require(:user).permit(:email, :password)
  end
end
