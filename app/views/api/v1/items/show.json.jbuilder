json.extract! @item, :id, :user_id, :is_giveaway, :item_type, :remark
json.comments @item.giveaways do |giveaway|
  json.extract! giveaway, :id, :user_id, :item_id, :status
  json.date giveaway.created_at.strftime("%m/%d/%y")
end
