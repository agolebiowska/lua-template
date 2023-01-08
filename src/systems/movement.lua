local bit = require("bit")

local MovementSystem = {}
MovementSystem.__index = MovementSystem

local MovementSystem = {
  components_mask = bit.bor(COMPONENT_VELOCITY, COMPONENT_TAG)
}

function MovementSystem:update(ecs, e, dt)
  local key = love.keyboard.isDown
  local w, s, a, d = key('w'), key('s'), key('a'), key('d')
  local speed = 30

  if e.tag.name == "Player" then
    e.velocity.x = 0
    e.velocity.y = 0

    if w then
      e.velocity.y = speed * -1
    end
    if a then
      e.velocity.x = speed * -1
    end
    if d then
      e.velocity.x = speed
    end
    if s then
      e.velocity.y = speed
    end
  end
end

function MovementSystem:draw(ecs, e)
end

return MovementSystem
