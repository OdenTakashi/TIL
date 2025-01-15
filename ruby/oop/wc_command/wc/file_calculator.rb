module Wc
  class FileCalculator
    include Wc::Calculator

    def self.run(options)
      new.count_sizes_of_file(options)
    end

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
  end
end
