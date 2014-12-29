class RedisSession
  REDIS = Redis.new(:host => 'localhost', :port => 6379)
  attr_reader :cart, :redis, :userid


  def initialize (userid=nil)
    @redis = REDIS
    @userid = userid || 1
    cart_id = @redis.get(userid)
    if cart_id
      set_cart(cart_id)
    else
      @cart = Cart.create
      @redis.set(@userid, @cart.id)
    end
  end

  def set_expiration (time = 120)
    @redis.expire(@userid,time)
  end

  def check_and_reset_expiration
    if @redis.ttl(@userid) < 0
      true
    else
      set_expiration
      false
    end
  end

  def inc_product_view (product_id)
    @redis.hincrby("#{@userid}:products",product_id,1)
  end

  def get_all_products
    @redis.hgetall("#{@userid}:products")
  end

  private
  def set_cart (cart_id)
    @cart = Cart.find(cart_id)
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    @redis.set(@userid, @cart.id)
  end


end
