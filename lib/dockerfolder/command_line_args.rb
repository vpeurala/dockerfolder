require "dockerfolder/version"
require "etc"
require "optparse"

class CommandLineArgs
  def initialize()
  end

  def error_message(msg)
    STDERR.puts(msg)
    STDERR.puts
  end

  def parse_command_line(argv)
    options = {}

    proceed = true

    opt_parser = OptionParser.new do |opts|
      opts.program_name = $PROGRAM_NAME

      opts.version = Dockerfolder::VERSION

      opts.banner = <<-EOS
Usage: #{opts.program_name} [OPTIONS] DIRECTORY

Parameter DIRECTORY is the path to the directory which will be created by this command, containing a Dockerfile and some useful scripts for building an image from it and doing things with the image and the container(s) created from it.

Examples:
  #{opts.program_name} docker
  #{opts.program_name} --base-image="alpine:3.6" --container-name="amqp-example" --docker-file="/Users/vpeurala/dockerfiles/amqp.example.dockerfile" --image-name="vpeurala/amqp-example:latest" docker-amqp.example
  #{opts.program_name} --base-image="postgres:10-alpine" docker-db

Options:
      EOS

      opts.on("-b", "--base-image IMAGE_NAME", "The Docker base image on which your Dockerfile is built. For example: --base-image=\"postgres:10-alpine\". This will be value of the FROM instruction in the generated Dockerfile if you don't supply an existing Dockerfile to #{$PROGRAM_NAME}. If you don't supply a value to this option, the default value is \"alpine:3.6\".") do |base_image|
        options[:base_image] = base_image
      end

      opts.on("-c", "--container-name CONTAINER_NAME", "The name of the Docker container which will be built by the generated scripts. For example: --container-name=\"amqp-example\". If you don't supply a value to this option, the default value will be the name of the git repository containing the resulting docker directory, as obtained by command \"git rev-parse --show-toplevel\".") do |container_name|
        options[:container_name] = container_name
      end

      opts.on("-d", "--docker-file DOCKER_FILE", "The path to an already existing Dockerfile which you want to use. The file will be copied to the resulting folder of scripts with name \"Dockerfile\". For example: --docker-file=\"/Users/vpeurala/templates/postgresql/Dockerfile\".") do |docker_file|
        options[:docker_file] = docker_file
      end

      opts.on("-i", "--image-name IMAGE_NAME", "The name of the Docker image which will be built by the generated scripts from the Dockerfile. For example: --image-name=\"vpeurala/amqp-example:latest\". If you don't supply a value to this option, the default value will be your username (for example: vpeurala), slash, name of the git repository containing the resulting docker directory, as obtained by command \"git rev-parse --show-toplevel\" (for example: amqp-example), colon, \"latest\"; in this example, it would be \"vpeurala/amqp-example:latest\".") do |image_name|
        options[:image_name] = image_name
      end
    end

    opt_parser.parse!(argv)

    if argv.length == 0
      error_message("ERROR: Missing mandatory parameter DIRECTORY.")
      proceed = false
    end

    if options.key?(:docker_file)
      docker_file_name = options[:docker_file]
      unless File.exist?(docker_file_name)
        error_message("ERROR: File \"#{docker_file_name}\", given as the value of option -d/--docker-file, does not exist.")
        proceed = false
      end
      if File.directory?(docker_file_name)
        error_message("ERROR: File \"#{docker_file_name}\", given as the value of option -d/--docker-file, is a directory. It must be an ordinary file.")
        proceed = false
      end
      if proceed && !File.readable?(docker_file_name)
        error_message("ERROR: File \"#{docker_file_name}\", given as the value of option -d/--docker-file, is not readable by user \"#{Etc.getlogin}\".")
        proceed = false
      end
    end

    unless options.key?(:base_image)
      options[:base_image] = "alpine:3.6"
    end

    unless options.key?(:container_name)
      options[:container_name] = File.basename(`git rev-parse --show-toplevel`.chomp)
    end

    unless options.key?(:image_name)
      username = Etc.getlogin
      git_repository_name = File.basename(`git rev-parse --show-toplevel`.chomp)
      options[:image_name] = "#{username}/#{git_repository_name}:latest"
    end

    {:options => options, :argv => argv, :proceed => proceed, :help => opt_parser.help}
  end
end
