#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("lib", __dir__))
require "ethernet_frame"
require "raw_socket"

payload = ARGV[0] || "hello"
destination_mac = ARGV[1] || ENV.fetch("DST_MAC")
source_mac = ENV.fetch("SRC_MAC")
interface = ENV.fetch("IFACE") { RawSocket.interface_of(source_mac) }

frame = EthernetFrame.new(destination_mac:, source_mac:, payload:)
socket = RawSocket.new(interface:, protocol: EthernetFrame::ETHERTYPE_EXPERIMENTAL)
socket.send_frame(frame.to_bytes)
socket.close

warn "sent on #{interface}"
frame.inspect_lines.each { |line| warn line }
