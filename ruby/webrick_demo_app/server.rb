require 'webrick'

server = WEBrick::HTTPServer.new({
  BindAddress:    'localhost',
  Port:           3090,
})

server.mount('/', WEBrick::HTTPServlet::FileHandler, './html')
server.start
