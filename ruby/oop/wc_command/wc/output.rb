module Wc
  class Output
    def self.exec(contents)
      new.output_info_of_file(contents)
    end

    def output_info_of_file(contents)
      contents.each do |content|
        puts "#{content[:lines]} #{content[:words]} #{content[:bytes]} #{content[:file_name]}"
      end
    end

    def output_info_of_stdin(standard_contents)
      standard_contents.each do |standard_content|
        puts "#{standard_content[:lines]} #{standard_content[:words]} #{standard_content[:bytes]}"
      end
    end
  end
end
