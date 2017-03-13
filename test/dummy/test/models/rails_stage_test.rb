class RailsStageTest < ActiveSupport::TestCase

  def test_current_creater_exists
    assert RailsStage.methods.include? :stage_creator
  end

  def test_stage_creater_sets
    RailsStage.stage_creator = "TestUser"
    assert_equal "TestUser", RailsStage.stage_creator
  end

  def test_current_authorizer_exists
    assert RailsStage.methods.include? :stage_authorizer
  end

  def test_stage_authorizer_sets
    RailsStage.stage_authorizer = "TestAdmin"
    assert_equal "TestAdmin", RailsStage.stage_authorizer
  end
  
end
