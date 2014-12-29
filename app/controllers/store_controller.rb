class StoreController < ApplicationController


  def index
    @products = Product.order(:title)
    set_session
  end


  private
  def set_session
    @session = RedisSession.new
    @session.set_expiration
  end
end
