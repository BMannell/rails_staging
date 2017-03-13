require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def test_stage_class_method_exists
    assert Article.methods.include? :stage
  end

  # def test_revert_method_exists
  #   assert Article.instance_methods.include? :revert
  # end

  def test_revert_to_method_exists
    assert Article.instance_methods.include? :revert_to
  end

  def test_history_method_exists
    assert Article.instance_methods.include? :history
  end

  def test_apply_method_exists
    assert Article.instance_methods.include? :apply
  end

  def test_stage_instance_method_exists
    assert Article.instance_methods.include? :stage
  end

  def test_new_setter_method_exists
    assert Article.instance_methods.include? :set_title
  end

  def test_setter
    assert_difference "RailsStage.count", 1 do
      article = create(:article)
      article.title = "Something"
      assert_not article.title, "Something"
    end
  end

  def test_apply_single_column_all_stages
    article = create(:article)

    assert_difference "RailsStage.count", 1 do
      article.title = "Something"
      assert_not article.title, "Something"
    end

    article.apply_all(:title)
    assert article.title, "Something"
  end

  def test_revert_to
    assert true
  end


  def test_current_version
    article = Article.new
    stage = article.stage(:title, "Something")
    assert_not_equal article.current_version(:title), stage.uuid
    article.apply(stage.uuid)
    assert_equal article.current_version(:title), stage.uuid
  end
end
