return graphics.newSprite(
	images.goofyNotes,
	{
		{x = 978, y = 164, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: arrowRIGHT0000
		{x = 978, y = 164, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: arrowRIGHT0001
		{x = 1140, y = 164, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 3: arrowRIGHT0002
		{x = 1140, y = 164, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 4: arrowRIGHT0003
		{x = 1302, y = 164, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 5: arrowRIGHT0004
		{x = 1302, y = 164, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 6: arrowRIGHT0005
		{x = 1570, y = 492, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 7: red0000
		{x = 1570, y = 492, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 8: red0001
		{x = 1732, y = 492, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 9: red0002
		{x = 1732, y = 492, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 10: red0003
		{x = 0, y = 656, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 11: red0004
		{x = 0, y = 656, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 12: red0005
		{x = 492, y = 492, width = 50, height = 64, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 13: red hold end0000
		{x = 542, y = 492, width = 50, height = 44, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 14: red hold piece0000
		{x = 978, y = 0, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 15: right confirm0000
		{x = 978, y = 0, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 16: right confirm0001
		{x = 1140, y = 0, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 17: right confirm0002
		{x = 1140, y = 0, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 18: right confirm0003
		{x = 1302, y = 0, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 19: right confirm0004
		{x = 1302, y = 0, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 20: right confirm0005
		{x = 978, y = 328, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 21: right press0000
		{x = 978, y = 328, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 22: right press0001
		{x = 1140, y = 328, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 23: right press0002
		{x = 1140, y = 328, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 24: right press0003
		{x = 1302, y = 328, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 25: right press0004
		{x = 1302, y = 328, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 26: right press0005
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
