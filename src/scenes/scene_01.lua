require("src.components.components")
local assets = require("src.assets")
local sti = require("lib.sti")

local Camera = require("src.modules.camera")

local ECS = require("src.ecs")
local Animation = require("src.components.animation")
local Collider = require("src.components.collider")

local Scene_01 = {}

function Scene_01:new()
  local scene = {
    name = "scene_01"
  }
  setmetatable(scene, self)
  self.__index = self
  return scene
end

function Scene_01:enter()
  love.graphics.setBackgroundColor(255, 0, 0, 1)
  local map = sti('assets/maps/map01.lua')
  local ecs = ECS:new()
  local cam = Camera:new(0, 0, 5)

  ecs:add_system(require('src.systems.movement'))
  ecs:add_system(require('src.systems.animation'))
  ecs:add_system(require("src.systems.collision"))
  ecs:add_system(require("src.systems.camera"))

  -- Loading map
  -- Looping through Tile map and all object types and creating corresponding entities
  for id, layer in ipairs(map.layers) do
    if layer.type == "objectgroup" then
      for _, object in ipairs(layer.objects) do
          local obj = ecs:create_entity()
          ecs:add_entity(obj)
          ecs:add_component(obj, Collider:new(object.x, object.y, object.width, object.height))

        if object.name == "Player" then
          ecs:add_component(obj, Velocity(0, 0))
          ecs:add_component(obj, Tag(object.name))
          ecs:add_component(obj, Animation:new(0.2, 32, 48, assets.player))
        end
      end
    end
  end

  self.cam = cam
  self.map = map
  self.ecs = ecs
  _G.cam = cam
end

function Scene_01:update(dt)
  self.map:update()
  self.ecs:update_systems(dt)
end

function Scene_01:draw()
  self.cam:set()
  for _, layer in ipairs(self.map.layers) do
		if layer.visible and layer.opacity > 0 then
			self.map:drawLayer(layer)
		end
	end
  self.ecs:draw_systems()
  self.cam:unset()
end

function Scene_01:exit()
end

return Scene_01
