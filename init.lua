
any_color = {}
T = minetest.get_translator()
any_color.palette_index = 0 -- Stores currently selected palette index
local modpath = minetest.get_modpath("any_color")

dofile(modpath..'/util.lua')
dofile(modpath..'/nodes.lua')
dofile(modpath..'/paintcan.lua')
f, err = loadfile(modpath..'/config.lua')
if f == nil then
  f, err = loadfile(modpath..'/config.lua.default')
end
assert(f ~= nil, err)
f() -- load config by executing it

if any_color.config.colorize_all then
  for k in pairs(minetest.registered_nodes) do
    any_color.add_default_palette(k, {})
  end
else
  for k, v in ipairs(any_color.config.simple_overrides) do
    any_color.add_default_palette(v,{})
  end
end
