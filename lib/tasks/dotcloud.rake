namespace :dotcloud do

  ADAPTER   = 'mysql2'
  ENCODING  = 'utf8'
  DATABASE  = 'airinfos_production'
  RECONNECT = false
  POOL      = 5

  desc 'Setup database.yml from sample'
  task setup_db_yml: :environment do
    env = load_env

    db_cfg = {
      'production' => {
      'adapter' => ADAPTER,
      'encoding' => ENCODING,
      'reconnect' => RECONNECT,
      'database' => DATABASE,
      'pool' => POOL,
      'username' => env['DOTCLOUD_DATA_MYSQL_LOGIN'],
      'password' => env['DOTCLOUD_DATA_MYSQL_PASSWORD'],
      'host' => env['DOTCLOUD_DATA_MYSQL_HOST'],
      'port' => env['DOTCLOUD_DATA_MYSQL_PORT'].to_i
    }
    }

    puts '=== Writing database.yml ==='

    File.open('/home/dotcloud/current/config/database.yml', 'w') do |file|
      file.write(db_cfg.to_yaml)
    end

    puts '=== DONE ! ==='
  end

  desc 'Test task'
  task test: :environment do
    puts 'Hello World!'
  end

  def load_env
    YAML.load_file('/home/dotcloud/environment.yml')
  end

end
