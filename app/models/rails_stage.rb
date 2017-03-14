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

  scope :applied, ->{where.not(applied_at: nil)}
  scope :not_applied, ->{where(applied_at: nil)}

  def apply
    stageable.update_attribute(column, value)
    touch(:applied_at)
  end

end
