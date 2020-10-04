
any_color = {}
T = minetest.get_translator()
any_color.palette_index = 0 -- Stores currently selected palette index
local modpath = minetest.get_modpath("any_color")

dofile(modpath..'/util.lua')
dofile(modpath..'/nodes.lua')
dofile(modpath..'/paintcan.lua')

any_color.palette_overrides ={'wool:white','stairs:stair_snowblock'}

for v, k in ipairs(any_color.palette_overrides) do
  any_color.add_default_palette(k)
end
