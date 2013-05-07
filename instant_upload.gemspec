$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "instant_upload/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "instant-upload"
  s.version     = InstantUpload::VERSION
  s.authors     = ["Mariusz Ołownia"]
  s.email       = ["ollownia@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of InstantUpload."
  s.description = "TODO: Description of InstantUpload."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'rails', '~> 4.0.0.rc1'
  s.add_dependency 'carrierwave'

  s.add_development_dependency 'carrierwave'
  s.add_development_dependency 'mini_magick'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'pg'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'shoulda'
  # s.add_development_dependency 'webmock'

  s.add_development_dependency 'database_cleaner', '1.0.0.RC1'

  # s.add_development_dependency 'capybara'

  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'rb-fsevent'

  s.add_development_dependency 'spork'
  s.add_development_dependency 'guard-spork'

  s.add_development_dependency 'terminal-notifier-guard' # OS X Notification Center
end
