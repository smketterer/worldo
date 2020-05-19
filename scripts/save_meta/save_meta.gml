///@desc Sets the metadata for saving. See GMWolf saving tutorial on Youtube.

// Run this before anything else.
gml_pragma("global", "save_meta();")

global.save_map = ds_map_create()
global.save_map[? Person] = ["x", "y", "first_name", "last_name", "nickname", "name", "sex", "age", "sprite_index"]

global.save_map[? Resource] = ["x", "y", "hp"]
global.save_map[? Tree] = global.save_map[? Resource]
global.save_map[? Bush] = global.save_map[? Resource]

global.save_map[? Blueprint] = ["x", "y", "hp", "work", "object", "requirement"]

global.save_map[? Storable] = ["x", "y", "hp", "stored", "initial_layer"]
global.save_map[? Wood] = global.save_map[? Storable]
global.save_map[? Stone] = global.save_map[? Storable]
global.save_map[? Berries] = global.save_map[? Storable]

global.save_map[? Block] = ["x", "y", "hp"] // block doesn't have hp but children do
global.save_map[? WoodWall] = global.save_map[? Block]
global.save_map[? Floor] = global.save_map[? Block]

global.save_map[? Zone] = ["x", "y", "claimed", "claimed_by"]

global.save_map[? Lamp] = ["x", "y", "lightadd"]
global.save_map[? Light] = ["x", "y", "light", "Light_Color", "Light_Intensity", "Light_Range", "Light_Shadow_Length"]
global.save_map[? LightAdd] = ["x", "y", "color"]