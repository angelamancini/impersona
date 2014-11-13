class SessionsController < ApplicationController
  skip_before_filter :require_login
  def new; end

  def create
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've been successfully logged out!"
    redirect_to root_path
  end

  def failure
    render text: "Sorry, but you didn't allow access to our app!"
  end
end
