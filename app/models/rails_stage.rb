class RailsStage < ::ActiveRecord::Base

  cattr_accessor :stage_creator
  cattr_accessor :stage_authorizer

  self.inheritance_column = :_type_disabled

  belongs_to :stageable, polymorphic: true

  ##
  # created the uuid
  # set other defaults
  before_create do |stage|
    stage.uuid = SecureRandom.uuid
    stage.creator = stage.class.stage_creator
  end

end
