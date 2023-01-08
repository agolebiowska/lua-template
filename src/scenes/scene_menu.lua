local Button = require("src.ui.button")
local Scene01 = require("src.scenes.scene_01")

local Scene_Menu = {}

function Scene_Menu:new()
  local scene = {
    name = "scene_menu"
  }
  setmetatable(scene, self)
  self.__index = self
  return scene
end

function Scene_Menu:enter()
  -- create canvas
  -- create buttons
  local btns = {}
  local font = love.graphics.newFont(32)

  local startBtn = Button:new("Start game", function()
    local scene_01 = Scene01:new()
    stack:push(scene_01)
  end)

  local exitBtn = Button:new("Exit", function ()
    love.event.quit(0)
  end)

  table.insert(btns, startBtn)
  table.insert(btns, exitBtn)

  self.btns = btns
  self.font = font
end

function Scene_Menu:update(dt)
end

function Scene_Menu:draw()
  local w = love.graphics.getWidth()
  local h = love.graphics.getHeight()
  local bw = w * (1/4)
  local bh = 100
  local margin = 20
  local cur_y = 0

  local th = (bh + margin) * #self.btns

  for _, btn in ipairs(self.btns) do
    btn.last = btn.now
    
    local bx = (w * 0.5) - (bw * 0.5)
    local by = (h * 0.5) - (th * 0.5) + cur_y

    local color = {0.4, 0.4, 0.5, 1.0}
    local mx, my = love.mouse.getPosition()

    local hot = mx > bx and mx < bx + bw and my > by and my < by + bh

    if hot then
      color = {0.8, 0.8, 0.9, 1.0}
    end

    love.graphics.setColor(unpack(color))

    btn.now = love.mouse.isDown(1)
    if btn.now and btn.last and hot then
      btn.fn()
    end

    love.graphics.rectangle(
      "fill", bx, by, bw, bh)

    love.graphics.setColor(0, 0, 0, 1)

    local tw = self.font:getWidth(btn.text)
    local th = self.font:getHeight(btn.text)
    love.graphics.print(btn.text, self.font, (w * 0.5) - tw * 0.5, by + th)

    cur_y = cur_y + (bh + margin)

    love.graphics.reset()
  end
end

function Scene_Menu:exit()
end

return Scene_Menu
