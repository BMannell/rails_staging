class Article < ActiveRecord::Base
  belongs_to :user
  has_many :rails_stages, as: :stageable
end
