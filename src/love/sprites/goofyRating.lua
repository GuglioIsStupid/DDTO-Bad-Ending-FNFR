return graphics.newSprite(
	love.graphics.newImage(graphics.imagePath("goofyRating")),
	{
		{x = 0, y = 0, width = 377, height = 138, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Sick Plus
		{x = 0, y = 0, width = 377, height = 138, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Sick
		{x = 390, y = 0, width = 707-390, height = 118, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 3: Good
		{x = 715, y = 0, width = 971-715, height = 116, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 4: Bad
		{x = 980, y = 0, width = 1251-980, height = 132, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 5: Shit
	},
	{
		["sickPlus"] = {start = 1, stop = 1, speed = 0, offsetX = 0, offsetY = 0},
		["sick"] = {start = 2, stop = 2, speed = 0, offsetX = 0, offsetY = 0},
		["good"] = {start = 3, stop = 3, speed = 0, offsetX = 0, offsetY = 0},
		["bad"] = {start = 4, stop = 4, speed = 0, offsetX = 0, offsetY = 0},
		["shit"] = {start = 5, stop = 5, speed = 0, offsetX = 0, offsetY = 0}
	},
	"sickPlus",
	false
)