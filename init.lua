local settings = Settings(minetest.get_modpath('waterfalls')..'/settings.txt')
local MP 	= minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP..'/intllib.lua')


dofile(MP..'/bucket_turbulent.lua')
dofile(MP..'/whirlpool.lua')
dofile(MP..'/active_nodes.lua')