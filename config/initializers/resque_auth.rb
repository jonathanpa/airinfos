Resque::Server.use(Rack::Auth::Basic) do |username, password|
  [username, password] == ["PeanutsTheBear", "CEOofRedate"]
end
