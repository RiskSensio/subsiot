# if ENV["REDISCLOUD_URL"]
#     $redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
# end

uri = URI.parse(ENV["REDISCLOUD_URL"])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Resque.redis = REDIS
