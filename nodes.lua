

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
