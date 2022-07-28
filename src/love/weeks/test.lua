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

local stageBack, stageFront, curtains


return {
	enter = function(self, from, songNum, songAppend)
		weeks_test:enter()

		week = -1 --idfk what to call this one
		--          you call it deez
		angle = {}

		for i = 1, 2 do
			angle[i] = 0
		end

		song = songNum
		difficulty = songAppend

		healthBarColorEnemy = {49,176,209}

		stageBack = graphics.newImage(love.graphics.newImage(graphics.imagePath("week1/stage-back")))
		stageFront = graphics.newImage(love.graphics.newImage(graphics.imagePath("week1/stage-front")))
		curtains = graphics.newImage(love.graphics.newImage(graphics.imagePath("week1/curtains")))

		stageFront.y = 400
		curtains.y = -100

        love.graphics.setDefaultFilter("nearest")
		enemy = love.filesystem.load("sprites/pixel/test/boyfriend.lua")()
        love.graphics.setDefaultFilter("linear")

		girlfriend.x, girlfriend.y = 30, -90
		enemy.x, enemy.y = -380, -210
		boyfriend.x, boyfriend.y = 260, 100

		enemyIcon:animate("boyfriend (pixel)", false)

		self:load()
	end,

	load = function(self)
		weeks_test:load()

		inst = love.audio.newSource("songs/test/inst.ogg", "stream")
		voices = love.audio.newSource("songs/test/voices.ogg", "stream")

		self:initUI()

		weeks_test:setupCountdown()
	end,

	initUI = function(self)
		weeks_test:initUI()

		weeks_test:generateNotes(love.filesystem.load("songs/test/normal.lua")())
	end,

	update = function(self, dt)
		weeks_test:update(dt)

		angle[1] = angle[1] + 3 * dt

		angle[2] = angle[2] + 9 * dt

		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) then
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

		weeks_test:updateUI(dt)
	end,

	draw = function(self)
		--love.graphics.shear(math.cos(love.timer.getTime()), math.cos(love.timer.getTime() * 1.3))
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
			love.graphics.scale(cam.sizeX, cam.sizeY)

			love.graphics.push()
				love.graphics.translate(cam.x * 0.9, cam.y * 0.9)

				stageBack:draw()
				stageFront:draw()

				love.graphics.push()
				love.graphics.shear(math.cos(love.timer.getTime() * 1.1), math.cos(love.timer.getTime() * 1.8))
					girlfriend:draw()
				love.graphics.pop()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)
				
				love.graphics.push()
				love.graphics.shear(-math.cos(love.timer.getTime()), -math.cos(love.timer.getTime() * 1.3))
					love.graphics.rotate(-angle[2])
					enemy:udraw(-7,7)
				love.graphics.pop()
				love.graphics.shear(math.cos(love.timer.getTime()), math.cos(love.timer.getTime() * 5))
				--Timer.tween(0.4, thingyig, {[1] = [1] + math.pi * 2}, "linear")

				--Timer.tween(0.8, THETHING, {[2] = -1}, "in-out-elastic")
				love.graphics.rotate(angle[1])
				boyfriend:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 1.1, cam.y * 1.1)

				curtains:draw()
			love.graphics.pop()
			weeks_test:drawRating(0.9)
		love.graphics.pop()

		--love.graphics.shear(math.cos(love.timer.getTime()), math.cos(love.timer.getTime() * 1.3))
		--love.graphics.shear(math.cos(love.timer.getTime()), math.cos(love.timer.getTime() / 1.3))
		weeks_test:drawUI()
	end,

	leave = function(self)
		stageBack = nil
		stageFront = nil
		curtains = nil

		weeks_test:leave()
	end
}
