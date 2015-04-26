json.emergencies(@emergencies) do |emergency|
  json.extract! emergency, :code, :fire_severity, :police_severity, :medical_severity, :resolved_at
end
json.full_responses Emergency.full_response_score
