return graphics.newSprite(
	images.goofyNotes,
	{
		{x = 1464, y = 164, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: arrowUP0000
		{x = 1464, y = 164, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: arrowUP0001
		{x = 1628, y = 164, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 3: arrowUP0002
		{x = 1628, y = 164, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 4: arrowUP0003
		{x = 1792, y = 164, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 5: arrowUP0004
		{x = 1792, y = 164, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 6: arrowUP0005
		{x = 592, y = 492, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 7: green0000
		{x = 592, y = 492, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 8: green0001
		{x = 756, y = 492, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 9: green0002
		{x = 756, y = 492, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 10: green0003
		{x = 920, y = 492, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 11: green0004
		{x = 920, y = 492, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 12: green0005
		{x = 492, y = 492, width = 50, height = 64, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 13: green hold end0000
		{x = 542, y = 492, width = 50, height = 44, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 14: green hold piece0000
		{x = 1464, y = 0, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 15: up confirm0000
		{x = 1464, y = 0, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 16: up confirm0001
		{x = 1628, y = 0, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 17: up confirm0002
		{x = 1628, y = 0, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 18: up confirm0003
		{x = 1792, y = 0, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 19: up confirm0004
		{x = 1792, y = 0, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 20: up confirm0005
		{x = 1464, y = 328, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 21: up press0000
		{x = 1464, y = 328, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 22: up press0001
		{x = 1628, y = 328, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 23: up press0002
		{x = 1628, y = 328, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 24: up press0003
		{x = 1792, y = 328, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 25: up press0004
		{x = 1792, y = 328, width = 164, height = 162, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0} -- 26: up press0005
	},
	{
		["off"] = {start = 1, stop = 6, speed = 24, offsetX = 0, offsetY = 0},
		["on"] = {start = 7, stop = 12, speed = 24, offsetX = 0, offsetY = 0},
		["end"] = {start = 13, stop = 13, speed = 0, offsetX = 0, offsetY = 0},
		["hold"] = {start = 14, stop = 14, speed = 0, offsetX = 0, offsetY = 0},
		["confirm"] = {start = 15, stop = 20, speed = 24, offsetX = 0, offsetY = 0},
		["press"] = {start = 21, stop = 26, speed = 24, offsetX = 0, offsetY = 0}
	},
	"off",
	true
)
