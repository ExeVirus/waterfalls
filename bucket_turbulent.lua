--
-- turbulent Water Bucket for Crafting Recipes
--

minetest.register_craftitem('waterfalls:bucket_turbulent', {
	description 	= 'Turbulent Water Bucket',
	inventory_image = 'bucket_turbulent.png',
	stack_max = 99,
})

minetest.register_craft({
	type   = 'shapeless',
	output = 'bucket:bucket_water 1',
	recipe = {'waterfalls:bucket_turbulent'},
})

unified_inventory.register_craft_type('whirlpool_mach', {
	description = 'Whirlpool Machine',
	icon   = 'whirlpool_machine_front.png',
	width  = 1,
	height = 1,
	dynamic_display_size = function(craft)
		return {
			width  = 1,
			height = 1,
		}
	end,
	uses_crafting_grid = true,
})

unified_inventory.register_craft({
	output = 'waterfalls:bucket_turbulent',
	type   = 'whirlpool_mach',
	items  = { 'bucket:bucket_water' },
	width  = 3,
})