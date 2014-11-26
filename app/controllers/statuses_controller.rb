class StatusesController < ApplicationController
  http_basic_authenticate_with name: "super", password: "secret", except: :health

  before_action :setup_redis

  def health
    local_port = ENV['LOCAL_PORT']
    if @redis && local_port
      if @redis.get(local_port) == "on"
        render :json => {:port => local_port, :health => 'on'}
      else
        render :json => {:port => local_port, :health => 'off'}, :status => 500
      end
    else
      render :json => {:port => local_port, :health => "unknown"}
    end
  end

  def set_health
    local_port = ENV['LOCAL_PORT']
    status = params[:status]
    @redis.set(local_port, status)
    render :json => { :port => local_port, :health => status }
  end

  private

  def setup_redis
    if ENV['REDIS_PORT_6379_TCP_ADDR'] && redis_port = ENV['REDIS_PORT_6379_TCP_PORT']
      @redis = Redis.new(:host => ENV['REDIS_PORT_6379_TCP_ADDR'], :port => redis_port)
    end
  end
end
