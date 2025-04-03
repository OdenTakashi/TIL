require_relative '../controllers/home_controller'

def setup_routes(server)
  server.mount_proc '/' do |req, res|
    res.body = HomeController.new.index
  end
end
