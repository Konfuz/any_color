function any_color.is_paintable(node)
  if node == nil then return
  elseif node.name == nil then return
  elseif minetest.registered_nodes[node.name] == nil then return
  else return minetest.registered_nodes[node.name].palette ~= nil
  end
end

function any_color.dump(o)
  --[[ Debug function for making tables printable.
  Shame- and careless copy&paste from Stackoverflow --]]
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function any_color.add_default_palette(nodename, override)
  -- sets up nodename with a fitting default palette if possible
  -- Returns false on error
  local meta = minetest.registered_nodes[nodename]
  if (meta == nil) or (meta.palette ~= nil) then return false end
  if any_color.blacklist[nodename] then return false end

  -- use given override otherwise choose own param
  local or_param2 = (override.paramtype2 == nil)
  local or_palette = (override.palette == nil)
  if meta.paramtype2 == "none" then
    if or_param2 then
      override.paramtype2 = "color"
    end
    if or_palette then
      override.palette = any_color.config.default_palette_256
    end
  elseif meta.paramtype2 == "wallmounted" then
    if or_param2 then
      override.paramtype2 = "colorwallmounted"
    end
    if or_palette then
      override.palette = any_color.config.default_palette_32
    end
  elseif meta.paramtype2 == "facedir" then
    if or_param2 then
      override.paramtype2 = "colorfacedir"
    end
    if or_palette then
      override.palette = any_color.config.default_palette_8
    end
  else
    minetest.log('warning', "[any_color] Invalid param2type: "..meta.paramtype.." could not set pallete for "..nodename)
    return false
  end
  minetest.log("verbose","[any_color] Setting default_palette for "..nodename)
  return minetest.override_item(nodename, override)
end

-- build blacklist of nodes that must not be colored according to config
any_color.blacklist = {}

for k, pattern in pairs(any_color.config.blacklist) do
  for nodename, meta in pairs(minetest.registered_nodes) do
    if not any_color.blacklist[nodename] and string.find(nodename, pattern) then
      any_color.blacklist[nodename] = true
    end
  end
end
