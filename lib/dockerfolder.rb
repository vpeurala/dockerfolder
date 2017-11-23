require "dockerfolder/command_line_args"
require "dockerfolder/folder_creator"
require "dockerfolder/version"

module Dockerfolder
  def self.run(argv)
    configuration = CommandLineArgs.new.parse_command_line(argv)
    unless configuration[:proceed]
      puts configuration[:help]
    else
      FolderCreator.new(configuration).run
    end
  end
end
