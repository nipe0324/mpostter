class UsersController < ApplicationController
  before_action :signed_in_user,  only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy
  before_action :already_singed_in_user, only: [:new, :create]


  def index
    @users = User.paginate(page: params[:page])
  end

	def show
		@user = User.find(params[:id])
	 @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
  		flash[:success] = "MPosterへようこそ。アカウントを登録しました。"
  		redirect_to root_path
  	else
  		render 'new'
  	end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを更新しました。"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if current_user?(user)
      flash[:error] = "ユーザが自分自身のため削除できません。"
    else
      user.destroy
      flash[:success] = "ユーザを削除しました。"
    end
    redirect_to users_url

  end

  def following
    @title = "フォロー"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end


  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def already_singed_in_user
      if signed_in?
        @user = current_user
        redirect_to @user
      end
    end

end
