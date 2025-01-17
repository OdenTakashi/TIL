# frozen_string_literal: true

module Wc
  class Runner
    def self.run
      options = Options.parse
      contents = ARGV.empty? ? StdinCalculator.run(options) : FileCalculator.run(options)

      if ARGV.empty?
        Wc::Output.new.output_info_of_stdin(contents)
      else
        Wc::Output.new.output_info_of_file(contents)
      end
    end
  end
end
