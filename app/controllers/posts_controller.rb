class PostsController < ApplicationController

  def create
    user = User.find_or_create_by!(login: params[:login])
    post = Post.create!(post_params(user))
    
    render json: { success: true, id: post.id }
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors.full_messages }, status: 422
  end

  def set_rate
    post = Post.find_by(id: params[:id])
    Post.transaction do
      Rate.create!(post_id: params[:id], value: params[:value])
      post.update_rating(params[:value].to_i)
    end

    render json: { success: true, rate: post.rating }
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors.full_messages }, status: 422
  end

  def index
    params[:n] ||= 1
    @top = Post.get_top(params[:n])
  end

  def top_ip
    @top_ips = Post.group(:author_ip).count.keep_if { |k, v| v > 1 }.keys
  end

  private

  def post_params(user)
    params.require(:post).permit(:title, :text, :author_ip).merge!(user: user)
  end
end
