class RailsStage < ::ActiveRecord::Base

  cattr_accessor :stage_creator
  cattr_accessor :stage_authorizer

  self.inheritance_column = :_type_disabled

  belongs_to :stageable, polymorphic: true

  ##
  # created the uuid
  # set other defaults
  before_validation :set_defaults, on: :create

  def value
    case self.type
    when "Float"
      self.value.to_f
    when "Integer"
      self.value.to_i
    when "Complex"
      self.value.to_c
    when "Rational"
      self.value.to_r
    else
      self.value
    end
  end

  private

  def set_deafults
    uuid = SecureRandom.uuid
    creator = self.class.stage_creator || ""
  end
end
