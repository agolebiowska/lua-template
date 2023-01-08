local bit = require("bit")

local CameraFollowSystem = {}
CameraFollowSystem.__index = CameraFollowSystem

local CameraFollowSystem = {
  components_mask = bit.bor(COMPONENT_COLLIDER, COMPONENT_TAG)
}

function CameraFollowSystem:update(ecs, e, dt)
  if e.tag.name == "Player" then
    local cs = stack:peek()
    if cs and cs.cam then
      cs.cam:follow(e.collider)
    end
  end
end

function CameraFollowSystem:draw(ecs, e)
end

return CameraFollowSystem
