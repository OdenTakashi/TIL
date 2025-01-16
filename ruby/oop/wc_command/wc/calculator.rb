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
  end
end
