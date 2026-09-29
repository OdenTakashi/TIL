# Ethernet II フレーム（FCS は含めない。NIC / ドライバが付ける）
#
#   6 bytes  宛先 MAC
#   6 bytes  送信元 MAC
#   2 bytes  EtherType
#  46..1500  ペイロード（不足分は 0 でパディング）
class EthernetFrame
  ETHERTYPE_EXPERIMENTAL = 0x88B5
  HEADER_SIZE = 14
  MIN_PAYLOAD = 46
  MAC_SIZE = 6

  attr_reader :destination_mac, :source_mac, :ethertype, :payload

  def initialize(destination_mac:, source_mac:, payload:, ethertype: ETHERTYPE_EXPERIMENTAL)
    @destination_mac = parse_mac(destination_mac)
    @source_mac = parse_mac(source_mac)
    @ethertype = Integer(ethertype)
    @payload = pad_payload(payload)
  end

  def to_bytes
    destination_mac + source_mac + [ethertype].pack("n") + payload
  end

  def destination_mac_string
    format_mac(destination_mac)
  end

  def source_mac_string
    format_mac(source_mac)
  end

  def self.parse(bytes)
    raw = bytes.to_s
    raise ArgumentError, "frame too short: #{raw.bytesize} bytes" if raw.bytesize < HEADER_SIZE

    new(
      destination_mac: raw.byteslice(0, MAC_SIZE),
      source_mac: raw.byteslice(MAC_SIZE, MAC_SIZE),
      ethertype: raw.byteslice(12, 2).unpack1("n"),
      payload: raw.byteslice(HEADER_SIZE, raw.bytesize - HEADER_SIZE)
    )
  end

  def inspect_lines
    text = payload.sub(/\x00+\z/, "")
    [
      "destination_mac #{destination_mac_string}",
      "source_mac      #{source_mac_string}",
      "ethertype       0x#{ethertype.to_s(16).rjust(4, "0")}",
      "payload         #{text.inspect} (#{payload.bytesize} bytes, padded)",
      "hex             #{to_bytes.unpack1("H*")}"
    ]
  end

  private

  def parse_mac(value)
    case value
    when String
      if value.include?(":") || value.include?("-")
        octets = value.split(/[:\-]/).map { |octet| Integer(octet, 16) }
        raise ArgumentError, "invalid MAC: #{value}" unless octets.size == MAC_SIZE && octets.all? { |octet| octet.between?(0, 255) }

        octets.pack("C*")
      else
        raise ArgumentError, "MAC must be 6 bytes" unless value.bytesize == MAC_SIZE

        value
      end
    else
      raise ArgumentError, "unsupported MAC: #{value.inspect}"
    end
  end

  def format_mac(bytes)
    bytes.unpack1("H*").scan(/../).join(":")
  end

  def pad_payload(value)
    raw = value.to_s.b
    raw = raw.ljust(MIN_PAYLOAD, "\x00") if raw.bytesize < MIN_PAYLOAD
    raw
  end
end
