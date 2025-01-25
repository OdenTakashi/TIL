# frozen_string_literal: true

module Wc
  class Runner
    def self.run
      dfdsddsds
      options = Options.parse
      contents = ARGV.empty? ? StdinAnalyzer.run(options) : FileAnalyzer.run(options)

      if ARGV.empty?
        Output.new.output_info_of_stdin(contents)
      else
        Output.new.output_info_of_file(contents)
      end
    end
  end
end
