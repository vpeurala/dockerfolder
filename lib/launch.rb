require "dockerfolder/command_line_args"
require "dockerfolder/version"

class Launch
  def initialize(argv)
    @options = CommandLineArgs.new().parse_command_line(argv)
  end

  def run()
    puts "@options: #{@options}"
  end
end
