require "dockerfolder/version"
require "optparse"

module Dockerfolder
  class Dockerfolder
    def initialize(argv)
      puts "Dockerfolder created!"
      validate(argv)
    end

    def validate(argv)
    end

    def run
      puts "Hello, cockboys!"
    end
  end
end
