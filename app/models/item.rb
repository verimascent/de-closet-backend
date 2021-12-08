class Item < ApplicationRecord
  has_many :giveaways, dependent: :destroy
  has_one_attached :photo
  belongs_to :user
  acts_as_taggable_on :tags

  def to_h
    h = serializable_hash
    h['photo'] = photo.service_url
    h
  end

  def all_info
    @item = self.to_h
    @item['giveaway_info'] = Giveaway.where(item_id: @item['id'].to_i)
    @item
  end
end
