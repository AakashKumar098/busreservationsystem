json.extract! bus, :id, :busname, :bus_no, :source_route, :destination_route, :noofseat, :arrival_time, :owner_id, :created_at, :updated_at
json.url bus_url(bus, format: :json)
