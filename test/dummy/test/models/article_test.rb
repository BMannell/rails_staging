require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  ##
  # Class Methods

  test "stage_class_method_exists" do
    assert Article.methods.include? :stage
  end

  ##
  # Intsance Methods
  #
  test "association_exists" do
    assert Article.instance_methods.include? :rails_stages
  end

  # test "revert_method_exists" do
  #   assert Article.instance_methods.include? :revert
  # end

  test "revert_to_method_exists" do
    assert Article.instance_methods.include? :revert_to
  end

  test "history_method_exists" do
    assert Article.instance_methods.include? :history
  end

  test "apply_method_exists" do
    assert Article.instance_methods.include? :apply
  end

  test "stage_instance_method_exists" do
    assert Article.instance_methods.include? :stage
  end

  test "new_setter_method_exists" do
    assert Article.instance_methods.include? :set_title
  end

  test "setter" do
    assert_difference "RailsStage.count", 1 do
      article = create(:article)
      article.title = "Something"
      assert_not article.title, "Something"
    end
  end

  test "apply_single_column_all_stages" do
    article = create(:article)

    assert_difference "RailsStage.count", 1 do
      article.title = "Something"
      assert_not article.title, "Something"
    end

    article.apply_all(:title)
    assert article.title, "Something"
  end

  test "revert_to" do
    assert true
  end


  test "current_version" do
    article = Article.new
    stage = article.stage(:title, "Something")
    assert_not_equal article.current_version(:title), stage.uuid
    article.apply(stage.uuid)
    assert_equal article.current_version(:title), stage.uuid
  end
end
