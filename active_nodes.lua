local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

--
-- These are active nodes for the Waterfalls Mod
-- Includings waterfall block, waterfall basin, and fountain




--
-- Waterfall Block
--




--timercallback
local function waterfall_block_timer(pos)
	
	return 1
end

--node
minetest.register_node("waterfalls:waterfall_block", {
	drawtype = "liquid",
	description = S("Waterfall Block"),
	tiles = {"waterfall_block.png"},
	paramtype2 = "facedir",
	walkable = false,
	liquid_viscosity = 1,
	groups = {oddly_breakable_by_hand=3},
	drowning = 1,
  alpha = 160,
  on_timer = waterfall_block_timer,
  post_effect_color = {a = 103, r = 30, g = 60, b = 95},
	sounds = default.node_sound_water_defaults(),
})




--recipe
minetest.register_craft({
	output = "waterfalls:waterfall_block 1",
	recipe = {
		{"waterfalls:bucket_turbulent",""},
		{"bucket:bucket_water","waterfalls:bucket_turbulent"},
		{"bucket:bucket_water","waterfalls:bucket_turbulent"}
	},
	replacements = {{ "bucket:bucket_water", "bucket:bucket_empty 5"}}
})

--
-- Waterfall Basin
--

--note for those who have not seen it, 
--I am using serialize to simplify velocity and acceleration loading
--see this page: https://dev.minetest.net/NodeMetaRef

--timer callabck
local function basin_timer(pos)
	local meta = minetest.get_meta(pos)
	local id = minetest.add_particlespawner({amount=400, time=10,
		minpos=minetest.deserialize(meta:get_string("minpos")), 
		maxpos=minetest.deserialize(meta:get_string("maxpos")),
		minvel=minetest.deserialize(meta:get_string("minvel")), 
		maxvel=minetest.deserialize(meta:get_string("maxvel")),
		minacc=minetest.deserialize(meta:get_string("minacc")), 
		maxacc=minetest.deserialize(meta:get_string("maxacc")),
		minexptime=1, maxexptime=2,
		minsize=0.5, maxsize=1,
		collisiondetection=false, collision_removal=false,
		vertical=false,
		texture="water_blue.png", name})
	meta:set_int("spawner", id)
	return 1
end

--Formspec
local function basin_formspec(direction, height, distance, spread)
	local formspec =
		"size[5.5,5]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"label[1,0.5;Direction]"..
	"dropdown[1,1;1.5,1;direction;0,45,90,135,180,225,270,315;".. direction .."]"..
	"label[1,2.5;Height]"..
	"dropdown[1,3;1.5,1;height;short,mid,tall...;".. height .."]"..
	"label[3,0.5;Distance]"..
	"dropdown[3,1;1.5,1;distance;short,mid,far;".. distance .."]"..
	"label[3,2.5;Spread]"..
	"dropdown[3,3;1.5,1;spread;narrow,normal,wide...;".. spread .."]"..
	"button_exit[2,4;2,1;update;Update]"
	return formspec
end

-- LBM
minetest.register_lbm({
	name = "waterfalls:trigger_basins",
	nodenames = {"waterfalls:basin"},
	run_at_every_load = true,
	action = function(pos, node)
		--add particle spawner
		local meta = minetest.get_meta(pos)
        local id = minetest.add_particlespawner({amount=400, time=10,
		minpos=minetest.deserialize(meta:get_string("minpos")), 
		maxpos=minetest.deserialize(meta:get_string("maxpos")),
		minvel=minetest.deserialize(meta:get_string("minvel")), 
		maxvel=minetest.deserialize(meta:get_string("maxvel")),
		minacc=minetest.deserialize(meta:get_string("minacc")), 
		maxacc=minetest.deserialize(meta:get_string("maxacc")),
		minexptime=1, maxexptime=2,
		minsize=0.5, maxsize=1,
		collisiondetection=false, collision_removal=false,
		vertical=false,
		texture="water_blue.png", name})
		--set ID for destruct later
		
		meta:set_int("spawner", id)
		minetest.get_node_timer(pos):start(10.0)
	end,
})


--node
minetest.register_node("waterfalls:basin", {
	description = S("Waterfall Basin"),
	tiles = {"waterfall_basin.png"}, 
	walkable = false,
	groups = {oddly_breakable_by_hand=3},
	drawtype = "allfaces_optional",
	use_texture_alpha = true,
	sounds = default.node_sound_water_defaults(),
	
	on_destruct = function(pos)
	local meta = minetest.get_meta(pos)
		minetest.delete_particlespawner(meta:get_int("spawner"))
	end,
	
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("minpos", minetest.serialize({x=pos.x-.2, y=pos.y+0.5, z=pos.z-.2}))
		meta:set_string("maxpos", minetest.serialize({x=pos.x+.2, y=pos.y+0.5, z=pos.z+.2}))
		meta:set_string("minvel", minetest.serialize({x=0, y=5, z=0}))
		meta:set_string("maxvel", minetest.serialize({x=0, y=6, z=0}))
		meta:set_string("minacc", minetest.serialize({x=-1, y=-7, z=1}))
		meta:set_string("maxacc", minetest.serialize({x=1, y=-7, z=1}))
		
		--set formspec
		meta:set_string("formspec", basin_formspec(1,2,1,2))
		
		--add particle spawner
        local id = minetest.add_particlespawner({amount=400, time=10,
		minpos={x=pos.x-.2,y=pos.y+0.5,z=pos.z-.2}, 
		maxpos={x=pos.x+.2,y=pos.y+0.5,z=pos.z+.2},
		minvel={x=0,y=5,z=0}, maxvel={x=0,y=6,z=0},
		minacc={x=-1,y=-7,z=1}, maxacc={x=1,y=-7,z=1},
		minexptime=1, maxexptime=2,
		minsize=0.5, maxsize=1,
		collisiondetection=false, collision_removal=false,
		vertical=false,
		texture="water_blue.png", name})
		
		--set ID for destruct later
		meta:set_int("spawner", id)
		minetest.get_node_timer(pos):start(10.0)
	end,
	
	on_receive_fields = function(pos, formname, fields, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		local meta = minetest.get_meta(pos)
		if(fields.update) then
			local spread, spread_pos, minheight, maxheight, fallback, distance
			local ht,spd --for updating the formspec dropdowns
			--convert spread into a value
			if(fields.spread == "narrow") then
				spread = 0.5
				spread_pos = 0.1
				spd = 1
			elseif(fields.spread == "normal") then
				spread = 1		
				spread_pos = 0.2
				spd = 2	
			else
				spread = 1.2
				spread_pos = 0.4
				spd = 3
			end
			
			--convert height into a value
			if(fields.height == "short") then
				minheight = 2.5
				maxheight = 3
				fallback = -5
				ht = 1
			elseif(fields.height == "mid") then
				minheight = 5
				maxheight = 6
				fallback = -7
				ht = 2
			else
				minheight = 8
				maxheight = 10
				fallback = -9
				ht = 3
			end
			
			--convert distance into a value
			if(fields.distance == "short") then
				distance = 1
			elseif(fields.height == "mid") then
				distance = 2
			else
				distance = 3
			end
					
			--now to set the meta strings
			meta:set_string("minpos", minetest.serialize({x=pos.x-spread_pos, y=pos.y+0.5, z=pos.z-spread_pos}))
			meta:set_string("maxpos", minetest.serialize({x=pos.x+spread_pos, y=pos.y+0.5, z=pos.z+spread_pos}))
						
			meta:set_string("minvel", minetest.serialize({x=0, y=minheight, z=0}))
			meta:set_string("maxvel", minetest.serialize({x=0, y=maxheight, z=0}))
			
			--note that at 0 degrees, the direction is positive z. 
			--spread is always perpendicular to direction
			
			meta:set_string("minacc", minetest.serialize({
				x=math.sin(math.rad(fields.direction))*distance+math.cos(fields.direction)*-spread,
				y=fallback, 
				z=math.cos(math.rad(fields.direction))*distance+math.sin(fields.direction)*spread }))
				
			meta:set_string("maxacc", minetest.serialize({
				x=math.sin(math.rad(fields.direction))*distance+math.cos(fields.direction)*spread,
				y=fallback, 
				z=math.cos(math.rad(fields.direction))*distance+math.sin(fields.direction)*-spread }))
	
	
			--delete the particle spawner and respawn
			minetest.delete_particlespawner(meta:get_int("spawner"))
			
			--add particle spawner
			local meta = minetest.get_meta(pos)
			local id = minetest.add_particlespawner({amount=400, time=10,
			minpos=minetest.deserialize(meta:get_string("minpos")), 
			maxpos=minetest.deserialize(meta:get_string("maxpos")),
			minvel=minetest.deserialize(meta:get_string("minvel")), 
			maxvel=minetest.deserialize(meta:get_string("maxvel")),
			minacc=minetest.deserialize(meta:get_string("minacc")), 
			maxacc=minetest.deserialize(meta:get_string("maxacc")),
			minexptime=1, maxexptime=2,
			minsize=0.5, maxsize=1,
			collisiondetection=false, collision_removal=false,
			vertical=false,
			texture="water_blue.png", name})
			--set ID for destruct later
			
			meta:set_int("spawner", id)
			minetest.get_node_timer(pos):start(10.0)
			
			--set formspec
			meta:set_string("formspec", basin_formspec(	(fields.direction+45)/45,
														ht,
														distance,
														spd))
			
		end
		--if not an update or is protected, do nothing
	end,
	
	on_timer = basin_timer,		
})

--recipe
minetest.register_craft({
	output = "waterfalls:basin 1",
	recipe = {
		{"waterfalls:bucket_turbulent","waterfalls:bucket_turbulent","waterfalls:bucket_turbulent"},
		{"bucket:bucket_water","bucket:bucket_water","bucket:bucket_water"}
	},
	replacements = {{ "bucket:bucket_water", "bucket:bucket_empty 6"}}
})


--
-- Fountain
--

-- timercallback
local function fountain_timer(pos)
	local id = minetest.add_particlespawner({amount=400, time=10,
		minpos={x=pos.x-.1,y=pos.y+0.5,z=pos.z-.1}, 
		maxpos={x=pos.x+.1,y=pos.y+0.5,z=pos.z+.1},
		minvel={x=0,y=5,z=0}, maxvel={x=0,y=6,z=0},
		minacc={x=-1,y=-7,z=-1}, maxacc={x=1,y=-7,z=1},
		minexptime=1, maxexptime=2,
		minsize=0.5, maxsize=1,
		collisiondetection=false, collision_removal=false,
		vertical=false,
		texture="water_blue.png", name})
	local meta = minetest.get_meta(pos)
	meta:set_int("spawner", id)
	return 1
end

-- LBM
minetest.register_lbm({
	name = "waterfalls:trigger_fountains",
	nodenames = {"waterfalls:fountain"},
	run_at_every_load = true,
	action = function(pos, node)
		--add particle spawner
        local id = minetest.add_particlespawner({amount=400, time=10,
		minpos={x=pos.x-.1,y=pos.y+0.5,z=pos.z-.1}, 
		maxpos={x=pos.x+.1,y=pos.y+0.5,z=pos.z+.1},
		minvel={x=0,y=5,z=0}, maxvel={x=0,y=6,z=0},
		minacc={x=-1,y=-7,z=-1}, maxacc={x=1,y=-7,z=1},
		minexptime=1, maxexptime=2,
		minsize=0.5, maxsize=1,
		collisiondetection=false, collision_removal=false,
		vertical=false,
		texture="water_blue.png", name})
		--set ID for destruct later
		local meta = minetest.get_meta(pos)
		meta:set_int("spawner", id)
		minetest.get_node_timer(pos):start(10.0)
	end,
})

--node
minetest.register_node("waterfalls:fountain", {
	description = S("Fountain"),
	drawtype = "plantlike",
	tiles = {"fountain.png"},
	use_texture_alpha = true,
	
	on_destruct = function(pos)
	local meta = minetest.get_meta(pos)
		minetest.delete_particlespawner(meta:get_int("spawner"))
	end,
	
	on_construct = function(pos)
		
		local meta = minetest.get_meta(pos)
		
		--add particle spawner
        local id = minetest.add_particlespawner({amount=400, time=10,
		minpos={x=pos.x-.1,y=pos.y+0.5,z=pos.z-.1}, 
		maxpos={x=pos.x+.1,y=pos.y+0.5,z=pos.z+.1},
		minvel={x=0,y=5,z=0}, maxvel={x=0,y=6,z=0},
		minacc={x=-1,y=-7,z=-1}, maxacc={x=1,y=-7,z=1},
		minexptime=1, maxexptime=2,
		minsize=0.5, maxsize=1,
		collisiondetection=false, collision_removal=false,
		vertical=false,
		texture="water_blue.png", name})
		--set ID for destruct later
		
		meta:set_int("spawner", id)
		minetest.get_node_timer(pos):start(10.0)
	end,
	
	on_timer = fountain_timer,		
	
	inventory_image = "fountain_inventory.png",
	groups = {oddly_breakable_by_hand=3},
	sounds = default.node_sound_stone_defaults(),
})



--recipe
minetest.register_craft({
	output = "waterfalls:fountain 1",
	recipe = {
		{"default:tin_ingot","default:steel_ingot","default:tin_ingot"},
		{"","waterfalls:bucket_turbulent",""},
		{"default:tin_ingot","default:diamond","default:tin_ingot"}
	},
	replacements = {{ "waterfalls:turbulent_water", "bucket:bucket_empty"}}
})
