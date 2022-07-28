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

local upFunc, downFunc, confirmFunc, backFunc, drawFunc, menuFunc, menuDesc, trackNames

local menuState

local menuNum = 1

weekNum = 1
local songNum, songAppend
local songDifficulty = 2

local weekDesc = { -- Add your week description here
	"LEARN TO FUNK",
	"DADDY DEAREST",
	"SPOOKY MONTH",
	"PICO",
	"MOMMY MUST MURDER",
	"RED SNOW",
	"HATING SIMULATOR FT. MOAWLING",
	"TANKMAN"
}
local difficultyStrs = { 
	"easy",
	"normal",
	"hard"
}

trackNames = { -- add your songs here
	{
		"Tutorial"
	},
	{
		"Bopeebo",
		"Fresh",
		"Dad-Battle"
	},
	{
		"Spookeez",
		"South",
		"Monster"
	},
	{
		"Pico",
		"Philly",
		"Blammed"
	},
	{
		"Satin-Panties",
		"High",
		"M.I.L.F"
	},
	{
		"Cocoa",
		"Eggnog",
		"Winter-Horrorland"
	},
	{
		"Senpai",
		"Roses",
		"Thorns"
	},
	{
		"Ugh",
		"Guns",
		"Stress"
	}
}

local selectSound = love.audio.newSource("sounds/menu/select.ogg", "static")
local confirmSound = love.audio.newSource("sounds/menu/confirm.ogg", "static")

local function switchMenu(menu)

end

return {
	enter = function(self, previous)
		songNum = 0
		weekNum = 1	

		weekButtonY = {
			[1] = 220,
			[2] = 320,
			[3] = 420,
			[4] = 520,
			[5] = 620,
			[6] = 720,
			[7] = 820,
			[8] = 920
		}

		function colourTween()
			Timer.tween(
				0.1,
				freeColour, 
				{
					[1] = freeplayColours[weekNum][1],
					[2] = freeplayColours[weekNum][2],
					[3] = freeplayColours[weekNum][3]
				}, 
				"linear"
			)
		end

		cam.sizeX, cam.sizeY = 0.9, 0.9
		camScale.x, camScale.y = 0.9, 0.9

		if useDiscordRPC then -- Set a custom RPC here
			presence = {
				state = "Choosing A Week",
				details = "In the Week Select Menu",
				largeImageKey = "logo",
				startTimestamp = now,
			}
			nextPresenceUpdate = 0
		end

		freeColour = {
			255,255,255
		}
		freeplayColours = {
			{146,0,68}, -- Tutorial
			{129,100,223}, -- Week 1
			{30,45,60}, -- Week 2
			{131,19,73}, -- Week 3
			{222,132,190}, -- Week 4
			{141,184,225}, -- Week 5
			{225,106,169}, -- Week 6
			{50,50,50} -- Week 7
		}
		Timer.tween(
			0.8,
			freeColour, 
			{
				[1] = freeplayColours[1][1],
				[2] = freeplayColours[1][2],
				[3] = freeplayColours[1][3]
			}, 
			"linear"
		)

		
		titleBG = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/weekMenu")))

		enemyDanceLines = love.filesystem.load("sprites/menu/idlelines.lua")()

		difficultyAnim = love.filesystem.load("sprites/menu/difficulty.lua")()

		bfDanceLines = love.filesystem.load("sprites/menu/idlelines.lua")()

		gfDanceLines = love.filesystem.load("sprites/menu/idlelines.lua")()

		enemyDanceLines.x, enemyDanceLines.y = -375, -170
		enemyDanceLines.sizeX, enemyDanceLines.sizeY = 0.5, 0.5

		bfDanceLines.sizeX, bfDanceLines.sizeY = 0.7, 0.7
		gfDanceLines.sizeX, gfDanceLines.sizeY = 0.5, 0.5

		bfDanceLines.x, bfDanceLines.y = 0, -150
		gfDanceLines.x, gfDanceLines.y = 375, -170

		difficultyAnim.x, difficultyAnim.y = 400, 220

		weekImages = {}
		for i = 1, #weekDesc-1 do
			table.insert(weekImages, graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/week" .. i-1))))
		end

		bfDanceLines:animate("boyfriend", true)
		gfDanceLines:animate("girlfriend", true)
		enemyDanceLines:animate("week1", true)

		switchMenu(1)

		graphics.setFade(0)
		graphics.fadeIn(0.5)

		function confirmFunc()
			menu:musicStop()
			songNum = 1

			status.setLoading(true)

			graphics.fadeOut(
				0.5,
				function()
					if useDiscordRPC then
						presence = {
							state = "Selected a week",
							details = "Playing a week",
							largeImageKey = "logo",
							startTimestamp = now,
						}
						nextPresenceUpdate = 0
					end
					
					songAppend = difficultyStrs[songDifficulty]

					storyMode = true

					Gamestate.switch(weekData[weekNum], songNum, songAppend, weekNum, trackNames)

					status.setLoading(false)
				end
			)
		end
		
	end,

	update = function(self, dt)
		for i = 1, #weekDesc-1 do
			weekImages[i].y = weekButtonY[i]
		end

		function menuFunc()
			if weekNum ~= 7 then -- Due to senpais idlelines being smaller than the rest, we resize it
				enemyDanceLines.sizeX, enemyDanceLines.sizeY = 0.5, 0.5
			elseif weekNum == 7 then
				enemyDanceLines.sizeX, enemyDanceLines.sizeY = 1, 1
			end

			weekBefore = weekImages[weekNum - 1]
			weekAfter = weekImages[weekNum + 1]

			enemyDanceLines:animate("week" .. weekNum, true)
		end
		
		enemyDanceLines:update(dt)
		bfDanceLines:update(dt)
		gfDanceLines:update(dt)

		if songDifficulty == 1 then
			difficultyAnim:animate("easy", true)
		elseif songDifficulty == 2 then
			difficultyAnim:animate("normal", true)
		elseif songDifficulty == 3 then
			difficultyAnim:animate("hard", true)
		end

		difficultyAnim:update(dt)

		if not graphics.isFading() then
			if not music:isPlaying() then
				music:play()
			end
			if input:pressed("down") then
				audio.playSound(selectSound)

				if weekNum ~= #trackNames then
					weekNum = weekNum + 1
					colourTween()
					for i = 1, #weekDesc-1 do
						Timer.tween(0.2, weekButtonY, { [i] = weekButtonY[i] - 100}, "out-expo")
					end
				else
					weekNum = 1
					colourTween()
					for i = 1, #weekDesc-1 do
						Timer.tween(0.2, weekButtonY, { [i] = 120 + 100*i}, "out-expo")
					end
				end
				menuFunc()
			elseif input:pressed("up") then
				audio.playSound(selectSound)

				if weekNum ~= 1 then
					weekNum = weekNum - 1
					colourTween()
					for i = 1, #weekDesc-1 do
						Timer.tween(0.2, weekButtonY, { [i] = weekButtonY[i] + 100 }, "out-expo")
					end
				else
					weekNum = #trackNames
					colourTween()
					for i = 1, #weekDesc-1 do
						Timer.tween(0.2, weekButtonY, { [i] = 220 - (700 - 100*i)}, "out-expo")
					end
				end
				menuFunc()
			elseif input:pressed("left") then
				audio.playSound(selectSound)

				if songDifficulty ~= 1 then
					songDifficulty = songDifficulty - 1
				else
					songDifficulty = 3 
				end

			elseif input:pressed("right") then
				audio.playSound(selectSound)

				if songDifficulty ~= 3 then
					songDifficulty = songDifficulty + 1
				else
					songDifficulty = 1
				end

			elseif input:pressed("confirm") then
				audio.playSound(confirmSound)
                bfDanceLines:animate("boyfriend confirm", false)

				confirmFunc()
			elseif input:pressed("back") then
				audio.playSound(selectSound)

				Gamestate.switch(menuSelect)
			end
		end
		currentWeek = weekImages[weekNum]
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)

			titleBG:draw()

			love.graphics.push()
				love.graphics.scale(cam.sizeX, cam.sizeY)
				for i = 1, #weekDesc-1 do
					weekImages[i]:draw()
				end

				graphics.setColor(0, 0, 0)
				
				love.graphics.rectangle("fill", -1000, -351, 2500, -100) 

				graphics.setColorF(freeColour[1], freeColour[2], freeColour[3])

				love.graphics.rectangle("fill", -1000, -351, 2500, 411) 

				graphics.setColor(1, 1, 1)

				difficultyAnim:draw()
				if weekNum ~= 1 then
					enemyDanceLines:draw()
				end
				bfDanceLines:draw()
				gfDanceLines:draw()

				love.graphics.color.printf(weekDesc[weekNum], -585, -395, 853, "right", nil, 1.5, 1.5)

				love.graphics.color.printf("TRACKS", -1050, 140, 853, "center", nil, 1.5, 1.5, 255, 117, 172)
				for trackLength = 1, #trackNames[weekNum] do
					love.graphics.color.printf(trackNames[weekNum][trackLength], -1050, 135 + (35 * trackLength), 853, "center", nil, 1.5, 1.5, 255, 117, 172)
				end

			love.graphics.pop()
		love.graphics.pop()
	end,

	leave = function(self)
		enemyDanceLines = nil
		bfDanceLines = nil
		gfDanceLines = nil
		titleBG = nil
		difficultyAnim = nil
		Timer.clear()
	end
}