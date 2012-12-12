#!/usr/bin/env ruby
# encoding: utf-8

require 'yaml'

ADAPTER   = 'mysql2'
ENCODING  = 'utf8'
DATABASE  = 'airinfos_production'
RECONNECT = false
POOL      = 5

def load_env
  YAML.load_file('/home/dotcloud/environment.yml')
end

def write_database_cfg_file
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

  File.open('/home/dotcloud/current/config/database.yml', 'w') do |file|
    file.write(db_cfg.to_yaml)
  end
end

puts '=== Writing database.yml ==='
write_database_cfg_file
puts '=== DONE ! ==='

