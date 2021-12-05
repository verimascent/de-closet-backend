class Item < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  acts_as_taggable_on :tags
end
