uri = URI.parse(ENV['REDISTOGO_URL'])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)

Resque.redis.namespace = 'resque.Airinfos'

Resque.schedule = YAML.load_file(Rails.root.join('config', 'resque_schedule.yml'))
