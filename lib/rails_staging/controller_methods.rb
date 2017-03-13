module RailsStaging

  module ControllerMethods

    extend ActiveSupport::Concern

    included do
      append_before_filter :set_rails_staging_creator
      append_before_filter :set_rails_staging_authorizer
    end

    def set_rails_staging_creator
      ##
      # function to be overwritten in the application controller
      # RailsStage.stage_creator = ""
      # 
    end
    def set_rails_staging_authorizer
      ##
      # function to be overwritten in the application controller
      # RailsStage.stage_authorizer = ""
      # 
    end
  end

end