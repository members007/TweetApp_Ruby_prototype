class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show 
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @favor = Like.find_by(post_id: @post.id, user_id: @current_user.id)
    @likes = Like.where(post_id: @post.id)
    @like_numbers = @likes.count
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(content: params[:content], user_id: @current_user.id)
    if @post.save
      flash[:notice] = "投稿が完了しました"
      redirect_to("/posts/index")
    else 
      render("posts/new")
    end
  end

  def edit
    
    @post = Post.find_by(id: params[:id])

  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    
    if @post.save
      flash[:notice] = "更新が完了しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    if @post.save
      flash[:notice] = "投稿を削除しました"
    end
      redirect_to("/posts/index")
  end
    
end

