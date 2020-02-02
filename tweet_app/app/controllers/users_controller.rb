class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login, :login_form]}
  before_action :ensure_correct_user, {only: [:edit, :update]}
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts
    @likes = Like.where(user_id: @user.id)
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name], 
      email: params[:email],
      password: params[:password],
      image_name: "user.png"
      )
    if @user.save
      flash[:notice] = "登録が完了しました" 
      session[:user_id] = @user.id
      redirect_to("/users/#{@user.id}/show")
    else
      flash[:notice] = "登録に失敗しました"
      render("users/new")
    end   
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    
    if @image = params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/#{@user.image_name}", image.read)
    end
    
    if @user.save
      flash[:notice] ="profile updated "
      redirect_to("/users/index")
    else
      flash[:notice] ="profile is not updated "
      render("users/#{@user.id}/edit")
    end
  end

  def login_form
    @user = User.new  
  end

  def login
    @user = User.find_by(email: params[:email],
                         password: params[:password])
    if @user
      flash[:notice] = "ログインしました"
      session[:user_id] = @user.id
      redirect_to("/posts/index")
    else
      @error_message = "eamil or pass が間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "logout しました"
    redirect_to("/login")
  end

end

