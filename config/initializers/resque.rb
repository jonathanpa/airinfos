if Rails.env == 'development'
  Resque.redis = Redis.new(:host => 'localhost', :port => 6379, :thread_safe => true)
  Resque.redis.namespace = 'resque.Airinfos'

  Resque.schedule = YAML.load_file(Rails.root.join('config', 'resque_schedule.yml'))
end
