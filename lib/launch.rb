require "dockerfolder/command_line_args"
require "dockerfolder/version"

class Launch
  def initialize(argv)
    puts "Dockerfolder created."
    options = CommandLineArgs.new().parse_command_line(argv)
    puts "options: #{options}"
  end

  def run
    puts "Hello, cockboys!"
  end
end
