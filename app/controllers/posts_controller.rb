class PostsController < ApplicationController

  before_action :load_post, only: :show
  before_action :authenticate_with_token!, only: [:destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    post_params_and_user = post_params.merge(user_id: @current_user.id)
    @post = Post.new(post_params_and_user)
    if @post.save
      json_response "Posted Successfully", true, {}, :ok
    else
      json_response "Saving Post Failed", false, {error: @post.errors.full_messages}, :unprocessable_entity
    end
  end


  def show
  
  end

  
  private

    def load_post
      @post = Post.find_by(id: params[:id])
      unless @post.present?
        json_response "Cannot get Post", false, {}, :not_found
      end
    end

    def post_params
      params.require(:upload_post).permit(:title, :audio)
    end

end
