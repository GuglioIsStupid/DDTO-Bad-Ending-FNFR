return graphics.newSprite(
	love.graphics.newImage(graphics.imagePath("characters/Yuri_Closet")),
    	-- Automatically generated from Yuri_Closet.xml
	{
		{x = 1194, y = 1411, width = 594, height = 686, offsetX = -2, offsetY = 0, offsetWidth = 598, offsetHeight = 686}, -- 1: BlurriAppear0000
		{x = 0, y = 2791, width = 598, height = 683, offsetX = 0, offsetY = -3, offsetWidth = 598, offsetHeight = 686}, -- 2: BlurriAppear0001
		{x = 2343, y = 0, width = 594, height = 686, offsetX = -2, offsetY = 0, offsetWidth = 598, offsetHeight = 686}, -- 3: BlurriAppear0002
		{x = 2343, y = 686, width = 594, height = 686, offsetX = -2, offsetY = 0, offsetWidth = 598, offsetHeight = 686}, -- 4: BlurriAppear0003
		{x = 2343, y = 1372, width = 594, height = 686, offsetX = -2, offsetY = 0, offsetWidth = 598, offsetHeight = 686}, -- 5: BlurriAppear0004
		{x = 0, y = 2105, width = 594, height = 686, offsetX = -2, offsetY = 0, offsetWidth = 598, offsetHeight = 686}, -- 6: BlurriAppear0005
		{x = 1795, y = 2791, width = 604, height = 601, offsetX = -4, offsetY = -5, offsetWidth = 608, offsetHeight = 606}, -- 7: BlurriDown0000
		{x = 1198, y = 2791, width = 597, height = 604, offsetX = -7, offsetY = -2, offsetWidth = 608, offsetHeight = 606}, -- 8: BlurriDown0001
		{x = 598, y = 2791, width = 600, height = 606, offsetX = -6, offsetY = 0, offsetWidth = 608, offsetHeight = 606}, -- 9: BlurriDown0002
		{x = 0, y = 2105, width = 594, height = 686, offsetX = 0, offsetY = 0, offsetWidth = 594, offsetHeight = 686}, -- 10: BlurriIdle0000
		{x = 594, y = 2105, width = 594, height = 686, offsetX = 0, offsetY = 0, offsetWidth = 594, offsetHeight = 686}, -- 11: BlurriIdle0001
		{x = 1188, y = 2105, width = 594, height = 686, offsetX = 0, offsetY = 0, offsetWidth = 594, offsetHeight = 686}, -- 12: BlurriIdle0002
		{x = 1782, y = 2105, width = 594, height = 686, offsetX = 0, offsetY = 0, offsetWidth = 594, offsetHeight = 686}, -- 13: BlurriIdle0003
		{x = 2937, y = 0, width = 594, height = 686, offsetX = 0, offsetY = 0, offsetWidth = 594, offsetHeight = 686}, -- 14: BlurriIdle0004
		{x = 2937, y = 686, width = 594, height = 686, offsetX = 0, offsetY = 0, offsetWidth = 594, offsetHeight = 686}, -- 15: BlurriIdle0005
		{x = 0, y = 708, width = 602, height = 703, offsetX = -42, offsetY = -9, offsetWidth = 644, offsetHeight = 712}, -- 16: BlurriLeft0000
		{x = 1743, y = 0, width = 600, height = 698, offsetX = -40, offsetY = -10, offsetWidth = 644, offsetHeight = 712}, -- 17: BlurriLeft0001
		{x = 1743, y = 698, width = 600, height = 698, offsetX = -40, offsetY = -10, offsetWidth = 644, offsetHeight = 712}, -- 18: BlurriLeft0002
		{x = 602, y = 708, width = 598, height = 699, offsetX = 0, offsetY = -16, offsetWidth = 633, offsetHeight = 715}, -- 19: BlurriRight0000
		{x = 0, y = 1411, width = 597, height = 694, offsetX = -1, offsetY = -18, offsetWidth = 633, offsetHeight = 715}, -- 20: BlurriRight0001
		{x = 597, y = 1411, width = 597, height = 694, offsetX = 0, offsetY = -18, offsetWidth = 633, offsetHeight = 715}, -- 21: BlurriRight0002
		{x = 0, y = 0, width = 579, height = 708, offsetX = -2, offsetY = 0, offsetWidth = 587, offsetHeight = 708}, -- 22: BlurriUp0000
		{x = 1161, y = 0, width = 582, height = 705, offsetX = 0, offsetY = -3, offsetWidth = 587, offsetHeight = 708}, -- 23: BlurriUp0001
		{x = 579, y = 0, width = 582, height = 706, offsetX = 0, offsetY = -2, offsetWidth = 587, offsetHeight = 708} -- 24: BlurriUp0002
	},
	{
		["down"] = {start = 7, stop = 9, speed = 24, offsetX = 0, offsetY = 0},
		["left"] = {start = 16, stop = 18, speed = 24, offsetX = 0, offsetY = 0},
		["right"] = {start = 19, stop = 21, speed = 24, offsetX = 0, offsetY = 0},
		["up"] = {start = 22, stop = 24, speed = 24, offsetX = 0, offsetY = 0},
		["idle"] = {start = 10, stop = 15, speed = 24, offsetX = 0, offsetY = 0},
        ["appear"] = {start = 1, stop = 6, speed = 24, offsetX = 0, offsetY = 0}
	},
	"idle",
	false
)
