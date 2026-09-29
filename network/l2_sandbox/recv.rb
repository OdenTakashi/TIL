#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("lib", __dir__))
require "ethernet_frame"
require "raw_socket"

interface_names =
  if ENV.key?("IFACE")
    [ENV["IFACE"]]
  elsif ENV.key?("LISTEN_MAC")
    [RawSocket.interface_of(ENV["LISTEN_MAC"])]
  else
    RawSocket.interfaces
  end

sockets = interface_names.map do |interface_name|
  RawSocket.new(interface: interface_name, protocol: EthernetFrame::ETHERTYPE_EXPERIMENTAL)
end

sockets.each do |socket|
  warn "listening on #{socket.interface} (#{RawSocket.mac_address_of(socket.interface)}) ethertype 0x#{EthernetFrame::ETHERTYPE_EXPERIMENTAL.to_s(16)}"
end
warn "Ctrl-C で終了"

loop do
  ready, = IO.select(sockets.map(&:to_io))
  ready.each do |ready_io|
    socket = sockets.find { |candidate| candidate.to_io == ready_io }
    frame = EthernetFrame.parse(socket.receive_frame)
    puts "---- received on #{socket.interface} (#{RawSocket.mac_address_of(socket.interface)}) ----"
    frame.inspect_lines.each { |line| puts line }
    $stdout.flush
  end
end
