json.extract! member, :id, :first_name, :last_name, :date_of_birth, :date_joined, :cover_id, :location_id, :created_at, :updated_at
json.url member_url(member, format: :json)
