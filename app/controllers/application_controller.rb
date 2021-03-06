class ApplicationController < ActionController::Base

  protect_from_forgery

  @@submission = Submission.new

  def is_admin?
    current_user && current_user.admin?
  end

  def is_admin
    if not is_admin?
      flash[:error] = "Error: Not an admin"
      redirect_to root_path
      return
    end
    return true    
  end

  def categories
    @categories = Category.names
  end

end
