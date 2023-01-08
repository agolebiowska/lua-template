if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

local Stack = require("src.stack")

local SceneMenu = require("src.scenes.scene_menu")
local Scene01 = require("src.scenes.scene_01")

_G.stack = nil

local menu = SceneMenu:new()

function love.load()
  stack = Stack:new()

  stack:push(menu)
end

function love.update(dt)
  stack:update(dt)
end

function love.draw()
  stack:draw()
end

function love.keypressed(key, unicode)
    if key == "escape" then
      stack:push(menu)
    end
end
