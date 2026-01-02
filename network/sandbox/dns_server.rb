require 'rubydns'

INTERFACES = [
  [:udp, "127.0.0.1", 5300],
  [:tcp, "127.0.0.1", 5300]
]

RubyDNS.run_server(INTERFACES) do
  match(/example\.test/, Resolv::DNS::Resource::IN::A) do |t|
    puts "[DNS] A example.test"
    t.respond!("127.0.0.1")
  end

  match(/example\.test/, Resolv::DNS::Resource::IN::AAAA) do |t|
    puts "[DNS] AAAA example.test"
    t.fail!(:NXDomain)
  end
end
