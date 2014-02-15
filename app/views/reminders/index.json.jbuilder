json.array!(@reminders) do |reminder|
  json.extract! reminder, :id, :name, :description, :due, :issued, :updated, :status, :priority, :issuer
  json.url reminder_url(reminder, format: :json)
end
