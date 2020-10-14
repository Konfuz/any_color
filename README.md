
**This is a fresh project start and very much work in progress**
_honestly the progress might converge to zero when I loose intrest._

### What is this?

The all_colors mod for minetest allows players and mod-makers to fully utilize the potential
that hardware-coloring via param2 brings. It can even override most nodes that
don't support hardware-coloring to forcefully make them.

![alt text](doc/img/must_color_stuff.png "Made white dandelion purple. Sue me.")

Take a white butterfly, make it yellow. Green fire? Sure. Wanna make your main
shaft ladder look like a unicorn puked on it? Uhmm... you do you.

The mod is not without limitations though so please keep reading.

### Why is this?

The mod was heavily inspired by the unifieddyes mod from VanessaE.
While unifieddyes is a proven and extensive solution for modmakers,
this mod aims to offer the following

##### Improvements:

- hardly any effort for mod creators
- arbitrary pallets
- no registered node multiplication
- no leftover unknown nodes after removing the mod
- easy to use for players
- default overrides that make some existing nodes colorable out of the box

##### Shortcomings by design:

- Since we are using arbitrary colors and not one fixed palette the detailed
  color crafting unifieddyes has is not possible.
- colorfacedir nodes are restricted to 8 (arbitrary) colors
- colorwallmounted nodes are restricted to 32 (arbitrary) colors

The latter two are actually an advantage in my eyes, since unifieddyes splits the
256 color palette into chunks of 8 colors and then registers a node copy with
only a difference in palette. This leads to node multiplication and you can
quickly reach the current node registration limit of the engine.

In a 256 color palette most colors are not desireable options for any given node.
Since the mod creator can freely choose 8 colors for his item these colors will
all fit the node perfectly.

If you still desire more colors you can always define a new node.
Think of chair_red with 8 shades of red and then another defined node
chair_purple with 8 shades of purple.

### What does a mod author have to do to be compatible with this mod?

Almost nothing. You only need to make sure to define a palette for your node
and set an appropriate paramtype2 out of `{"color", "colorwallmounted","colorfacedir"}`

_In fact this mod should be compatible with all nodes that are already hardware colorized_

- If you make this mod a hard dependency, you can use the provided palettes.  

- Your texture should be white-ish so any color can be slapped on it


**Hint:** If you only want a part of your texture colored do make a copy of the
texture, replace the part you want colored with alpha and use the new texture
as an overlay (with `overlay_tiles`) same way you did for the base-texture.

This mod primarily is useful to reduce the number of node definitions.
(looking at _you_ luxury_decor...) At the same time it multiplies your options.
For example in the texturepack I use default:stone looks like Bark when colored
in different shades of brown, or like a dense hedge in green colors.


### Caveats

This mod makes it possible to color nodes that where never designed to be colored
(not white) this can lead to very interesting and visually pleasing results,
but because of the way hardware coloring works you cant get every color for
such nodes.

**Example:**
>If you overlay a yellow mese block with blue, you will inevitably end up with
green - the mixture of both according to my kindergarden teacher. You cannot
make it blue no matter how much you want it. You can however define a
new decolorized mese-texture and make param2 'yellow' by default with 255
other options remaining.

If the user is using a custom texturepack the color will be applied to _his_ custom
version of the texture which may look better or worse but rarely the same.

### Compatibility

- mods that use param2 without declaring it in paramtype2 are an issue
- Any `signs_lib` based signs such as `basic_signs` need to be blacklisted
  since the mod does some math that relies on the node being of type facedir
  instead of colorfacedir.  
- leaves and farming mods tend to use param2 but only out of [0,1] so using a
  palette where param2 = 1 = 0 = white circumvents the issue of miscolored plants
  and leaves. The default 256 palette has been adapted accordingly.  

_It can work for nodes that have been colored by unifieddyes
though the airbrush does some magic node-switcheroos and paramtype2 setting so
it may not work before the first use of the airbrush and the palettes may be confusing
due to the aforementioned node multiplication.
It is not recommended to use this mod in conjuction with unifieddyes but you
may want to keep it around to avoid undefined nodes on your map._


### Usage

Generally: Just switch it on.

>**by default the mod has set its option `colorize_all` set for demonstration purposes.**
I call this _the nuclear option_ because it makes everything colorable that
can possibly made hardware-colorable. Better switch it off as soon as you are done
running around coloring stuff like a complete maniac.

If you are not in creative mode you will need to craft a paint can using
the shapeless recipe:
`red, green, blue, yellow, cyan, magenta, white, black and a steel ingot`
otherwise just grab a can of paint from the creative menu and (shift-)right-click
some lightly colored nodes, such as sandstone. The menu will present you the color
options (if any) that this node has, you select one and then punch the node.

You can punch away on as many nodes as you like, but when that node uses
a different palette the color will be whatever that node defined in its palette.


### Config

If you don't want your entire world to be sodomized by paintbrush wielding baboons
you can disable `colorize_all` and instead put sensible node-names into the provided
list. These nodes get a default palette assigned

**The config is valid LUA-Code and MUST NOT contain syntax-errors.**

To make your own config that does not get overridden by possible updates
copy `config.lua.default` to `config.lua` and modify the latter one.
Your modification must contain all keys present in the default table
as the default will only be loaded when `config.lua` is missing.

You can specify more complex overrides to nodes by entering the parameters for
[minetest.override_item(name, redefinition)](https://minetest.gitlab.io/minetest/minetest-namespace-reference/) yourself.

You can blacklist nodes if you want to exclude them explicitly.

Both blacklist and override support Patterns. See the [LUA Documentation](https://www.lua.org/pil/20.2.html)
You can just give the nodename so long as it does not contain *magic* characters
out of  `( ) . % + - * ? [ ^ $ `. You can excape these with an (additional) `%`.
In most cases just using the wildcard `*` - for example to select a certain mod -
should suffice. e.g. `my_mod:*` would exclude/include all contents of your mod.


### Disabling / Re-enabling the mod

- Any items that have their own palette defined will remain in their current state.
- Any item that had a default palette assigned by this mod will visually fall back to its base color.
- no nodes should become unregistered.
- As long as no one else uses the param2 of any given node for something else,
  it will regain its color upon reactivation of this mod.
