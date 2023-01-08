local anim8 = require("lib.anim8")

local Animation = {}
function Animation:new(speed, x, y, sheets)
  local grids = {}
  grids.walk = anim8.newGrid(x, y, sheets.walk:getWidth(), sheets.walk:getHeight())
  grids.idle = anim8.newGrid(x, y, sheets.idle:getWidth(), sheets.idle:getHeight())

  local animations = {
    walk = {},
    idle = {}
  }

  for key, value in pairs(DIRECTIONS) do
    animations.walk[value] = anim8.newAnimation(grids.walk('1-6', key), speed)
    animations.idle[value] = anim8.newAnimation(grids.idle('1-5', key), speed)
  end

  local anim = {
    type = 'idle',
    dir = DOWN
  }

  local animation = {
    type = COMPONENT_ANIMATION,
    animations = animations,
    sheets = sheets,
    anim = anim
  }
  setmetatable(animation, self)
  animation.__index = self
  return animation
end

return Animation