require 'erb'

class BaseController
  def render(template, locals = {})
    path = File.expand_path("../views/#{template}.html.erb", __dir__)
    erb_template = ERB.new(File.read(path))
    erb_template.result_with_hash(locals)
  end
end
