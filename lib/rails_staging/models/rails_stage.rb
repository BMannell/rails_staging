class RailsStage < ::ActiveRecord::Base
  ##
  # created the uuid 
  # set other defaults
  before_create do |user|
    user.uuid = SecureRandom.uuid
  end
end
