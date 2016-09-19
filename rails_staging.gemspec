$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_staging/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_staging"
  s.version     = RailsStaging::VERSION
  s.authors     = ["Ben Mannell"]
  s.email       = ["benjamin.mannell@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of RailsStaging."
  s.description = "TODO: Description of RailsStaging."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.7.1"

  s.add_development_dependency "sqlite3"
end
