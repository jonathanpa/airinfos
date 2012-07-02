Resque.redis = 'localhost:6379'
Resque.redis.namespace = 'resque.Airinfos'

Resque.schedule = YAML.load_file(Rails.root.join('config', 'resque_schedule.yml'))
