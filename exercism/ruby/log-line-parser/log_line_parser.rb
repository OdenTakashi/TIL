class LogLineParser
  def initialize(line)
    @line = line
  end

  def message
    @line.strip.sub(/^\[([A-Z]+)\]:\s*/, '')
  end

  def log_level
    @line.strip.match(/^\[([A-Z]+)\]:/)[1].downcase
  end

  def reformat
    level = log_level
    message_content = message
    "#{message_content} (#{level})"
  end
end
