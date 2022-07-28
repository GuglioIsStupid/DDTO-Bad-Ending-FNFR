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

local difficulty

local stageBack, stageFront, curtains

local zoomTimer
local zoom = {}

return {
	enter = function(self, from, songNum, songAppend)
		pauseColor = {146, 0, 68}

		weeks:enter()

		week = 0

		difficulty = songAppend

		--healthBarColorPlayer = {R,G,B} -- USE 255 VALUES
		healthBarColorEnemy = {165,0,77}

		stageBack = graphics.newImage(love.graphics.newImage(graphics.imagePath("week1/stage-back")))
		stageFront = graphics.newImage(love.graphics.newImage(graphics.imagePath("week1/stage-front")))
		curtains = graphics.newImage(love.graphics.newImage(graphics.imagePath("week1/curtains")))

		stageFront.y = 400
		curtains.y = -100

		enemy = girlfriend -- For compatibility with weeks

		girlfriend.x, girlfriend.y = 30, -90
		boyfriend.x, boyfriend.y = 260, 100

		enemyIcon:animate("girlfriend", false)

		self:load()
	end,

	load = function(self)
		weeks:load()

		zoom[1] = 1

		inst = nil
		voices = love.audio.newSource("songs/tutorial/inst.ogg", "stream")

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		weeks:generateNotes(love.filesystem.load("songs/tutorial/" .. difficulty .. ".lua")())
	end,

	update = function(self, dt)

		if settings.hitsounds then
			if input:pressed("gameDown") and not paused then
				audio.playSound(sounds.hitsounds.down)
			end
			if input:pressed("gameUp") and not paused then
				audio.playSound(sounds.hitsounds.up)
			end
			if input:pressed("gameLeft") and not paused then
				audio.playSound(sounds.hitsounds.left)
			end
			if input:pressed("gameRight") and not paused then
				audio.playSound(sounds.hitsounds.right)
			end
		end
		if paused then
			if input:pressed("gameDown") then
				if pauseMenuSelection == 4 then
					pauseMenuSelection = 1
				else
					pauseMenuSelection = pauseMenuSelection + 1
				end
			end

			if input:pressed("gameUp") and paused then
				if pauseMenuSelection == 1 then
					pauseMenuSelection = 4 
				else
					pauseMenuSelection = pauseMenuSelection - 1
				end
			end
		end

		if input:pressed("pause") and not countingDown then
			if not paused then
				pauseTime = musicTime
				paused = true
				love.audio.pause(voices)
			end
		end

		if paused then
			musicTime = pauseTime
			if input:pressed("confirm") and pauseMenuSelection == 1 then
				paused = false
				love.audio.play(voices)
			elseif input:pressed("confirm") and pauseMenuSelection == 2 then
				Gamestate.push(gameOver)
			elseif input:pressed("confirm") and pauseMenuSelection == 3 then
				paused = false
				if inst then inst:stop() end
				voices:stop()

				storyMode = false
			elseif input:pressed("confirm") and pauseMenuSelection == 4 then
				Gamestate.switch(menuSettings)
			end
		end

		currentSeconds = voices:tell("seconds") -- fuck you tutorial
		songLenth = voices:getDuration("seconds")
		timeLeft = songLenth - currentSeconds
		timeLeftFixed = math.floor(timeLeft)
		
		oldMusicThres = musicThres
		if countingDown or love.system.getOS() == "Web" then -- Source:tell() can't be trusted on love.js!
			musicTime = musicTime + 1000 * dt
		else
			if not graphics.isFading() then
				local time = love.timer.getTime()
				local seconds = voices:tell("seconds")

				musicTime = musicTime + (time * 1000) - previousFrameTime
				previousFrameTime = time * 1000

				if lastReportedPlaytime ~= seconds * 1000 then
					lastReportedPlaytime = seconds * 1000
					musicTime = (musicTime + lastReportedPlaytime) / 2
				end
			end
		end
		absMusicTime = math.abs(musicTime)
		musicThres = math.floor(absMusicTime / 100) -- Since "musicTime" isn't precise, this is needed

		for i = 1, #events do
			if events[i].eventTime <= musicTime then
				local oldBpm = bpm

				if events[i].bpm then
					bpm = events[i].bpm
					if not bpm then bpm = oldBpm end
				end

				if camTimer then
					Timer.cancel(camTimer)
				end
				if zoomTimer then
					Timer.cancel(zoomTimer)
				end
				if events[i].mustHitSection then
					camTimer = Timer.tween(1.25, cam, {x = -boyfriend.x + 100, y = -boyfriend.y + 75}, "out-quad")
					zoomTimer = Timer.tween(1.25, zoom, {1}, "in-bounce")
				else
					camTimer = Timer.tween(1.25, cam, {x = -girlfriend.x - 100, y = -girlfriend.y + 75}, "out-quad")
					zoomTimer = Timer.tween(1.25, zoom, {1.25}, "in-bounce")
				end

				table.remove(events, i)

				break
			end
		end

		if musicThres ~= oldMusicThres and math.fmod(absMusicTime, 240000 / bpm) < 100 then
			if camScaleTimer then Timer.cancel(camScaleTimer) end

			camScaleTimer = Timer.tween((60 / bpm) / 16, cam, {sizeX = camScale.x * 1.05, sizeY = camScale.y * 1.05}, "out-quad", function() camScaleTimer = Timer.tween((60 / bpm), cam, {sizeX = camScale.x, sizeY = camScale.y}, "out-quad") end)
		end

		girlfriend:update(dt)
		boyfriend:update(dt)
		upArrowSplash:update(dt)
		downArrowSplash:update(dt)
		leftArrowSplash:update(dt)
		rightArrowSplash:update(dt)

		if musicThres ~= oldMusicThres and math.fmod(absMusicTime, 120000 / bpm) < 100 then
			spriteTimers[1] = math.max(spriteTimers[1], spriteTimers[2]) -- Gross hack, but whatever

			if spriteTimers[1] == 0 then
				girlfriend:animate("idle", false)
			end
			if spriteTimers[3] == 0 then
				weeks:safeAnimate(boyfriend, "idle", false, 3)
			end

			girlfriend:setAnimSpeed(14.4 / (60 / bpm))
		end

		for i = 1, 3 do
			local spriteTimer = spriteTimers[i]

			if spriteTimer > 0 then
				spriteTimers[i] = spriteTimer - 1
			end
		end

		if musicThres ~= oldMusicThres and (musicThres == 185 or musicThres == 280) then
			weeks:safeAnimate(girlfriend, "cheer", false, 1)
			weeks:safeAnimate(boyfriend, "hey", false, 3)
		end

		if not (countingDown or graphics.isFading()) and not voices:isPlaying() and not paused then
			storyMode = false

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

		weeks:updateUI(dt)
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
			love.graphics.scale(cam.sizeX * zoom[1], cam.sizeY * zoom[1])

			love.graphics.push()
				love.graphics.translate(cam.x * 0.9, cam.y * 0.9)

				stageBack:draw()
				stageFront:draw()
				girlfriend:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)

				boyfriend:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 1.1, cam.y * 1.1)

				curtains:draw()
			love.graphics.pop()
			weeks:drawRating(0.9)
		love.graphics.pop()

		weeks:drawHealthBar()
		if not paused then
			weeks:drawUI()
		end
	end,

	leave = function(self)
		stageBack = nil
		stageFront = nil
		curtains = nil

		weeks:leave()
	end
}
