json.extract! @giveaway, :id, :user_id, :item_id, :status
json.giveaway @item.giveaways do |giveaway|
  json.extract! giveaway, :id, :user_id, :item_id, :status
  json.date giveaway.created_at.strftime("%m/%d/%y")
end
