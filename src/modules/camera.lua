local Camera = {}

function Camera:new(x, y, scale)
  local camera = {
    x = x or 0,
    y = y or 0,
    scale = scale or 1
  }
  setmetatable(camera, self)
  self.__index = self
  return camera
end

function Camera:set()
  love.graphics.push()
love.graphics.scale(self.scale, self.scale)

  love.graphics.translate(-self.x, -self.y)
  end

function Camera:unset()
  love.graphics.pop()
end

function Camera:follow(e)
  local w = love.graphics.getWidth() / 2 / self.scale
  local h = love.graphics.getHeight() / 2 / self.scale
  self.x = math.floor(e.x) - w
  self.y = math.floor(e.y) - h

  local dx = self.x - (e.w / 2 + e.x - w)
  local dy = self.y - (e.h / 2 + e.y - h)

  self.x = math.floor(self.x - (dx * 0.5)) --camera smoothness
  self.y = math.floor(self.y - (dy * 0.5))
end

return Camera
