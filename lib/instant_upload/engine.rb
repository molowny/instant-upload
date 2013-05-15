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

    initializer 'instant_upload.initialize' do
      ActiveSupport.on_load(:action_view) do
        include InstantUpload::Helpers::UploadHelper
      end

      ActiveSupport.on_load(:action_controller) do
        include InstantUpload::Helpers::ControllerHelper
      end
    end
  end
end
