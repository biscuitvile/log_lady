$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "log_lady/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "log_lady"
  s.version     = LogLady::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of LogLady."
  s.description = "TODO: Description of LogLady."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.8"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "pry"
end
