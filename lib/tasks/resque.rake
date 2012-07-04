require 'resque_scheduler/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*'
end

task "resque:work:background" => :environment do
  ENV['BACKGROUND'] = 'yes'
  Rake::Task["resque:work"].invoke
end

task "resque:scheduler:background" => :environment do
  ENV['BACKGROUND'] = 'yes'
  Rake::Task["resque:scheduler"].invoke
end

desc "Clear pending tasks"
task "resque:clear" => :environment do
  queues = Resque.queues
  queues.each do |queue_name|
    puts "Clearing #{queue_name}..."
    Resque.redis.del "queue:#{queue_name}"
  end

  puts "Clearing delayed..." # in case of scheduler - doesn't break if no scheduler module is installed
  Resque.redis.keys("delayed:*").each do |key|
    Resque.redis.del "#{key}"
  end
  Resque.redis.del "delayed_queue_schedule"

  puts "Clearing stats..."
  Resque.redis.set "stat:failed", 0
  Resque.redis.set "stat:processed", 0
end

desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" => "resque:work"

desc "Alias for resque:work:background (To run workers on Heroku)"
task "jobs:work:background" => "resque:work:background"
