json.array!(@memories) do |memory|
  json.extract! memory, :id, :title, :description
  json.url memory_url(memory, format: :json)
end
