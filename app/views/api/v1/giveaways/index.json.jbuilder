json.giveaways do
  json.array! @giveaways do |giveaway|
    json.extract! giveaway, :id, :user_id, :item_id, :status
  end
end
