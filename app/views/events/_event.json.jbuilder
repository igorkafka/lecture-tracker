json.extract! event, :id, :name, :date_scheduled, :created_at, :updated_at
json.url event_url(event, format: :json)
