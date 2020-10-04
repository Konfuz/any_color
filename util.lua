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
