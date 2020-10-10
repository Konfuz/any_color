
function any_color.show_form(itemstack, player, pointed_thing)
  --[[Generate Formspec for color selection on pointed_thing and show it.
    Right click calls this back.
  --]]

  -- Init stuff and sanity checks
  if not player or not pointed_thing or not pointed_thing.type == "node" then
    return
  end
  local player = player:get_player_name()
  local pos = pointed_thing.under
  local node = minetest.get_node(pos)
  local meta = minetest.registered_nodes[node.name]
  local item = nil  -- Itemstring
  local msg = ""
  if type(meta) ~= 'table' then
    msg = "Node "..node.name.." is missing meta information! (may not be registered)"
    minetest.log("error", msg)
    return
  elseif not minetest.is_colored_paramtype(meta.paramtype2) then
    msg = T("This node does not support hardware-coloring! Please slap the author!  ".. node.name)
    minetest.chat_send_player(player, msg)
    return
  end
  if not meta.palette then
    msg = "Node "..node.name.." does not define a palette despite being colorable".. node.name
    minetest.log("warning", msg)
    return
  end

  -- next up: generating a Formspec grid
  local col = 1
  local row = 1
  local mul = 1 -- multiplicator to shift bits to most significant
  -- 8 color mode layout
  if meta.paramtype2 == "colorfacedir" then
    col = 8
    row = 1
    mul = 32
  -- 32 color mode layout
  elseif meta.paramtype2 == "colorwallmounted" then
    col = 16
    row = 2
    mul = 8
  -- 256 mode layout
  else
    col = 16
    row = 16
  end

  local spec = {"size[16,16]",
    "real_coordinates[true]",
  }
  -- because of a bug in item_image_button using transparent
  -- buttons to overlay a normal item_image
  spec[#spec+1] = "style_type[button;bgcolor=#00000000]"

  local i = 0
  local j = 0
  local idx = 0
  while j < row do
    i = 0
    while i < col do
      idx = 16*j+i
      item = minetest.itemstring_with_palette(node.name, idx * mul)
      spec[#spec+1] = "item_image["..i..","..j..";1,1;"..item.."]"
      spec[#spec+1] = "button["..i..","..j..";1,1;"..idx..";]"
      i = i + 1
    end
    j = j + 1
  end
  minetest.show_formspec(player, "any_color:paintcan_form_rk", table.concat(spec))
end

function any_color.on_receive_fields(player, formname, fields)
  --[[ Callback for the color selection dialogue
  --]]

  -- obligatory sanity check
  if not player or not formname or not fields then return end
  -- If this is not our event, ignore it.
  if not formname == "any_color:paintcan_form_rk" then return end

  -- search for a pressed button
  local i = 0
  while i < 256 do

    if not (fields[tostring(i)] == nil) then
      any_color.palette_index = i
      break
    end
    i = i + 1
  end
end

function any_color.paint_node(itemstack, player, pointed_thing)
  --[[ Apply currently selected palette index to pointed_thing
      Called on leftclick
    ]]

  -- obligatory sanity check
  if not player or not pointed_thing then return end
  local pos = pointed_thing.under
  if pos == nil then return end  -- happens whenever you look at the sky

  local node = minetest.get_node(pos)
  if not any_color.is_paintable(node) then
    return
  end
  local meta = minetest.registered_nodes[node.name]
  if meta == nil then
    minetest.log('warning', node.name.." has no metadata and is probably unregistered at pos "..pos)
    return
  end

  local paramtype2 = meta.paramtype2
  local color = any_color.palette_index
  local rotation = 1
  local color_num = 256  -- number of colors in the palette
  local mul = 1  -- index muliplicator for smaller, stretched, palettes

  if paramtype2 == "color" then --nop
  elseif paramtype2 == "colorfacedir" then
    mul = 32
    color_num = 8
  elseif paramtype2 == 'colorwallmounted' then
    mul = 8
    color_num = 64
  else
    local msg = ""
    if meta.paramtype2 == nil then
      msg = node.name.." is missing the paramtype entirely!"
    else
      msg = node.name.." has paramtype "..meta.paramtype2.." and can not be colored"
    end
    minetest.log(msg)
    return
  end
  rotation = node['param2'] % mul
  color = color % color_num -- user might have an invalid color on his brush
  color = color * mul + rotation
  node['param2'] = color
  minetest.set_node(pos, node)
end

-- registered as a craftitem because I want it to stack
-- that way I can turn the paintcan into a consumable later
minetest.register_craftitem('any_color:paintcan',
  {
    description = "Allows to colorize certain nodes",
    inventory_image = 'paintcan.png',
    wield_image = 'paintbrush.png',
    on_use = any_color.paint_node,
    on_place = any_color.show_form,
  }
)

minetest.register_craft({type="shapeless", recipe = {
  "dye:red","dye:green", "dye:blue",
  "dye:yellow", "dye:cyan", "dye:magenta",
  "dye:white", "default:steel_ingot", "dye:black"},
  output = "any_color:paintcan"}
)

minetest.register_on_player_receive_fields(any_color.on_receive_fields)
