return graphics.newSprite(
	images.goofyNotes,
	{
		{x = 492, y = 164, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: arrowLEFT0000
		{x = 492, y = 164, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: arrowLEFT0001
		{x = 654, y = 164, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 3: arrowLEFT0002
		{x = 654, y = 164, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 4: arrowLEFT0003
		{x = 816, y = 164, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 5: arrowLEFT0004
		{x = 816, y = 164, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 6: arrowLEFT0005
		{x = 492, y = 0, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 7: left confirm0000
		{x = 492, y = 0, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 8: left confirm0001
		{x = 654, y = 0, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 9: left confirm0002
		{x = 654, y = 0, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 10: left confirm0003
		{x = 816, y = 0, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 11: left confirm0004
		{x = 816, y = 0, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 12: left confirm0005
		{x = 492, y = 328, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 13: left press0000
		{x = 492, y = 328, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 14: left press0001
		{x = 654, y = 328, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 15: left press0002
		{x = 654, y = 328, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 16: left press0003
		{x = 816, y = 328, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 17: left press0004
		{x = 816, y = 328, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 18: left press0005
		{x = 492, y = 492, width = 50, height = 64, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 19: pruple end hold0000
		{x = 1084, y = 492, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 20: purple0000
		{x = 1084, y = 492, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 21: purple0001
		{x = 1246, y = 492, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 22: purple0002
		{x = 1246, y = 492, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 23: purple0003
		{x = 1408, y = 492, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 24: purple0004
		{x = 1408, y = 492, width = 162, height = 164, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 25: purple0005
		{x = 542, y = 492, width = 50, height = 44, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 26: purple hold piece0000
	},
	{
		["off"] = {start = 1, stop = 6, speed = 24, offsetX = 0, offsetY = 0},
		["confirm"] = {start = 7, stop = 12, speed = 24, offsetX = 0, offsetY = 0},
		["press"] = {start = 13, stop = 18, speed = 24, offsetX = 0, offsetY = 0},
		["end"] = {start = 19, stop = 19, speed = 0, offsetX = 0, offsetY = 0},
		["on"] = {start = 20, stop = 25, speed = 24, offsetX = 0, offsetY = 0},
		["hold"] = {start = 26, stop = 26, speed = 0, offsetX = 0, offsetY = 0}
	},
	"off",
	true
)
