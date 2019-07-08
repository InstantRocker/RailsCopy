class Api::V1::PostsController < ApplicationController

  before_action :load_post, only: :show
  before_action :authenticate_with_token!, only: [:create, :destroy]

  def index
    @posts = Post.all
    json_response "Index Posts Successfully", true, {posts: @posts}, :ok
  end

  def create
    post_params_and_user = post_params.merge(user_id: current_user.id)
    @post = Post.new(post_params_and_user)
    if @post.save
      json_response "Posted Successfully", true, {}, :ok
    else
      json_response "Saving Post Failed", false, {}, :unprocessable_entity
    end
  end

  def show
    if @post.audio.present?
      json_response "Show Post successfully", :true, {data: @post, url: url_for(@post.audio)}, :ok
    else
      json_response "Show Post successfully", :true, {data: @post}, :ok
    end
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
