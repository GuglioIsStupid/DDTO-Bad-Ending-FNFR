--[[----------------------------------------------------------------------------
This file is part of Friday Night Funkin' Rewritten

Copyright (C) 2021  HTV04

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
------------------------------------------------------------------------------]]

return graphics.newSprite(
    images.icons,
	{
		{x = 0, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Boyfriend
		{x = 150, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Boyfriend Losing
		{x = 300, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Boyfriend Sad
		{x = 450, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Boyfriend Sad Losing
		{x = 600, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Boyfriend Note
		{x = 750, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Boyfriend Note Losing
		{x = 0, y = 150, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Sayori
		{x = 150, y = 150, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Sayori Losing
		{x = 300, y = 150, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Sayori Sad
		{x = 450, y = 150, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Sayori Sad Losing
		{x = 600, y = 150, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Sayori Note
		{x = 750, y = 150, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Sayori Note Losing
		{x = 0, y = 300, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Yuri
		{x = 150, y = 300, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Yuri Losing
		{x = 300, y = 300, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Yuri Glitch
		{x = 450, y = 300, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Yuri Glitch Losing
		{x = 600, y = 300, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Yuri Closet
		{x = 750, y = 300, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Yuri Closet Losing
		{x = 0, y = 450, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Natsuki
		{x = 150, y = 450, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Natsuki Losing
		{x = 300, y = 450, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Natsuki i
		{x = 450, y = 450, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Natsuki i Losing
		{x = 600, y = 450, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Natsuki i2
		{x = 750, y = 450, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Natsuki i2 Losing
	},
	{
		-- Boyfriend
		["boyfriend"] = {start = 1, stop = 1, speed = 0, offsetX = 0, offsetY = 0},
		["boyfriend losing"] = {start = 2, stop = 2, speed = 0, offsetX = 0, offsetY = 0},
		["boyfriend sad"] = {start = 3, stop = 3, speed = 0, offsetX = 0, offsetY = 0},
		["boyfriend sad losing"] = {start = 4, stop = 4, speed = 0, offsetX = 0, offsetY = 0},
		["boyfriend note"] = {start = 5, stop = 5, speed = 0, offsetX = 0, offsetY = 0},
		["boyfriend note losing"] = {start = 6, stop = 6, speed = 0, offsetX = 0, offsetY = 0},
		-- Sayori
		["sayori"] = {start = 7, stop = 7, speed = 0, offsetX = 0, offsetY = 0},
		["sayori losing"] = {start = 8, stop = 8, speed = 0, offsetX = 0, offsetY = 0},
		["sayori sad"] = {start = 9, stop = 9, speed = 0, offsetX = 0, offsetY = 0},
		["sayori sad losing"] = {start = 10, stop = 10, speed = 0, offsetX = 0, offsetY = 0},
		["sayori note"] = {start = 11, stop = 11, speed = 0, offsetX = 0, offsetY = 0},
		["sayori note losing"] = {start = 12, stop = 12, speed = 0, offsetX = 0, offsetY = 0},
		-- Yuri
		["yuri"] = {start = 13, stop = 13, speed = 0, offsetX = 0, offsetY = 0},
		["yuri losing"] = {start = 14, stop = 14, speed = 0, offsetX = 0, offsetY = 0},
		["yuri glitch"] = {start = 15, stop = 15, speed = 0, offsetX = 0, offsetY = 0},
		["yuri glitch losing"] = {start = 16, stop = 16, speed = 0, offsetX = 0, offsetY = 0},
		["yuri closet"] = {start = 17, stop = 17, speed = 0, offsetX = 0, offsetY = 0},
		["yuri closet losing"] = {start = 18, stop = 18, speed = 0, offsetX = 0, offsetY = 0},
		-- Natsuki
		["natsuki"] = {start = 19, stop = 19, speed = 0, offsetX = 0, offsetY = 0},
		["natsuki losing"] = {start = 20, stop = 20, speed = 0, offsetX = 0, offsetY = 0},
		["natsuki i"] = {start = 21, stop = 21, speed = 0, offsetX = 0, offsetY = 0},
		["natsuki i losing"] = {start = 22, stop = 22, speed = 0, offsetX = 0, offsetY = 0},
		["natsuki i2"] = {start = 23, stop = 23, speed = 0, offsetX = 0, offsetY = 0},
		["natsuki i2 losing"] = {start = 24, stop = 24, speed = 0, offsetX = 0, offsetY = 0},
	},
	"boyfriend",
	false
)
