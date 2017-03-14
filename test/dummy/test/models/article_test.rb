require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  ##
  # Class Methods

  test "stage_class_method_exists" do
    assert Article.methods.include? :stage
  end


  ##
  # Intsance Methods

  test "association_exists" do
    assert Article.instance_methods.include? :rails_stages
  end

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


  ##
  # Functionality

  test "apply all" do
    article = create(:article)
    article.apply_all

    assert_not_nil article.title
    assert_not_nil article.content
    assert_not_nil article.image
  end

  test "apply all for a single column" do
    article = create(:article)
    article.apply_all

    assert_difference "RailsStage.count", 4 do
      article.update(title: "Something1")
      article.update(title: "Something2")
      article.update(title: "Something3")
      article.update(title: "Something4")
      assert_not_equal article.title, "Something4"
    end

    article.apply_all(:title)
    assert_equal article.title, "Something4"
  end

  test "current_version" do
    article = create(:article)
    stage = article.stage(:title, "Something")
    assert_not_equal article.current_version(:title), stage.uuid
    article.apply(stage.uuid)
    assert_equal article.current_version(:title), stage.uuid
  end
end
