#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require "ethernet_frame"

frame = EthernetFrame.new(
  destination_mac: "02:00:00:00:00:0b",
  source_mac: "02:00:00:00:00:0a",
  payload: "hello"
)
bytes = frame.to_bytes
raise "header+payload size" unless bytes.bytesize == 14 + 46
raise "destination_mac" unless bytes.byteslice(0, 6).unpack1("H*") == "02000000000b"
raise "source_mac" unless bytes.byteslice(6, 6).unpack1("H*") == "02000000000a"
raise "ethertype" unless bytes.byteslice(12, 2).unpack1("n") == 0x88B5
raise "payload" unless bytes.byteslice(14, 5) == "hello"

parsed = EthernetFrame.parse(bytes)
raise "roundtrip destination_mac" unless parsed.destination_mac_string == "02:00:00:00:00:0b"
raise "roundtrip source_mac" unless parsed.source_mac_string == "02:00:00:00:00:0a"
raise "roundtrip ethertype" unless parsed.ethertype == 0x88B5

puts "ok #{bytes.bytesize} bytes"
puts frame.inspect_lines
