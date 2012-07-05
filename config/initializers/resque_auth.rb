Resque::Server.use(Rack::Auth::Basic) do |username, password|
  [username, password] == [ENV['RESQUE_USER'], ENV['RESQUE_PASSWORD']]
end
