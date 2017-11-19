require "optparse"

class CommandLineArgs
  def initialize()
  end

  def parse_command_line(argv)
    options = {}
    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: #{$0} [options]"

      opts.on("-c", "--container-name CONTAINER_NAME") do |container_name|
        options[:container_name] = container_name
      end

      opts.on("-d", "--directory directory_name") do |directory_name|
        options[:directory_name] = directory_name
      end

      opts.on("-i", "--image-name IMAGE_NAME") do |image_name|
        options[:image_name] = image_name
      end
    end

    opt_parser.parse!(argv)

    options
  end
end
