require "dockerfolder/command_line_args"
require "dockerfolder/folder_creator"
require "dockerfolder/version"

module Dockerfolder
  def self.run(argv)
    configuration = CommandLineArgs.new.parse_command_line(argv)
    if configuration[:proceed]
      FolderCreator.new({:dirs => configuration[:argv], :options => configuration[:options]}).run
    else
      puts configuration[:help]
      puts
    end
  end
end
