
function any_color.add_default_palette(nodename, override)
  local meta = minetest.registered_nodes[nodename]
  if (meta == nil) or (meta.palette ~= nil) then return end

  if meta.paramtype2 == "none" then
    if override.paramtype2 == nil then override.paramtype2 = "color" end
    if override.palette == nil then override.palette = 'any_color_mode13.png' end
  elseif meta.paramtype2 == "wallmounted" then
    if override.paramtype2 == nil then override.paramtype2 = "colorwallmounted" end
    if override.palette == nil then override.palette = 'any_color_mode13_16x2.png' end
  elseif meta.paramtype2 == "facedir" then
    if override.paramtype2 == nil then override.paramtype2 = "colorfacedir" end
    if override.palette == nil then override.palette = 'any_color_mode13_8x1.png' end
  else
    minetest.log('warning', "[any_color] Invalid param2type: "..meta.paramtype.." could not set pallete for "..nodename)
    return
  end
  minetest.log("verbose","[any_color] Setting default_palette for "..nodename)
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
