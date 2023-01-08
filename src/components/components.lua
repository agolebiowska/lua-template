-- Simple components that do not requires complex setup
-- Other compoments has their corresponding files

function Velocity(x, y)
  return {
    type = COMPONENT_VELOCITY,
    x = x,
    y = y
  }
end

function Tag(name)
  return {
    type = COMPONENT_TAG,
    name = name
  }
end
