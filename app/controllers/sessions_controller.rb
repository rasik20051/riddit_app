class SessionsController < ApplicationController
  def new
  end

  def create
  	user=User.new(params[:username])

  	if user && user.authenticate(params[:password])
  		session[:user_id]= user.id
  		redirect_to root_path,notice: "Logged In"
  	else

  		flash.now[:error]="Wrong username or password"
  		redirect_to root_path
	end
  end

  def destroy
  	session[:user_id]=nil
  	redirect_to root_path,notice: "Logged Out"
  end
end
