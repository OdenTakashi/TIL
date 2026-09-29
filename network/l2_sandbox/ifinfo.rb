#!/usr/bin/env ruby
# frozen_string_literal: true

hostname = ENV.fetch("HOSTNAME", `hostname`.strip)
puts "host     #{hostname}"

Dir.children("/sys/class/net").sort.each do |interface_name|
  next if interface_name == "lo"

  mac_address = File.read("/sys/class/net/#{interface_name}/address").strip
  addresses = `ip -br addr show #{interface_name}`.strip
  master_path = "/sys/class/net/#{interface_name}/master"
  master = File.symlink?(master_path) ? " master=#{File.basename(File.readlink(master_path))}" : ""
  puts "interface #{interface_name}  mac #{mac_address}#{master}  #{addresses}"
end
