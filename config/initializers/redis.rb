if ENV["REDISCLOUD_URL"]
    uri = URI.parse(ENV["REDISCLOUD_URL"])
    REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
    Resque.redis = REDIS
end
