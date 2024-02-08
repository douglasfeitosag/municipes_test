redis_addr = "redis:6379/0"

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{redis_addr}" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{redis_addr}" }
end
