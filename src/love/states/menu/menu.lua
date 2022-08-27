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

local upFunc, downFunc, confirmFunc, backFunc, drawFunc, musicStop

local menuState

local menuNum = 1

local doingBPS, beatEverySecond, doNotRepeat

local songNum, songAppend
local songDifficulty = 2
local introFont

local selectSound = love.audio.newSource("sounds/menu/select.ogg", "static")
local confirmSound = love.audio.newSource("sounds/menu/confirm.ogg", "static")

local _introText, _introTextRaw, leFade, didTimers

local bg

music = love.audio.newSource("songs/misc/menu.ogg", "stream")

local function switchMenu(menu)
	function backFunc()
		graphics.fadeOut(0.5, love.event.quit)
	end

	menuState = 1
end

music:setLooping(true)

return {
	enter = function(self, previous)
		leFade = {
			0
		}
		didTimers = {
			false,
			false,
			false,
			false,
			false,
			false
		}

		bg = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/scrolling_bg")))
		bg.sizeX, bg.sizeY = 2.2,2.2

		doingBPS = false

		_introTextRaw = require "data.introText"
		_introText = _introTextRaw[love.math.random(1,#_introTextRaw)]
		doNotRepeat = false
		if not _introText[2] then _introText[2] = "" end
		if not _introText[3] then _introText[3] = "" end

		function logoRotate()
			doNotRepeat = true
			Timer.tween(2, logo, {orientation = 0.15}, "in-out-back", function()
				Timer.tween(2, logo, {orientation = -0.15}, "in-out-back", function()
					logoRotate()
				end)
			end)
		end
		menuBPM = 102
		curBeat = 1
		curStep = 1
		introFont = love.graphics.newFont("fonts/introFont.ttf", 64)
		function beatEverySecond()
			doingBPS = true
			Timer.after(
				1,
				function()
					curBeat = curBeat + 1
					beatEverySecond()
				end
			)
		end
		changingMenu = false
		logo = love.filesystem.load("sprites/menu/ve-logo.lua")()
		girlfriendTitle = love.filesystem.load("sprites/menu/girlfriend-title.lua")()
		titleEnter = love.filesystem.load("sprites/menu/titleEnter.lua")()

		whiteRectangles = {}
		for i = 1, 15 do
			table.insert(whiteRectangles, graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/whiteRectangle"))))
			whiteRectangles[i].x = -780 + 100*i
			whiteRectangles[i].y = -1200
		end

		girlfriendTitle.x, girlfriendTitle.y = 500, 65
		titleEnter.x, titleEnter.y = 225, 450

		__doingIntro = true

		girlfriendTitle.x, girlfriendTitle.y = 325, 65

		titleEnter.x, titleEnter.y = 225, 350
		songNum = 0

		cam.sizeX, cam.sizeY = 0.9, 0.9
		camScale.x, camScale.y = 0.9, 0.9

		switchMenu(1)

		graphics.setFade(0)
		graphics.fadeIn(0.5)

		if useDiscordRPC then
			presence = {
				state = "Press Enter", 
				details = "In the Menu",
				largeImageKey = "logo",
				startTimestamp = now,
			}
			nextPresenceUpdate = 0
		end

		music:play()
	end,

	musicStop = function(self)
		music:stop()
	end,

	musicVolumeLower = function(self)
		music:setVolume(0.4)
	end,

	update = function(self, dt)
		girlfriendTitle:update(dt)
		titleEnter:update(dt)
		logo:update(dt)

		curStep = math.floor(curBeat / 4)

		if not graphics.isFading() then
			if not doingBPS then
				beatEverySecond()
			end
			if input:pressed("confirm") then
				
				if not __doingIntro then
					if not changingMenu then
						titleEnter:animate("pressed", true)
						audio.playSound(confirmSound)
						changingMenu = true
						for i = 1, 15 do
							Timer.tween(0.5 + 0.1 + 0.03*i, whiteRectangles[i], {y = 0}, "linear",
								function()
									if i == 15 then
										Timer.after(
											0.15,
											function()
												Gamestate.switch(menuSelect)
												status.setLoading(false)
											end
										)
									end
								end
							)
						end
					end
				else
					music:seek(11.70, "seconds")
					__doingIntro = false
					Timer.tween(3, leFade, {[1] = 1}, "out-quad")
				end
			elseif input:pressed("back") then
				audio.playSound(selectSound)

				backFunc()
			end
		end
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)

			love.graphics.push()
				love.graphics.scale(cam.sizeX, cam.sizeY)

				if not __doingIntro then
					love.graphics.setColor(1,1,1,leFade[1])
					love.graphics.translate(-math.abs(graphics.getWidth()/2), -math.abs(graphics.getHeight()/2))
					bg:draw()
					love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)
					logo:draw()

					love.graphics.setColor(0, 0, 0, 0.85)
					for i = 1, 15 do
						whiteRectangles[i]:draw()
					end
					love.graphics.setColor(1, 1, 1)
				else
					love.graphics.setFont(introFont)
					if curBeat == 3 or curBeat == 4 then
						love.graphics.printf("MOD BY\nTEAM TBD\n\nPORTED BY\nGUGLIOISSTUPID",-320,-225, 700, "center")
					elseif curBeat == 6 or curBeat == 7 then
						love.graphics.printf(
							_introText[1],
							-320,-210, 700, "center"
						)
						if didTimers[2] then
							love.graphics.printf("\n".._introText[2],-320,-210, 700, "center")
						end
						if didTimers[3] then 
							love.graphics.printf("\n\n".._introText[3],-320,-210, 700, "center")
						end
						if not didTimers[1] then
							didTimers[1] = true
							Timer.after(
								1,
								function()
									didTimers[2] = true
									Timer.after(
										0.65,
										function()
											didTimers[3] = true
										end
									)
								end
							)
						end
					elseif curBeat == 9 or curBeat == 10 then
						love.graphics.printf("DDTO",-320,-210, 700, "center")
						if didTimers[5] then
							love.graphics.printf("\nBAD",-320,-210, 700, "center")
						end
						if didTimers[6] then
							love.graphics.printf("\n\nENDING",-320,-210, 700, "center")
						end
						if not didTimers[4] then
							didTimers[4] = true
							Timer.after(
								0.65,
								function()
									didTimers[5] = true
									Timer.after(
										0.65,
										function()
											didTimers[6] = true
										end
									)
								end
							)
						end
					elseif curBeat == 12 and __doingIntro then
						__doingIntro = false
						Timer.tween(3, leFade, {[1] = 1}, "out-quad")
					end
					love.graphics.setFont(font)
				end

			love.graphics.pop()
		love.graphics.pop()
	end,

	leave = function(self)
		girlfriendTitle = nil
		titleEnter = nil
		logo = nil

		Timer.clear()
	end
}
