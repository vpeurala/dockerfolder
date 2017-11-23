require "fileutils"

module Dockerfolder
  class FolderCreator
    def initialize(configuration)
      @configuration = configuration
      puts "FolderCreator created with configuration:\n#{@configuration}"
    end

    def run
      docker_directories = @configuration[:dirs]
      docker_directories.each do |docker_dir|
        FileUtils.mkdir_p(docker_dir)
        fill_directory(docker_dir)
      end
    end

    def fill_directory(docker_dir)

    end
  end
end