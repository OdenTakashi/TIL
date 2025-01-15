module Wc
  class Runner
    def self.run
      options = Options.parse
      contents = ARGV.empty? ? StdinCalculator.run(options) : FileCalculator.run(options)

      Wc::Output.exec(contents)
    end
  end
end
