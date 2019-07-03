-- Turn on Spawner
minetest.register_chatcommand("p", {
	params = "",
	description = "Start particle spawner", -- full description
	privs = {},
	func = function(name)
		minetest.add_particlespawner({amount=2500, time=10,
			minpos={x=1,y=15,z=-3}, maxpos={x=1,y=16,z=5},
			minvel={x=1,y=0,z=0}, maxvel={x=2,y=0,z=0},
			minacc={x=-1,y=-4.3,z=0}, maxacc={x=-1.5,y=-6,z=0},
			minexptime=3, maxexptime=3,
			minsize=0.1, maxsize=0.85,
			collisiondetection=false, collision_removal=false,
			vertical=false,
			texture="water_blue.png", name})
	end
})


minetest.register_chatcommand("o", {
	params = "",
	description = "Start basin Spawner", -- full description
	privs = {},
	func = function(name)
		minetest.add_particlespawner({amount=2300, time=10,
			minpos={x=1,y=9,z=-3}, maxpos={x=3,y=10,z=5},
			minvel={x=1,y=1.5,z=0}, maxvel={x=2,y=4,z=0},
			minacc={x=0,y=-7,z=0}, maxacc={x=0,y=-7,z=0},
			minexptime=0.9, maxexptime=1,
			minsize=0.5, maxsize=1,
			collisiondetection=false, collision_removal=false,
			vertical=false,
			texture="water_white.png", name})
	end
})

minetest.register_chatcommand("i", {
	params = "",
	description = "Start Fountain Spawner", -- full description
	privs = {},
	func = function(name)
		minetest.add_particlespawner({amount=400, time=10,
			minpos={x=15.9,y=8.5,z=15.9}, maxpos={x=16.1,y=8.5,z=16.1},
			minvel={x=0,y=5,z=0}, maxvel={x=0,y=6,z=0},
			minacc={x=-1,y=-7,z=-1}, maxacc={x=1,y=-7,z=1},
			minexptime=1, maxexptime=2,
			minsize=0.5, maxsize=1,
			collisiondetection=false, collision_removal=false,
			vertical=false,
			texture="water_blue.png", name})
	end
})


-- formspec testing
minetest.register_chatcommand("form", {
    func = function(name, param)
        minetest.show_formspec(name, "waterfalls:whirlpool_form",
                "size[4,3]" ..
                "label[0,0;Hello, " .. name .. "]" ..
                "field[1,1.5;3,1;name;Name;]" ..
                "button_exit[1,2;2,1;exit;Save]")
    end
})

-- Register callback
minetest.register_on_player_receive_fields(function(player,
        formname, fields)
    if formname ~= "waterfalls:whirlpool_form" then
        -- Formname is not waterfalls:whirlpool_form,
        -- exit callback.
        return false
    end

    -- Send message to player.
    minetest.chat_send_player(player:get_player_name(),
            "You said: " .. fields.name .. "!")

    -- Return true to stop other callbacks from
    -- receiving this submission.
    return true
end)