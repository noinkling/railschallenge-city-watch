json.emergency do
  json.extract! @emergency, :code, :fire_severity, :police_severity, :medical_severity, :resolved_at, :created_at, :updated_at
end
