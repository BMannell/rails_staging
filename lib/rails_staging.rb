require "rails_staging/model_methods"
require "rails_staging/controller_methods"

module RailsStaging

  require 'rails_staging/railtie' if defined?(Rails)
  require "rails_staging/engine"

end
