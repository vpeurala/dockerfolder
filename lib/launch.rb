require "dockerfolder/command_line_args"
require "dockerfolder/version"
require "pp"

class Launch
  def initialize(argv)
    @configuration = CommandLineArgs.new.parse_command_line(argv)
  end

  def run()
    unless @configuration[:proceed]
      puts @configuration[:help]
    else
      puts "Starting! #{pp @configuration}"
    end
  end
end
