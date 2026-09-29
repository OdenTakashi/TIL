require "socket"

# Linux の AF_PACKET で、IP を介さず Ethernet フレームを送受信する
class RawSocket
  ETH_P_ALL = 0x0003

  attr_reader :interface

  def initialize(interface:, protocol: ETH_P_ALL)
    @interface = interface
    @protocol = protocol
    @interface_index = File.read("/sys/class/net/#{interface}/ifindex").to_i
    @socket = Socket.new(Socket::AF_PACKET, Socket::SOCK_RAW, host_to_network_short(protocol))
    @socket.bind(link_layer_socket_address)
  end

  def to_io
    @socket
  end

  def send_frame(bytes)
    @socket.send(bytes, 0)
  end

  def receive_frame(max_bytes = 2048)
    @socket.recv(max_bytes)
  end

  def close
    @socket.close
  end

  def self.interfaces
    Dir.children("/sys/class/net").reject { |interface_name| interface_name == "lo" }.sort
  end

  def self.mac_address_of(interface)
    File.read("/sys/class/net/#{interface}/address").strip
  end

  def self.interface_of(mac_address)
    wanted = mac_address.downcase
    interfaces.each do |interface_name|
      return interface_name if mac_address_of(interface_name).downcase == wanted
    end
    raise "no interface with MAC #{mac_address}"
  end

  private

  def host_to_network_short(value)
    [value].pack("n").unpack1("S")
  end

  def link_layer_socket_address
    [
      Socket::AF_PACKET,
      host_to_network_short(@protocol),
      @interface_index,
      0,
      0,
      0,
      *([0] * 8)
    ].pack("SSiSCCC8")
  end
end
