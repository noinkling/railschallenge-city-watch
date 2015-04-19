json.array!(@emergencies) do |emergency|
  json.extract! emergency, :id, :code, :fire_severity, :police_severity, :medical_severity, :resolved_at
  json.url emergency_url(emergency, format: :json)
end
