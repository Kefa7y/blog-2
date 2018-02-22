class SessionController < ApplicationController
  skip_before_action :require_login
  def new
  end

  def create
    u = User.find_by email: post_params[:email]
    if(u.nil?)
      flash[:alert] = "User not found!"
      respond_to do |format|
        format.html { render :new }
        format.json { render status:403 }
      end
    else
      if(u.password == post_params[:password])
        session[:user_id] = u[:id]
        respond_to do |format|
          format.html { redirect_to users_show_path }
          format.json { render json:u }
        end
      else
        flash[:alert] = "Password not correct!"

        respond_to do |format|
          format.html { render :new }
          format.json { render status:403 }
        end
      end
    end
  end

  def destroy
    session.delete(:user_id)
    puts request.format.xml?
    respond_to do |format|
      format.html { redirect_to root_path , turbolinks: false}
      format.json { head :ok }
    end
  end

  private

  def post_params
    params.require(:user).permit(:email, :password)
  end
end
