function any_color.is_paintable(node)
  return minetest.registered_nodes[node.name].palette ~= nil
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

  if meta.paramtype2 == "none" then
    if override.paramtype2 == nil then
      override.paramtype2 = "color"
    end
    if override.palette == nil then
      override.palette = any_color.config.default_palette_256
    end
  elseif meta.paramtype2 == "wallmounted" then
    if override.paramtype2 == nil then
      override.paramtype2 = "colorwallmounted"
    end
    if override.palette == nil then
      override.palette = any_color.config.default_palette_32
    end
  elseif meta.paramtype2 == "facedir" then
    if override.paramtype2 == nil then
      override.paramtype2 = "colorfacedir"
    end
    if override.palette == nil then
      override.palette = any_color.config.default_palette_8
    end
  else
    minetest.log('warning', "[any_color] Invalid param2type: "..meta.paramtype.." could not set pallete for "..nodename)
    return false
  end
  minetest.log("verbose","[any_color] Setting default_palette for "..nodename)
  return minetest.override_item(nodename, override)
end
