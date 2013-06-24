$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "instant_upload/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "instant-upload"
  s.version     = InstantUpload::VERSION
  s.authors     = ["Mariusz Ołownia"]
  s.email       = ["ollownia@gmail.com"]
  s.homepage    = "https://github.com/olownia/instant-upload"
  s.summary     = "Ajax upload for Rails."
  s.description = "Instant-upload is simply ajax upload for rails (with carrierwave)."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency 'rails', '> 3.2'
  # s.add_dependency 'carrierwave'
  # s.add_dependency 'haml'

  # s.add_development_dependency 'carrierwave'
  s.add_development_dependency 'mini_magick'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'pg'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'shoulda'
  s.add_development_dependency 'rspec-html-matchers'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'launchy'

  s.add_development_dependency 'database_cleaner', '1.0.0.RC1'

  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'rb-fsevent'

  s.add_development_dependency 'spork'
  s.add_development_dependency 'guard-spork'

  s.add_development_dependency 'terminal-notifier-guard' # OS X Notification Center
end
