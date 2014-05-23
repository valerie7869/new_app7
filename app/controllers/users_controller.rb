class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]  # from listings 9.12, 9.21, 9.45
  before_filter :correct_user,   only: [:edit, :update] # from listing 9.14
  before_filter :admin_user,     only: :destroy    # from listing 9.47

  def show
  	@user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def new
  	@user = User.new
  end

	def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Gizmo!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def index 
    @users = User.paginate(page: params[:page])  # from 9.34
  end
  
  def update
  #  @user = User.find(params[:id])  # line removed per 9.14
  # removed because correct_user before filter defines @user
    if @user.update_attributes(params[:user])
      #handle a successful update - see listing 9.10
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user  # see 9.14
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) # see sessions helper
    end

    def admin_user  # see 9.47
      redirect_to(root_url) unless current_user.admin?
    end
end
