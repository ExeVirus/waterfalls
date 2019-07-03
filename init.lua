local settings = Settings(minetest.get_modpath("waterfalls").."/settings.txt")

-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

dofile(MP.."/command.lua")
dofile(MP.."/bucket_turbulent.lua")
dofile(MP.."/whirlpool.lua")
dofile(MP.."/active_nodes.lua")

--
--  Item Registration
--

--[[  Quartz Crystal
      minetest.register_craftitem("quartz:quartz_crystal", {
        description = S("Quartz Crystal"),
        inventory_image = "quartz_crystal_full.png",
      })
]]

--
-- Functions
--
--to be added later, will allow fountains to be turned on and 
--off with techpack optionally (tubelib)


--
-- Node Registration
--

-- Turbulent Water
minetest.register_node("waterfalls:turbulent_water", {
  description = S("Turbulent Water"),
	drawtype = "mesh",
	mesh = "random_grid.obj",
	tiles = {{
		    name = "turbulent_water_animated2.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1.5}
	}},
	use_texture_alpha = true,
	alpha = 50,
	backface_culling = true,
	paramtype = "light",
	inventory_image = "turbulent_water.png",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {oddly_breakable_by_hand=2},
	drop = "waterfalls:turbulent_water",
	drowning = 2,
	sounds = default.node_sound_water_defaults(),
})
