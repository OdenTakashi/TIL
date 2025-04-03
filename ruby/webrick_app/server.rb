require 'webrick'
require_relative './app/config/routes.rb'

server = WEBrick::HTTPServer.new(
  Port: 3000,
  DocumentRoot: './public'
)

setup_routes(server)

server.start
