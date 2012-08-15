if Rails.env == 'development'
  ENV['REDISTOGO_URL'] = "redis://jonathanpa:b1d8b882abcc8bf77c571ff98d1ece8c@lab.redistogo.com:9557"

  uri = URI.parse(ENV['REDISTOGO_URL'])
  Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)

  Resque.redis.namespace = 'resque.Airinfos'

  Resque.schedule = YAML.load_file(Rails.root.join('config', 'resque_schedule.yml'))
end
