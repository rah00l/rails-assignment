# lib/request_counter.rb
class RequestCounter
  def self.redis
    @redis ||= Redis.new(host: ENV["REDIS_HOST"], port: ENV["REDIS_PORT"])
  end

  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    self.class.redis.incr "request_counter:#{request.fullpath}"
    @app.call(env)
  end
end

