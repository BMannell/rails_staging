module RailsStaging
  class Railtie < Rails::Railtie
    initializer "rails_staging.configure_rails_initialization" do
      ActiveSupport.on_load :active_record do
        ActiveRecord::Base.send(:include, RailsStaging::ModelMethods)
      end
    end
  end
end
