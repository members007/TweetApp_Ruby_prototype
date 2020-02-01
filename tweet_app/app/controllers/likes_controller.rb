class LikesController < ApplicationController
    before_action :authenticate_user
    
    def like
        @post = Post.find_by(id: params[:post_id])
        @like = Like.new(post_id: @post.id, 
                        user_id: @current_user.id)
        @like.save
        
        redirect_to("/posts/#{@post.id}")
    end

    def unlike
        @post = Post.find_by(id: params[:post_id])
        @like = Like.find_by(post_id: params[:post_id], user_id: @current_user.id)
        @like.destroy

        redirect_to("/posts/#{@post.id}")
    end

end
