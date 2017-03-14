class Article < ActiveRecord::Base
  belongs_to :user
  stage :title, :content
  stage :image
end
