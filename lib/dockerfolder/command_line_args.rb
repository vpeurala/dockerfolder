require "optparse"

class CommandLineArgs
  def initialize()
  end

  def parse_command_line(argv)
    options = {}

    opt_parser = OptionParser.new do |opts|
      opts.program_name = $PROGRAM_NAME

      opts.version = "0.1.0"

      opts.banner = "Usage: #{opts.program_name} [options]"

      opts.on("-b", "--base-image IMAGE_NAME", "The Docker base image on which your Dockerfile is built. For example: --base-image='postgres:10-alpine'. This will be value of the FROM instruction in the generated Dockerfile if you don't supply an existing Dockerfile to #{$PROGRAM_NAME}.") do |image_name|
        options[:image_name] = image_name
      end

      opts.on("-c", "--container-name CONTAINER_NAME", "The name of the Docker container which will be built by the generated scripts. For example: --container-name='amqp-example'.") do |container_name|
        options[:container_name] = container_name
      end

      opts.on("-f", "--docker-file DOCKER_FILE", "The path to an already existing Dockerfile which you want to use. The file will be copied to the resulting folder of scripts. For example: --docker-file='/Users/vpeurala/templates/postgresql/Dockerfile'.")

      opts.on("-d", "--directory DIRECTORY_PATH", "The path to the directory which will be created. For example: --directory='scripts/dockerfolder' The default is ''./docker'.") do |directory_path|
        options[:directory_path] = directory_path
      end

      opts.on("-i", "--image-name IMAGE_NAME", "The name of the Docker image which will be built by the generated scripts from the Dockerfile. For example: --image-name='vpeurala/amqp-example:latest'.") do |image_name|
        options[:image_name] = image_name
      end
    end

    opt_parser.parse!(argv)

    options
  end
end
