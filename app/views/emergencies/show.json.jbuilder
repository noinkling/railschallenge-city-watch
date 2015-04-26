json.emergency do
  json.partial! @emergency
  json.responders @emergency.responders.pluck(:name)
end
