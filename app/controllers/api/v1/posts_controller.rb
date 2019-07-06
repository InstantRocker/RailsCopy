class Api::V1::PostsController < ApplicationController

  before_action :load_post, only: :show

  def index
    @posts = Post.all
    json_response "Index Posts Successfully", true, {posts: @posts}, :ok
  end

  def show
    json_response "Show Post successfully", :true, {post: @post}, :ok
  end

  private
    def load_post
      @post = Post.find_by(id: params[:id])
      unless @post.present?
        json_response "Cannot get Post", false, {}, :not_found
      end
    end

end
