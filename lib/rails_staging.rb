require "rails_staging/model_methods"

module RailsStaging


  require 'rails_staging/railtie' if defined?(Rails)

  module Rails
    class Engine < ::Rails::Engine
      paths["app/models"] << "lib/rails_staging/models"
    end
  end

end
