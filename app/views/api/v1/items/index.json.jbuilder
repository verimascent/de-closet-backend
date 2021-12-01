json.items do
  json.array! @items do |item|
    json.extract! item, :id, :user_id, :is_giveaway, :item_type, :remark
  end
end
