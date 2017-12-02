# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'marskal/core_ext/version'

Gem::Specification.new do |spec|
  spec.name          = "marskal-core_ext"
  spec.version       = Marskal::CoreExt::VERSION
  spec.authors       = ["Mike Urban"]
  spec.email         = ["mike@marskalgroup.com"]

  spec.summary       = %q{Many handy utilities to extend Ruby on Rails core functionality}
  spec.description   = %q{Extends many basic ruby modules/classes such as Array, String, Numeric, Date, I18n, File and more}
  spec.homepage      = "https://github.com/MarskalGroup/marskal-core_ext"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
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

  # spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", ">= 10.0", "<= 13.0"
  spec.add_development_dependency "minitest", "~> 5.1"
  spec.add_development_dependency "activesupport", "~> 4.2"
  spec.add_development_dependency "rdoc", "~> 5.0"
end
