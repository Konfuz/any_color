
**This is a fresh project start and very much work in progress**
_honestly the progress might converge to zero when I loose intrest._

### What is this?

The all_colors mod for minetest allows players and mod-makers to fully utilize the potential
that hardware-coloring via param2 brings.

### Why is this?

The mod was heavily inspired by the unifieddyes mod from VanessaE.
While a proven and extensive solution for modmakers this mod aims to offer
the following

##### Improvements:

- hardly any effort for mod creators
- arbitrary pallets
- no registered node multiplication
- no leftover unknown nodes after removing the mod
- easy to use for players

##### Also it has the following shortcomings by design:

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

_In fact this mod should be compatible with all nodes that are already utilizing
hardware-coloring. It does work for nodes that have been colored by unifieddyes
though the airbrush does some magic node-switching and paramtype2 setting so
it may not work before the first use of the airbrush._
