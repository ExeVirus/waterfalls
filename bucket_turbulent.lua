--
-- turbulent Water Bucket for Crafting Recipes
--

minetest.register_craftitem("waterfalls:bucket_turbulent", {
	description = "Turbulent Water Bucket",
	inventory_image = "bucket_turbulent.png",
	stack_max = 1,
})

minetest.register_craft({
	type = "shapeless",
	output = "bucket:bucket_water 1",
	recipe = {"waterfalls:bucket_turbulent"}
})

unified_inventory.register_craft_type("whirlpool_mach", {
		-- ^ Unique identifier for `register_craft`
		description = "Whirlpool Machine",
		-- ^ Text shown below the crafting arrow
		icon = "whirlpool_machine_front.png",
		-- ^ Image shown above the crafting arrow
		width = 1,
		height = 1,
		-- ^ Maximal input dimensions of the recipes
		dynamic_display_size = function(craft)
			-- ^ `craft` is the definition from `register_craft`
			return {
				width = 1,
				height = 1
			}
		end,
		-- ^ Optional callback to change the displayed recipe size
		uses_crafting_grid = true,
})

unified_inventory.register_craft({
		output = "waterfalls:bucket_turbulent",
		type = "whirlpool_mach",
		-- ^ Standard craft type or custom (see `register_craft_type`)
		items = { "bucket:bucket_water" },
		width = 3,
		-- ^ Same as `minetest.register_recipe`
})