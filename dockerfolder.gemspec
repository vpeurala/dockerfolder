
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dockerfolder/version"

Gem::Specification.new do |spec|
  spec.name          = "dockerfolder"
  spec.version       = Dockerfolder::VERSION
  spec.authors       = ["Ville Peurala"]
  spec.email         = ["ville.peurala@gmail.com"]

  spec.summary       = %q{Generates a skeleton docker directory for you.}
  spec.description   = %q{A very simple code generator which makes a "docker folder" with scripts for building an image for your project, creating a container from it, starting and stopping it, and attaching to it (opening a terminal connection to your container). This is meant just as a starting point and you have to modify the generated sources a lot to suit your own project.}
  spec.homepage      = "https://github.com/vpeurala/dockerfolder"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
