class Item < ApplicationRecord
  # has_many_attached :photos
  has_one_attached :photo
  belongs_to :user
end
