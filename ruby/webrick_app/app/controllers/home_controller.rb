require_relative 'base_controller'

class HomeController < BaseController
  # This method is called when the root URL is accessed.
  # It renders the 'home' view with a title.
  #
  # @return [void]
  # @example
  #   GET /
  #   => Renders the home view with a title.
  def index
    render('home', title: "Welcome to WEBrick App")
  end
end
