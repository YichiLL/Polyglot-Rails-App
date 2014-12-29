class RedisSessionsController < ApplicationController

  before_action :set_user, only: [:index, :get_cart, :logout, :expired]

  def index
  end

  def get_cart
    redirect_to cart_path({id: @redis.get(@userid)}), notice: "Redirected to cart created in session: #{@userid}"
  end

  def expired
    if @redis.ttl(@userid)<0
      render json: {expired: true}
    else
      render json: {expired: false}
    end
  end

  def logout
    @redis.del(@userid,"#{@userid}:products")
    render json: {logout: true}
  end

  def set_user
    @userid=params[:userid]
    @redis=RedisSession::REDIS
  end



  # for CUD
  def product_params
    params.require(:product).permit(:title, :description, :image_url, :price)
  end
end

