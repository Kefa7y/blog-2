module ApplicationHelper
    def logged_in?
      if(session[:user_id].nil?)
        return false
      else
        return true
      end
    end
end
