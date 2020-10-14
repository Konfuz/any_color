
any_color = {}
T = minetest.get_translator()
any_color.palette_index = 0 -- Stores currently selected palette index
local modpath = minetest.get_modpath("any_color")

f, err = loadfile(modpath..'/config.lua')
if f == nil then
  f, err = loadfile(modpath..'/config.lua.default')
end
assert(f ~= nil, err)
f() -- load config by executing it

dofile(modpath..'/util.lua')
dofile(modpath..'/paintcan.lua')

-- Do the most specific overrides first since it seems minetest only allows one
for i, v in pairs(any_color.config.overrides) do
  if type(v) == 'string' then
    for k in pairs(minetest.registered_nodes) do
      if string.find(k, v) then
        any_color.add_default_palette(v,{})
      end
    end
  elseif type(v) == 'table' and #v == 2 and type(v[2]) == 'table' then
    for k in pairs(minetest.registered_nodes) do
      if string.find(k, v[1]) then
        any_color.add_default_palette(v[1],v[2])
        --minetest.log('verbose', "modified ".. k)
      end
    end
  else
    minetest.log('error', 'override format error detected in override item '.. i)
  end
end

-- now the default overrides if colorize_all
-- apparently wont affect nodes already overridden in previous step
if any_color.config.colorize_all then
  for k in pairs(minetest.registered_nodes) do
    any_color.add_default_palette(k, {})
  end
end
