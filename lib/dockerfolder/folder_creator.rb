require "fileutils"

module Dockerfolder
  class FolderCreator
    def initialize(configuration)
      @docker_directories = configuration[:docker_directories]
      @options = configuration[:options]
      puts "FolderCreator created with configuration:\n#{configuration}"
    end

    def run
      @docker_directories.each do |docker_dir|
        FileUtils.mkdir_p(docker_dir)
        fill_directory(docker_dir)
      end
    end

    def fill_directory(docker_dir)
      if @options.key?(:base_image)
        IO.write("#{docker_dir}/Dockerfile", "FROM #{@options[:base_image]}\n")
      end
      if @options.key?(:docker_file)
        FileUtils.cp(@options[:docker_file], "#{docker_dir}/Dockerfile")
      end
    end
  end
end