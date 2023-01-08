local Stack = {}

function Stack:new()
  local stack = {
    scenes = {},
  }
  setmetatable(stack, self)
  self.__index = self
  return stack
end

function Stack:push(scene)
  -- Call exit on the current top scene
  local current_scene = self:peek()
  if current_scene and current_scene.exit then
    current_scene:exit()
  end

  -- Push the new scene onto the stack
  table.insert(self.scenes, scene)

  -- Call enter on the new top scene
  local new_scene = self:peek()
  if new_scene and new_scene.enter then
    new_scene:enter()
  end
end

function Stack:peek()
  return self.scenes[#self.scenes]
end

function Stack:pop()
  local state = self:peek()
  table.remove(self.scenes)
  return state
end

function Stack:update(dt)
  local state = self:peek()
  if state and state.update then
    state:update(dt)
  end
end

function Stack:draw()
  local state = self:peek()
  if state and state.draw then
    state:draw()
  end
end

return Stack
