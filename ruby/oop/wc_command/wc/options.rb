# frozen_string_literal: true

require 'optparse'

module Wc
  class Options
    def self.parse
      params = {}
      opt = OptionParser.new
      opt.on('-l', '--onlylines') { |v| v }
      opt.parse!(ARGV, into: params)

      params
    end
  end
end
