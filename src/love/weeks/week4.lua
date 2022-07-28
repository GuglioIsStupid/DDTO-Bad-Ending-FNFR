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

local song, difficulty

local sunset

local bgLimo, limoDancer, limo

return {
	enter = function(self, from, songNum, songAppend)
		pauseColor = {222, 132, 190}
		bpm = 100
		week = 4
		weeks:enter()
		stages["sunset"]:enter()

		song = songNum
		difficulty = songAppend

		healthBarColorEnemy = {216,85,142}
		healthBarColorPlayer = {49,176,209}

		enemyIcon:animate("mommy mearest", false)

		self:load()
	end,

	load = function(self)
		weeks:load()
		stages["sunset"]:load()

		if song == 3 then
			inst = love.audio.newSource("songs/week4/milf/inst.ogg", "stream")
			voices = love.audio.newSource("songs/week4/milf/voices.ogg", "stream")
		elseif song == 2 then
			inst = love.audio.newSource("songs/week4/high/inst.ogg", "stream")
			voices = love.audio.newSource("songs/week4/high/voices.ogg", "stream")
		else
			inst = love.audio.newSource("songs/week4/satin-panties/inst.ogg", "stream")
			voices = love.audio.newSource("songs/week4/satin-panties/voices.ogg", "stream")
		end

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		if song == 3 then
			weeks:generateNotes(love.filesystem.load("songs/week4/milf/" .. difficulty .. ".lua")())
		elseif song == 2 then
			weeks:generateNotes(love.filesystem.load("songs/week4/high/" .. difficulty .. ".lua")())
		else
			weeks:generateNotes(love.filesystem.load("songs/week4/satin-panties/" .. difficulty .. ".lua")())
		end
	end,

	update = function(self, dt)
		weeks:update(dt)
		stages["sunset"]:update(dt)
		
		-- Hardcoded M.I.L.F camera scaling
		if song == 3 and musicTime > 56000 and musicTime < 67000 and musicThres ~= oldMusicThres and math.fmod(absMusicTime, 60000 / bpm) < 100 then
			if camScaleTimer then Timer.cancel(camScaleTimer) end

			camScaleTimer = Timer.tween((60 / bpm) / 16, cam, {sizeX = camScale.x * 1.05, sizeY = camScale.y * 1.05}, "out-quad", function() camScaleTimer = Timer.tween((60 / bpm), cam, {sizeX = camScale.x, sizeY = camScale.y}, "out-quad") end)
		end

		if health >= 80 then
			if enemyIcon:getAnimName() == "mommy mearest" then
				enemyIcon:animate("mommy mearest losing", false)
			end
		else
			if enemyIcon:getAnimName() == "mommy mearest losing" then
				enemyIcon:animate("mommy mearest", false)
			end
		end

		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) and not paused then
			if storyMode and song < 3 then
				song = song + 1

				self:load()
			else
				status.setLoading(true)

				graphics.fadeOut(
					0.5,
					function()
						if storyMode then
							Gamestate.switch(menuWeek)
						else
							Gamestate.switch(menuFreeplay)
						end

						status.setLoading(false)
					end
				)
			end
		end

		weeks:updateUI(dt)
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
			love.graphics.scale(cam.sizeX, cam.sizeY)

			stages["sunset"]:draw()
			
			weeks:drawRating(1)
			
		love.graphics.pop()
		weeks:drawHealthBar()
		if not paused then
			weeks:drawUI()
		end
	end,

	leave = function()
		stages["sunset"]:leave()
		weeks:leave()
	end
}
