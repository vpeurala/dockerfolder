require "dockerfolder/version"
require "optparse"

class CommandLineArgs
  def initialize()
  end

  def parse_command_line(argv)
    options = {}

    opt_parser = OptionParser.new do |opts|
      opts.program_name = $PROGRAM_NAME

      opts.version = VERSION

      opts.banner = <<-EOS
Usage: #{opts.program_name} [OPTIONS] DIRECTORY
Examples:
  #{opts.program_name} docker
  #{opts.program_name} --base-image="alpine:3.6" --container-name="amqp-example" --docker-file="/Users/vpeurala/dockerfiles/amqp.example.dockerfile" --image-name="vpeurala/amqp-example:latest" docker-amqp.example
  #{opts.program_name} --base-image="postgres:10-alpine" docker-db
EOS

      opts.on("-b", "--base-image IMAGE_NAME", "The Docker base image on which your Dockerfile is built. For example: --base-image=\"postgres:10-alpine\". This will be value of the FROM instruction in the generated Dockerfile if you don't supply an existing Dockerfile to #{$PROGRAM_NAME}. If you don't supply a value to this option, the default value is \"alpine:3.6\".") do |image_name|
        options[:image_name] = image_name
      end

      opts.on("-c", "--container-name CONTAINER_NAME", "The name of the Docker container which will be built by the generated scripts. For example: --container-name=\"amqp-example\". If you don't supply a value to this option, the default value will be the name of the git repository containing the resulting docker directory, as obtained by command \"git rev-parse --show-toplevel\".") do |container_name|
        options[:container_name] = container_name
      end

      opts.on("-f", "--docker-file DOCKER_FILE", "The path to an already existing Dockerfile which you want to use. The file will be copied to the resulting folder of scripts with name \"Dockerfile\". For example: --docker-file=\"/Users/vpeurala/templates/postgresql/Dockerfile\".") do |docker_file|
        options[:docker_file] = docker_file
      end

      opts.on("-i", "--image-name IMAGE_NAME", "The name of the Docker image which will be built by the generated scripts from the Dockerfile. For example: --image-name=\"vpeurala/amqp-example:latest\". If you don't supply a value to this option, the default value will be your username (for example: vpeurala), slash, name of the git repository containing the resulting docker directory, as obtained by command \"git rev-parse --show-toplevel\" (for example: amqp-example), colon, latest; in this example, it would be \"vpeurala/amqp-example:latest\".") do |image_name|
        options[:image_name] = image_name
      end
    end

    opt_parser.parse!(argv)

    options
  end
end
