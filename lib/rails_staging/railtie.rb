module RailsStaging
  class Railtie < Rails::Railtie
    initializer "rails_staging.configure_rails_initialization" do
      ActiveSupport.on_load :active_record do
        ActiveRecord::Relation.send(:include, RailsStaging::ModelMethods)
        ActionController::Base.send(:include, RailsStaging::ControllerMethods)
      end
    end
  end
end
