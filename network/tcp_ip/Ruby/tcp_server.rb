require 'socket'

begin
  server = TCPServer.open(3030)
  puts 'Waiting for client to connect..'
  socket = server.accept
  puts 'Client connected'

  File.open('server_recieve.txt', 'w') do |f|
    while (character = socket.read(1)) != 'E'
      f.write(character)
    end
  end

  File.foreach('server_send.txt') do |file_line|
    socket.write(file_line)
  end

rescue => e
  puts e
ensure
  socket.close
  server.close
end
