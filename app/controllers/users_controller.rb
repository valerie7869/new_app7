class UsersController < ApplicationController

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

	def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Wecome to New App7!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
end
