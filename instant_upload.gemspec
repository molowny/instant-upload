$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "instant_upload/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "instant_upload"
  s.version     = InstantUpload::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of InstantUpload."
  s.description = "TODO: Description of InstantUpload."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.0.rc1"

  s.add_development_dependency "sqlite3"
end
