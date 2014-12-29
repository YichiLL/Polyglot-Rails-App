module CurrentCart
  extend ActiveSupport::Concern

  private

  def set_cart
    @userid||=1
    @session=RedisSession.new(@userid)
    if @session.check_and_reset_expiration
      redirect_to store_url, notice: 'Your session has expired. Restarting your session.'
    end
    @cart=@session.cart
  end
end