require 'moneta'
require 'redis'

# Create a simple file store
cache  = Moneta::Adapters::Redis.new
redis = Redis.new(:host => 'localhost', :port => 6379)
=begin
# Store some entries
store['key'] = 'value'

# Read entry
store.key?('key') # returns true
puts store['key'] # returns 'value'

store.close
=end


# Expires in 60 seconds
puts redis.set('user:1','sessionid')
puts redis.expire('user:1',-2)
puts redis.ttl('user:1')==-2
puts redis.get('user:1')
puts redis.ttl('user:4')
ni||=1
puts redis.hmset('user:k',1,1)





=begin
before action: (now: set userid) check sessionid,	if not exist or expired
	redirect to login 
	(now: create/resume)
if ok, get @cartid

modify set_cart

on 2 showing: path to model

generate RedisSession

=end
