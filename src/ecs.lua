local bit = require("bit")

--[[
In Lua 5.1 (JIT), the bitwise shift operators (<< and >>)
are not available so we use "bit" lib
]]--
COMPONENT_CAMERA = bit.lshift(1, 0)-- 1
COMPONENT_VELOCITY = bit.lshift(1, 1) -- 2
COMPONENT_TAG = bit.lshift(1, 2) -- 4
COMPONENT_COLLIDER = bit.lshift(1, 3) -- 8
COMPONENT_ANIMATION = bit.lshift(1, 4)

local ECS = {}

function ECS:new()
 local ecs = {
    entities = {},
    systems = {}
  }
  setmetatable(ecs, self)
  self.__index = self
  return ecs
end

function ECS:create_entity()
  return {
    id = #self.entities + 1,
    components = 0
  }
end

function ECS:add_entity(entity)
  self.entities[entity.id] = entity
end

function ECS:remove_entity(entity)
  for i, e in ipairs(self.entities) do
    if e.id == entity.id then
      table.remove(self.entities, i)
      return
    end
  end
end

function ECS:add_component(entity, instance)
  local component = instance.type
  entity.components = bit.bor(entity.components, component)

  if component == COMPONENT_CAMERA then
    entity.camera = instance
  elseif component == COMPONENT_VELOCITY then
    entity.velocity = instance
  elseif component == COMPONENT_TAG then
    entity.tag = instance
  elseif component == COMPONENT_COLLIDER then
    entity.collider = instance
  elseif component == COMPONENT_ANIMATION then
    entity.animation = instance
  end
end

function ECS:remove_component(entity, component)
  entity.components = bit.band(entity.components, bit.bnot(component))

  if component == COMPONENT_CAMERA then
    entity.camera = nil
  elseif component == COMPONENT_VELOCITY then
    entity.velocity = nil
  elseif component == COMPONENT_TAG then
    entity.tag = nil
  elseif component == COMPONENT_COLLIDER then
    entity.collider = nil
  elseif component == COMPONENT_ANIMATION then
    entity.animation = nil
  end
end

function ECS:add_system(system)
  table.insert(self.systems, system)
end

function ECS:update_system(system, dt)
  for _, e in pairs(self.entities) do
    if bit.band(e.components, system.components_mask)
      == system.components_mask then
      system:update(self, e, dt)
    end
  end
end

function ECS:draw_system(system)
  for _, e in pairs(self.entities) do
    if bit.band(e.components, system.components_mask)
      == system.components_mask then
      system:draw(self, e)
    end
  end
end

function ECS:update_systems(dt)
 for _, system in pairs(self.systems) do
  self:update_system(system, dt)
 end
end

function ECS:draw_systems()
 for _, system in pairs(self.systems) do
  self:draw_system(system)
 end
end

return ECS
