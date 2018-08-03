
local alphabet = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
local numbers = {"1","2","3","4","5","6","7","8","9","0"}
local symbols = {"excl","plus","minus","times","div"}

local counter = 1
repeat 
minetest.register_node("letterblocks:"..alphabet[counter].."n", {
    description = "Letter Block",
    tiles = {alphabet[counter].."-n.png"},
    is_ground_content = false,
    groups = {snappy=3, stone=1}
})
counter = counter + 1
until counter == #alphabet

counter = 1
repeat 
minetest.register_node("letterblocks:"..numbers[counter].."n", {
    description = "Number Block",
    tiles = {numbers[counter].."-n.png"},
    is_ground_content = false,
    groups = {snappy=3, stone=1}
})
counter = counter + 1
until counter == #numbers

counter = 1
repeat 
minetest.register_node("letterblocks:"..symbols[counter].."n", {
    description = "Symbol Block",
    tiles = {symbols[counter].."-n.png"},
    is_ground_content = false,
    groups = {snappy=3, stone=1}
})
counter = counter + 1
until counter == #symbols

minetest.register_node("letterblocks:quesn", {
    description = "Symbol Block",
    tiles = {numbers[counter].."-n.png"},
    is_ground_content = false,
    groups = {snappy=3, stone=1},
	drop = "default:mese"
})

minetest.register_node("letterblocks:error", {
    description = "Error block",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.4375, -0.4375, 0.375, 0.4375, 0.4375}, -- NodeBox1
			{-0.4375, -0.4375, -0.375, 0.4375, 0.4375, 0.375}, -- NodeBox2
			{-0.4375, -0.375, -0.4375, 0.4375, 0.375, 0.4375}, -- NodeBox3
			{-0.25, -0.5, -0.25, 0.25, 0.5, 0.25}, -- NodeBox4
			{-0.5, -0.25, -0.25, 0.5, 0.25, 0.25}, -- NodeBox5
			{-0.25, -0.25, -0.5, 0.25, 0.25, 0.5}, -- NodeBox6
		}
	},
	on_punch = function(pos)
	
	end,
    tiles = {"huh.png"},
    is_ground_content = false,
    groups = {snappy=3, stone=1, not_in_creative_inventory=1},
	drop = "air"
})

minetest.register_node("letterblocks:Space", {
    description = "Letter Block",
	drawtype = "glasslike_framed",
    tiles = {"Space-n.png","Space-d.png"},
    is_ground_content = false,
    groups = {snappy=3, stone=1}
})

minetest.register_node("letterblocks:Lettermaker", {
    description = "Letter Block Constructor",
	drawtype = "nodebox",
	tiles = {
		"LM-t.png",
		"LM-b.png",
		"LM-s.png",
		"LM-n.png",
		"LM-e.png",
		"LM-w.png"
	},
    node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.25, 0.5}, -- NodeBox1
			{-0.5, -0.5, -0.5, 0, 0.5, 0.5} -- NodeBox2
		}
	},
    is_ground_content = false,
    groups = {snappy=3, stone=1},
	after_place_node = function(pos, placer)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec",
                "size[8,9]"..
                "label[1,0;Letter Block Constructor]"..
				"label[5,0;Use Capital Letters\nUse \"excl\" for !\nUse \"ques\" for ?\nSee reference book for other symbols]"..
				"label[1,3;Input]"..
				"label[6,3;Output]"..
                "field[2,1;1,1;a;Letter;]"..
				"button[3,0;2,1;x;Print Letter onto Block]"..
				"list[context;input;1,2;1,1]"..
				"list[context;output;6,2;1,1]"..
				"list[current_player;main;0,5;8,4;]")
		local inv = meta:get_inventory()
		inv:set_size("input",1)
		inv:set_size("output",1)
    end,
	on_receive_fields = function(pos, formname, fields, player)
		local stack = ItemStack("letterblocks:Space")
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if inv:contains_item("input",stack) and fields.a ~= nil then
			local stack2 = ItemStack("letterblocks:"..fields.a.."n")
			inv:add_item("output",stack2)
			inv:remove_item("input",stack)
		end
    end
})

minetest.register_craftitem("letterblocks:Futurepaint",{
	description = "Futuristic Paint",
	inventory_image = "Comp-a.png"
})

minetest.register_craftitem("letterblocks:bookn",{
	description = "Book of Futuristic Letters",
	inventory_image = "Comp-b.png",
	groups = {book=1},
	on_use = function(itemstack, user, pointed_thing)
		local n = user:get_player_name()
		minetest.show_formspec(n,"letterblocks:book",
		"size[6,9]"..
		"image[-0.625,-1.875;9,13.5;Book.png]")
	end
})

minetest.register_craft({
	output = "letterblocks:Lettermaker",
	recipe = {
		{"default:stonebrick","default:stonebrick","default:stonebrick"},
		{"letterblocks:Futurepaint","","letterblocks:Futurepaint"},
		{"default:stonebrick","default:stonebrick","default:stonebrick"}
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "letterblocks:Futurepaint",
	recipe = {"dye:green","bucket:bucket_water","default:stick"},
	replacements = {{"default:stick","default:stick"}}
})

minetest.register_craft({
	type = "shapeless",
	output = "letterblocks:Space 16",
	recipe = {"letterblocks:Futurepaint","default:stonebrick"},
	replacements = {{"letterblocks:Futurepaint","letterblocks:Futurepaint"}}
})

minetest.register_craft({
	output = "letterblocks:error",
	recipe = {
		{"group:number"},
		{"letterblocks:divn"},
		{"letterblocks:0n"}
	}
})	

minetest.register_craft({
	type = "shapeless",
	output = "letterblocks:bookn",
	recipe = {"letterblocks:Futurepaint","default:book"},
	replacements = {{"letterblocks:Futurepaint","letterblocks:Futurepaint"}}
})
