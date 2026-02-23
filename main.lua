require("world")
SCALE = 4
gfx = love.graphics
gfx.reset()
gfx.clear(Color[0])
for _, star in ipairs(galaxy(23114, 584, 46931)) do
  gfx.print(star.name, star.x * SCALE, star.y * SCALE)
end
