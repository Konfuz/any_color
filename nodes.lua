
function any_color.add_default_palette(nodename)
  local meta = minetest.registered_nodes[nodename]
  if meta == nil then return end
  if meta.palette ~= nil then return end
  local override = {}

  if meta.paramtype2 == "none" then
    override = {paramtype2="color", palette='any_color_mode13.png'}
  elseif meta.paramtype2 == "wallmounted" then
    override = {paramtype2="colorwallmounted", palette='any_color_mode13_16x2.png'}
  elseif meta.paramtype2 == "facedir" then
    override = {paramtype2 = "colorfacedir", palette='any_color_mode13_8x1.png'}
  else
    minetest.log('warning', "[any_color] Invalid param2type: "..meta.paramtype.." could not set pallete for "..nodename)
    return
  end
  minetest.log("debug","[any_color] Setting default_palette for "..nodename)
  minetest.override_item(nodename, override)
end

minetest.register_node('any_color:colorwood',
  { description = "any_color Testblock color",
    palette = "any_color_mode13.png",
    paramtype2 = "color",
    tiles = {"any_color_base.png"},
    groups= {oddly_breakable_by_hand=1}

  }
)

minetest.register_node('any_color:colorwood_wallmounted',
  { description = "any_color Testblock wallmounted",
    palette = "any_color_mode13_16x2.png",
    paramtype2 = "colorwallmounted",
    tiles = {"any_color_base.png"},
    groups= {oddly_breakable_by_hand=1}
  }
)

minetest.register_node('any_color:colorwood_facedir',
  { description = "any_color Testblock colorfacedir",
    palette = "any_color_mode13_8x1.png",
    paramtype2 = "colorfacedir",
    tiles = {"any_color_base.png"},
    groups= {oddly_breakable_by_hand=1}
  }
)
