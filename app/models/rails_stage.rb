class RailsStage < ::ActiveRecord::Base

  cattr_accessor :stage_creator
  cattr_accessor :stage_authorizer

  self.inheritance_column = :_type_disabled

  ##
  # created the uuid
  # set other defaults
  before_create do |stage|
    stage.uuid = SecureRandom.uuid
    stage.creator = stage.class.stage_creator
  end

  def value
    case self.type
    when "Float"
      self.text_value.to_f
    when "Integer"
      self.text_value.to_i
    when "Complex"
      self.text_value.to_c
    when "Rational"
      self.text_value.to_r
    else
      self.text_value
    end
  end
end
