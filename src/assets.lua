local assets = {}

love.graphics.setDefaultFilter('nearest', 'nearest')

assets.player = {
  walk = love.graphics.newImage('assets/sprites/player_walk.png'),
  idle = love.graphics.newImage('assets/sprites/player_idle.png')
}

return assets
