local bit = require("bit")

DOWN = 'down'
LEFT = 'left'
RIGHT = 'right'
UP = 'up'
DIRECTIONS = { DOWN, LEFT, RIGHT, UP }

local AnimationController = {
  components_mask = bit.bor(COMPONENT_ANIMATION, COMPONENT_COLLIDER)
}

function AnimationController:update(ecs, e, dt)
  local key = love.keyboard.isDown
  local w, s, a, d = key('w'), key('s'), key('a'), key('d')

  e.animation.anim.type = "idle"

  -- @TODO: When player collides, do not animate walking 

  if w then
    e.animation.anim.type = "walk"
    e.animation.anim.dir = UP
  end
  if a then
    e.animation.anim.type = "walk"
    e.animation.anim.dir = LEFT
  end
  if d then
    e.animation.anim.type = "walk"
    e.animation.anim.dir = RIGHT
  end
  if s then
    e.animation.anim.type = "walk"
    e.animation.anim.dir = DOWN
  end

  e.animation.animations[e.animation.anim.type][e.animation.anim.dir]:update(dt)
end

function AnimationController:draw(ecs, e)
  local a = e.animation
  local anim = a.animations[e.animation.anim.type][e.animation.anim.dir]
  anim:draw(
    a.sheets[e.animation.anim.type],
    e.collider.x-16,
    e.collider.y-20)
end

return AnimationController
