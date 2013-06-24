module InstantUpload
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def create_migrations
        rake 'instant_upload:install:migrations'
      end
    end
  end
end
