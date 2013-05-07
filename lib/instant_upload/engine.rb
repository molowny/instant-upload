module InstantUpload
  class Engine < ::Rails::Engine
    isolate_namespace InstantUpload

    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'

      g.view_specs false
      g.helper_specs false

      g.stylesheets = false
      g.javascripts = false
    end
  end
end
