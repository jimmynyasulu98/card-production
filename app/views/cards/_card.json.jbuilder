json.extract! card, :id, :cover_id, :location_id, :date_joined, :date_of_expiry, :created_at, :updated_at
json.url card_url(card, format: :json)
