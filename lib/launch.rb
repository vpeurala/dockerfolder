require "dockerfolder/command_line_args"
require "dockerfolder/version"
require "pp"

class Launch
  def initialize(argv)
    @options = CommandLineArgs.new().parse_command_line(argv)
  end

  def run()
    puts "@options: #{@options}"
    pp @options
    pp ARGV
  end
end
