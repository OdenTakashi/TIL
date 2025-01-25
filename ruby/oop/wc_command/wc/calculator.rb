# frozen_string_literal: true

module Wc
  module Calculator
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

    def total_result(contents)
      total = {lines: 0, words: 0, bytes: 0, file_name: "total"}
      contents.each do |hash|
        total[:lines] += hash[:lines]
        total[:words] += hash[:words]
        total[:bytes] += hash[:bytes]
      end
      total
    end

    def remove_words_bytes(contents)
      contents.each do |content|
        content.delete(:words)
        content.delete(:bytes)
      end
      contents
    end
  end
end
