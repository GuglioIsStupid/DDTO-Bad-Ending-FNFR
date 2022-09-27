return graphics.newSprite(
	love.graphics.newImage(graphics.imagePath("characters/silhouette_nat")), -- Do not add the .png extension
	{
		{x = 669, y = 563, width = 329, height = 556, offsetX = -9, offsetY = -12, offsetWidth = 372, offsetHeight = 569}, -- 1: Nat Idle0000
		{x = 669, y = 563, width = 329, height = 556, offsetX = -9, offsetY = -12, offsetWidth = 372, offsetHeight = 569}, -- 2: Nat Idle0001
		{x = 0, y = 1122, width = 335, height = 550, offsetX = -30, offsetY = -19, offsetWidth = 372, offsetHeight = 569}, -- 3: Nat Idle0002
		{x = 1340, y = 0, width = 339, height = 554, offsetX = -30, offsetY = -15, offsetWidth = 372, offsetHeight = 569}, -- 4: Nat Idle0003
		{x = 1340, y = 0, width = 339, height = 554, offsetX = -30, offsetY = -15, offsetWidth = 372, offsetHeight = 569}, -- 5: Nat Idle0004
		{x = 1013, y = 0, width = 327, height = 559, offsetX = -33, offsetY = -10, offsetWidth = 372, offsetHeight = 569}, -- 6: Nat Idle0005
		{x = 336, y = 563, width = 333, height = 558, offsetX = -19, offsetY = -10, offsetWidth = 372, offsetHeight = 569}, -- 7: Nat Idle0006
		{x = 336, y = 563, width = 333, height = 558, offsetX = -19, offsetY = -10, offsetWidth = 372, offsetHeight = 569}, -- 8: Nat Idle0007
		{x = 1340, y = 554, width = 323, height = 554, offsetX = -12, offsetY = -14, offsetWidth = 372, offsetHeight = 569}, -- 9: Nat Idle0008
		{x = 998, y = 563, width = 328, height = 556, offsetX = -9, offsetY = -12, offsetWidth = 372, offsetHeight = 569}, -- 10: Nat Idle0009
		{x = 669, y = 563, width = 329, height = 556, offsetX = -9, offsetY = -12, offsetWidth = 372, offsetHeight = 569}, -- 11: Nat Idle0010
		{x = 669, y = 563, width = 329, height = 556, offsetX = -9, offsetY = -12, offsetWidth = 372, offsetHeight = 569}, -- 12: Nat Idle0011
		{x = 669, y = 563, width = 329, height = 556, offsetX = -9, offsetY = -12, offsetWidth = 372, offsetHeight = 569}, -- 13: Nat Idle0012
		{x = 669, y = 563, width = 329, height = 556, offsetX = -9, offsetY = -12, offsetWidth = 372, offsetHeight = 569}, -- 14: Nat Idle0013
		{x = 1025, y = 1672, width = 357, height = 504, offsetX = -29, offsetY = -43, offsetWidth = 400, offsetHeight = 548}, -- 15: Nat Sing Note DOWN0000
		{x = 1382, y = 1672, width = 352, height = 502, offsetX = -32, offsetY = -45, offsetWidth = 400, offsetHeight = 548}, -- 16: Nat Sing Note DOWN0001
		{x = 673, y = 1672, width = 352, height = 506, offsetX = -21, offsetY = -41, offsetWidth = 400, offsetHeight = 548}, -- 17: Nat Sing Note DOWN0002
		{x = 0, y = 1672, width = 334, height = 523, offsetX = -16, offsetY = -24, offsetWidth = 400, offsetHeight = 548}, -- 18: Nat Sing Note DOWN0003
		{x = 0, y = 1672, width = 334, height = 523, offsetX = -16, offsetY = -24, offsetWidth = 400, offsetHeight = 548}, -- 19: Nat Sing Note DOWN0004
		{x = 334, y = 1672, width = 339, height = 523, offsetX = -16, offsetY = -24, offsetWidth = 400, offsetHeight = 548}, -- 20: Nat Sing Note DOWN0005
		{x = 334, y = 1672, width = 339, height = 523, offsetX = -16, offsetY = -24, offsetWidth = 400, offsetHeight = 548}, -- 21: Nat Sing Note DOWN0006
		{x = 334, y = 1672, width = 339, height = 523, offsetX = -16, offsetY = -24, offsetWidth = 400, offsetHeight = 548}, -- 22: Nat Sing Note DOWN0007
		{x = 334, y = 1672, width = 339, height = 523, offsetX = -16, offsetY = -24, offsetWidth = 400, offsetHeight = 548}, -- 23: Nat Sing Note DOWN0008
		{x = 334, y = 1672, width = 339, height = 523, offsetX = -16, offsetY = -24, offsetWidth = 400, offsetHeight = 548}, -- 24: Nat Sing Note DOWN0009
		{x = 334, y = 1672, width = 339, height = 523, offsetX = -16, offsetY = -24, offsetWidth = 400, offsetHeight = 548}, -- 25: Nat Sing Note DOWN0010
		{x = 334, y = 1672, width = 339, height = 523, offsetX = -16, offsetY = -24, offsetWidth = 400, offsetHeight = 548}, -- 26: Nat Sing Note DOWN0011
		{x = 334, y = 1672, width = 339, height = 523, offsetX = -16, offsetY = -24, offsetWidth = 400, offsetHeight = 548}, -- 27: Nat Sing Note DOWN0012
		{x = 334, y = 1672, width = 339, height = 523, offsetX = -16, offsetY = -24, offsetWidth = 400, offsetHeight = 548}, -- 28: Nat Sing Note DOWN0013
		{x = 1988, y = 0, width = 315, height = 528, offsetX = -8, offsetY = -18, offsetWidth = 333, offsetHeight = 547}, -- 29: Nat Sing Note Left0000
		{x = 1679, y = 0, width = 309, height = 530, offsetX = -12, offsetY = -16, offsetWidth = 333, offsetHeight = 547}, -- 30: Nat Sing Note Left0001
		{x = 1679, y = 0, width = 309, height = 530, offsetX = -12, offsetY = -16, offsetWidth = 333, offsetHeight = 547}, -- 31: Nat Sing Note Left0002
		{x = 1988, y = 528, width = 306, height = 524, offsetX = -12, offsetY = -22, offsetWidth = 333, offsetHeight = 547}, -- 32: Nat Sing Note Left0003
		{x = 1679, y = 530, width = 308, height = 530, offsetX = -13, offsetY = -16, offsetWidth = 333, offsetHeight = 547}, -- 33: Nat Sing Note Left0004
		{x = 1679, y = 530, width = 308, height = 530, offsetX = -13, offsetY = -16, offsetWidth = 333, offsetHeight = 547}, -- 34: Nat Sing Note Left0005
		{x = 1368, y = 1122, width = 310, height = 538, offsetX = -13, offsetY = -8, offsetWidth = 333, offsetHeight = 547}, -- 35: Nat Sing Note Left0006
		{x = 1368, y = 1122, width = 310, height = 538, offsetX = -13, offsetY = -8, offsetWidth = 333, offsetHeight = 547}, -- 36: Nat Sing Note Left0007
		{x = 1368, y = 1122, width = 310, height = 538, offsetX = -13, offsetY = -8, offsetWidth = 333, offsetHeight = 547}, -- 37: Nat Sing Note Left0008
		{x = 1368, y = 1122, width = 310, height = 538, offsetX = -13, offsetY = -8, offsetWidth = 333, offsetHeight = 547}, -- 38: Nat Sing Note Left0009
		{x = 1368, y = 1122, width = 310, height = 538, offsetX = -13, offsetY = -8, offsetWidth = 333, offsetHeight = 547}, -- 39: Nat Sing Note Left0010
		{x = 1368, y = 1122, width = 310, height = 538, offsetX = -13, offsetY = -8, offsetWidth = 333, offsetHeight = 547}, -- 40: Nat Sing Note Left0011
		{x = 1368, y = 1122, width = 310, height = 538, offsetX = -13, offsetY = -8, offsetWidth = 333, offsetHeight = 547}, -- 41: Nat Sing Note Left0012
		{x = 1368, y = 1122, width = 310, height = 538, offsetX = -13, offsetY = -8, offsetWidth = 333, offsetHeight = 547}, -- 42: Nat Sing Note Left0013
		{x = 658, y = 0, width = 355, height = 560, offsetX = -1, offsetY = -22, offsetWidth = 381, offsetHeight = 583}, -- 43: Nat Sing Note Right0000
		{x = 658, y = 0, width = 355, height = 560, offsetX = -1, offsetY = -22, offsetWidth = 381, offsetHeight = 583}, -- 44: Nat Sing Note Right0001
		{x = 680, y = 1122, width = 349, height = 546, offsetX = -1, offsetY = -37, offsetWidth = 381, offsetHeight = 583}, -- 45: Nat Sing Note Right0002
		{x = 335, y = 1122, width = 345, height = 548, offsetX = -1, offsetY = -34, offsetWidth = 381, offsetHeight = 583}, -- 46: Nat Sing Note Right0003
		{x = 1029, y = 1122, width = 339, height = 546, offsetX = -1, offsetY = -36, offsetWidth = 381, offsetHeight = 583}, -- 47: Nat Sing Note Right0004
		{x = 1029, y = 1122, width = 339, height = 546, offsetX = -1, offsetY = -36, offsetWidth = 381, offsetHeight = 583}, -- 48: Nat Sing Note Right0005
		{x = 1029, y = 1122, width = 339, height = 546, offsetX = -1, offsetY = -36, offsetWidth = 381, offsetHeight = 583}, -- 49: Nat Sing Note Right0006
		{x = 1029, y = 1122, width = 339, height = 546, offsetX = -1, offsetY = -36, offsetWidth = 381, offsetHeight = 583}, -- 50: Nat Sing Note Right0007
		{x = 1029, y = 1122, width = 339, height = 546, offsetX = -1, offsetY = -36, offsetWidth = 381, offsetHeight = 583}, -- 51: Nat Sing Note Right0008
		{x = 1029, y = 1122, width = 339, height = 546, offsetX = -1, offsetY = -36, offsetWidth = 381, offsetHeight = 583}, -- 52: Nat Sing Note Right0009
		{x = 1029, y = 1122, width = 339, height = 546, offsetX = -1, offsetY = -36, offsetWidth = 381, offsetHeight = 583}, -- 53: Nat Sing Note Right0010
		{x = 1029, y = 1122, width = 339, height = 546, offsetX = -1, offsetY = -36, offsetWidth = 381, offsetHeight = 583}, -- 54: Nat Sing Note Right0011
		{x = 1029, y = 1122, width = 339, height = 546, offsetX = -1, offsetY = -36, offsetWidth = 381, offsetHeight = 583}, -- 55: Nat Sing Note Right0012
		{x = 1029, y = 1122, width = 339, height = 546, offsetX = -1, offsetY = -36, offsetWidth = 381, offsetHeight = 583}, -- 56: Nat Sing Note Right0013
		{x = 0, y = 0, width = 325, height = 563, offsetX = -16, offsetY = -10, offsetWidth = 366, offsetHeight = 573}, -- 57: Nat Sing Note Up0000
		{x = 0, y = 0, width = 325, height = 563, offsetX = -16, offsetY = -10, offsetWidth = 366, offsetHeight = 573}, -- 58: Nat Sing Note Up0001
		{x = 0, y = 563, width = 336, height = 559, offsetX = -25, offsetY = -13, offsetWidth = 366, offsetHeight = 573}, -- 59: Nat Sing Note Up0002
		{x = 325, y = 0, width = 333, height = 563, offsetX = -27, offsetY = -9, offsetWidth = 366, offsetHeight = 573}, -- 60: Nat Sing Note Up0003
		{x = 325, y = 0, width = 333, height = 563, offsetX = -27, offsetY = -9, offsetWidth = 366, offsetHeight = 573}, -- 61: Nat Sing Note Up0004
		{x = 325, y = 0, width = 333, height = 563, offsetX = -27, offsetY = -9, offsetWidth = 366, offsetHeight = 573}, -- 62: Nat Sing Note Up0005
		{x = 325, y = 0, width = 333, height = 563, offsetX = -27, offsetY = -9, offsetWidth = 366, offsetHeight = 573}, -- 63: Nat Sing Note Up0006
		{x = 325, y = 0, width = 333, height = 563, offsetX = -27, offsetY = -9, offsetWidth = 366, offsetHeight = 573}, -- 64: Nat Sing Note Up0007
		{x = 325, y = 0, width = 333, height = 563, offsetX = -27, offsetY = -9, offsetWidth = 366, offsetHeight = 573}, -- 65: Nat Sing Note Up0008
		{x = 325, y = 0, width = 333, height = 563, offsetX = -27, offsetY = -9, offsetWidth = 366, offsetHeight = 573}, -- 66: Nat Sing Note Up0009
		{x = 325, y = 0, width = 333, height = 563, offsetX = -27, offsetY = -9, offsetWidth = 366, offsetHeight = 573}, -- 67: Nat Sing Note Up0010
		{x = 325, y = 0, width = 333, height = 563, offsetX = -27, offsetY = -9, offsetWidth = 366, offsetHeight = 573}, -- 68: Nat Sing Note Up0011
		{x = 325, y = 0, width = 333, height = 563, offsetX = -27, offsetY = -9, offsetWidth = 366, offsetHeight = 573}, -- 69: Nat Sing Note Up0012
		{x = 325, y = 0, width = 333, height = 563, offsetX = -27, offsetY = -9, offsetWidth = 366, offsetHeight = 573} -- 70: Nat Sing Note Up0013
	},
	{
		["idle"] = {start = 1, stop = 14, speed = 24, offsetX = 0, offsetY = 0},
		["left"] = {start = 29, stop = 42, speed = 24, offsetX = -8, offsetY = -11},
		["down"] = {start = 15, stop = 28, speed = 24, offsetX = -9, offsetY = -11},
		["up"] = {start = 57, stop = 70, speed = 24, offsetX = 28, offsetY = 1},
		["right"] = {start = 43, stop = 56, speed = 24, offsetX = -39, offsetY = 6},
	},
	"idle", -- set to default animation
	false -- If the sprite repeats
)
