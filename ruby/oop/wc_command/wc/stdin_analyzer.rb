# frozen_string_literal: true

module Wc
  class StdinAnalyzer
    include Wc::Calculator

    def self.run(options)
      new.count_sizes_of_stdin(options)
    end

    def count_sizes_of_stdin(options)
      standard_input = $stdin.read
      standard_contents =
        [{ lines: count_lines(standard_input), words: count_words(standard_input), bytes: count_bytes(standard_input) }]
      standard_contents = remove_words_bytes(standard_contents) if options[:onlylines]

      standard_contents
    end
  end
end
