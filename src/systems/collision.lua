local bit = require("bit")

local CollisionSystem = {
  components_mask = bit.bor(COMPONENT_COLLIDER, COMPONENT_VELOCITY)
}

function rectanglesIntersect(rect1, rect2)
  return rect1.x < rect2.x + rect2.w and rect2.x < rect1.x + rect1.w
    and rect1.y < rect2.y + rect2.h and rect2.y < rect1.y + rect1.h
end

function CollisionSystem:update(ecs, e, dt)
    -- Check if the player's new position collides with any bodies in the world
    local collides = false
    for _, entity in pairs(ecs.entities) do
      if entity.collider and entity.id ~= e.id then
        if rectanglesIntersect({
        x = e.collider.x + e.velocity.x * dt,
        y = e.collider.y + e.velocity.y * dt,
        w = e.collider.w,
        h = e.collider.h
      }, entity.collider) then
          collides = true
          break
        end
      end
    end

    if not collides then
      e.collider.x = e.collider.x + e.velocity.x * dt
      e.collider.y = e.collider.y + e.velocity.y * dt
    end
end

function CollisionSystem:draw(ecs, e)
  if love.keyboard.isDown('p') then
  for _, body in pairs(ecs.entities) do
    if body.collider then
      love.graphics.rectangle("line", body.collider.x, body.collider.y, body.collider.w, body.collider.h)
    end

    love.graphics.print(tostring(e.velocity.x), 1000, 1000)
  end
  end
end

return CollisionSystem
