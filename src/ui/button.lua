local Button = {}

function Button:new(text, fn)
  local button = {
    text = text,
    fn = fn,

    last = false,
    now = false
  }
  setmetatable(button, self)
  self.__index = self
  return button
end

return Button
