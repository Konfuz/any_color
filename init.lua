
any_color = {}
T = minetest.get_translator()
any_color.palette_index = 0 -- Stores currently selected palette index
local modpath = minetest.get_modpath("any_color")

dofile(modpath..'/util.lua')
dofile(modpath..'/nodes.lua')
dofile(modpath..'/paintcan.lua')

-- nodes in this table will be overridden with a default_palette unless
-- they already have one
any_color.palette_overrides ={'wool:white','stairs:stair_snowblock',
'default:aspen_tree', 'default:coral_skeleton', 'default:ice', 'default:ladder_steel',
'default:furnace',
'default:silver_sandstone', 'stairs:slab_silver_sandstone',
'default:silver_sandstone_block', 'stairs:slab_silver_sandstone_block',
'default:silver_sandstone_brick', 'stairs:slab_silver_sandstone_brick',
'default:snowblock', 'default:silver_sand',
'default:glass'}

for v, k in ipairs(any_color.palette_overrides) do
  any_color.add_default_palette(k)
end
