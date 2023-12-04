require 'socket'

socket = TCPSocket.new('localhost', 3030)

File.foreach('client_send.txt') do |file_line|
  socket.write(file_line)
end

socket.write('E')

File.open('client_receive.txt', 'w') do |f|
  while character = socket.read(1)
    f.write(character)
  end
end
