local Collider = {}
function Collider:new(x, y, w, h)
  local collider = {
    type = COMPONENT_COLLIDER,
    x = x,
    y = y,
    w = w,
    h = h
  }
  setmetatable(collider, self)
  collider.__index = self
  return collider
end

return Collider
