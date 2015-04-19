json.emergencies(@emergencies) do |emergency|
  json.extract! emergency, :code, :fire_severity, :police_severity, :medical_severity, :resolved_at
end
