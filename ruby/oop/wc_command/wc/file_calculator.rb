module Wc
  class FileCalculator
    def count_sizes_of_file(params)
      filenames = ARGV
      contents = filenames.map do |filename|
        file_content = File.read(filename)
        { lines: count_lines(file_content), words: count_words(file_content), bytes: count_bytes(file_content), file_name: filename }
      end
      contents << total_result(contents) if filenames.count > 1
      contents = remove_words_bytes(contents) if params[:onlylines]

      return contents
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
