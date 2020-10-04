
any_color = {}
T = minetest.get_translator()
any_color.palette_index = 0 -- Stores currently selected palette index
local modpath = minetest.get_modpath("any_color")

dofile(modpath..'/util.lua')
dofile(modpath..'/nodes.lua')
dofile(modpath..'/paintcan.lua')
f, err = loadfile(modpath..'/config.lua')
if f == nil then
  f = loadfile(modpath..'/config.lua.default')
end
assert(f ~= nil)
f() -- load config by executing it

for v, k in ipairs(any_color.config.simple_overrides) do
  any_color.add_default_palette(k)
end
