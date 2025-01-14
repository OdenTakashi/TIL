module Wc
  class StdinCalculator
    def self.count_sizes_of_stdin(options)
      standard_input = $stdin.read
      standard_contents =
        [{ lines: count_lines(standard_input), words: count_words(standard_input), bytes: count_bytes(standard_input) }]
      standard_contents = remove_words_bytes(standard_contents) if options[:onlylines]

      return standard_contents
    end

    def count_lines(file_content)
      file_content.count("\n")
    end

    def count_words(file_content)
      ary = file_content.split(/\s+/)
      ary.size
    end

    def count_bytes(file_content)
      file_content.bytesize
    end
  end
end
