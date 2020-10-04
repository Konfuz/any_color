
function any_color.add_default_palette(nodename)
  local meta = minetest.registered_nodes[nodename]
  if meta == nil then return end
  if meta.palette ~= nil then return end
  local override = {}
  minetest.log(nodename.." has paramtype2".. meta.paramtype2)
  if meta.paramtype2 == "none" then
    override = {paramtype2="color", palette='any_color_mode13.png'}
  elseif meta.paramtype2 == "wallmounted" then
    override = {paramtype2="colorwallmounted", palette='any_color_mode13_16x2.png'}
  elseif meta.paramtype2 == "facedir" then
    override = {paramtype2 = "colorfacedir", palette='any_color_mode13_8x1.png'}
    minetest.log(nodename.." set to ".. override.paramtype2)
  else
    minetest.log('warning', "[any_color] Invalid param2type could not set pallete for "..nodename)
    return
  end
  --override.palette = 'any_color_mode13.png'
  minetest.log("[any_color] Setting default_palette for "..nodename)
  minetest.override_item(nodename, override)
end

minetest.register_node('any_color:colorwood',
  { description = "test",
    palette = "any_color_mode13_16x2.png",
    paramtype2 = "colorwallmounted",
    place_param2 = 2,
    tiles = {"any_color_base.png"}
  }
)
