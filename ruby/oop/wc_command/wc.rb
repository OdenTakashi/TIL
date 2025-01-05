class Wc
  def self.run
    options = Wc::Options.parse

    if ARGV.empty?
      contents = Wc::StdinCalculator.run(options)
      Wc::Output.exec(contents)
    else
      contents = Wc::FileCalculator.run(options)
      Wc::Output.exec(contents)
    end
  end
end
