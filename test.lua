-- GENERATED CODE
-- Node Box Editor, version 0.9.0
-- Namespace: test

minetest.register_node("test:node_1", {
	tiles = {
		"whirlpool_machine_top.png",
		"whirlpool_machine_lame_bottom.png",
		"whirlpool_machine_side.png",
		"whirlpool_machine_side.png",
		"whirlpool_machine_back.png",
		"whirlpool_machine_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, -- Outer
			{-0.4375, 0, -0.4375, 0.4375, 0.4375, 0.4375}, -- Upper_Inner
		}
	}
})

