return graphics.newSprite(
	images.goofyNotes,
	{
		{x = 0, y = 164, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: arrowDOWN0000
		{x = 0, y = 164, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: arrowDOWN0001
		{x = 164, y = 164, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 3: arrowDOWN0002
		{x = 164, y = 164, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 4: arrowDOWN0003
		{x = 328, y = 164, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 5: arrowDOWN0004
		{x = 328, y = 164, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 6: arrowDOWN0005
		{x = 0, y = 492, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 7: blue0000
		{x = 0, y = 492, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 8: blue0001
		{x = 164, y = 492, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 9: blue0002
		{x = 164, y = 492, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 10: blue0003
		{x = 328, y = 492, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 11: blue0004
		{x = 328, y = 492, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 12: blue0005
		{x = 492, y = 492, width = 50, height = 64, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 13: blue hold end0000
		{x = 542, y = 492, width = 50, height = 44, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 14: blue hold piece0000
		{x = 0, y = 0, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 15: down confirm0000
		{x = 0, y = 0, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 16: down confirm0001
		{x = 164, y = 0, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 17: down confirm0002
		{x = 164, y = 0, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 18: down confirm0003
		{x = 328, y = 0, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 19: down confirm0004
		{x = 328, y = 0, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 20: down confirm0005
		{x = 0, y = 328, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 21: down press0000
		{x = 0, y = 328, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 22: down press0001
		{x = 164, y = 328, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 23: down press0002
		{x = 164, y = 328, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 24: down press0003
		{x = 328, y = 328, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 25: down press0004
		{x = 328, y = 328, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 26: down press0005
	},
	{
		["off"] = {start = 1, stop = 6, speed = 24, offsetX = 0, offsetY = 0},
		["on"] = {start = 7, stop = 12, speed = 24, offsetX = 0, offsetY = 0},
		["end"] = {start = 13, stop = 13, speed = 0, offsetX = 0, offsetY = 0},
		["hold"] = {start = 14, stop = 14, speed = 0, offsetX = 0, offsetY = 0},
		["confirm"] = {start = 15, stop = 20, speed = 24, offsetX = 0, offsetY = 0},
		["press"] = {start = 21, stop = 25, speed = 24, offsetX = 0, offsetY = 0}
	},
	"off",
	true
)
