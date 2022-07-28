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

local animList = {
	"left",
	"down",
	"up",
	"right"
}
local inputList = {
	"gameLeft",
	"gameDown",
	"gameUp",
	"gameRight"
}

local missCounter = 0
local noteCounter = 0
local altScore = 0

local ratingTimers = {}

local useAltAnims
local notMissed = {}

return {
	enter = function(self)
		font = love.graphics.newFont("fonts/vcr.ttf", 24)

		--PAUSE MENU IMAGES
		resume = graphics.newImage(love.graphics.newImage(graphics.imagePath("pause/resume"))) -- USE THIS FUNCTION
		resumeH = graphics.newImage(love.graphics.newImage(graphics.imagePath("pause/resumeHover")))
		restart = graphics.newImage(love.graphics.newImage(graphics.imagePath("pause/restart")))
		restartH = graphics.newImage(love.graphics.newImage(graphics.imagePath("pause/restartHover")))
		exit = graphics.newImage(love.graphics.newImage(graphics.imagePath("pause/exit")))
		exitH = graphics.newImage(love.graphics.newImage(graphics.imagePath("pause/exitHover")))
		options = graphics.newImage(love.graphics.newImage(graphics.imagePath("pause/options")))
		optionsH = graphics.newImage(love.graphics.newImage(graphics.imagePath("pause/optionsHover")))
						
		resume.x, resume.y = 400, 120
		resumeH.x, resumeH.y = resume.x, resume.y
		restart.x, restart.y = 400, 295
		restartH.x, restartH.y = restart.x, restart.y 
		exit.x, exit.y = 400, 470
		exitH.x, exitH.y = exit.x, exit.y 
		options.x, options.y = 400, 645
		optionsH.x, optionsH.y = options.x, options.y
		sounds = {
			countdown = {
				three = love.audio.newSource("sounds/countdown-3.ogg", "static"),
				two = love.audio.newSource("sounds/countdown-2.ogg", "static"),
				one = love.audio.newSource("sounds/countdown-1.ogg", "static"),
				go = love.audio.newSource("sounds/countdown-go.ogg", "static")
			},
			miss = {
				love.audio.newSource("sounds/miss1.ogg", "static"),
				love.audio.newSource("sounds/miss2.ogg", "static"),
				love.audio.newSource("sounds/miss3.ogg", "static")
			},
			hitsounds = {
				love.audio.newSource("sounds/hitSound.ogg", "static")
			},
			death = love.audio.newSource("sounds/death.ogg", "static"),
			breakfast = love.audio.newSource("songs/misc/breakfast.ogg", "stream"),
			["text"] = love.audio.newSource("sounds/pixel/text.ogg", "static"),
			["continue"] = love.audio.newSource("sounds/pixel/continue-text.ogg", "static"),
		}

		images = {
			icons = love.graphics.newImage(graphics.imagePath("icons")),
			notes = love.graphics.newImage(graphics.imagePath(noteskins[settings.noteSkins])),
			notesplashes = love.graphics.newImage(graphics.imagePath("noteSplashes")),
			numbers = love.graphics.newImage(graphics.imagePath("numbers"))
		}

		sprites = {
			icons = love.filesystem.load("sprites/icons.lua"),
			numbers = love.filesystem.load("sprites/numbers.lua")
		}

		pauseVolume = {
			vol = 0
		}

		girlfriend = love.filesystem.load("sprites/girlfriend.lua")()
		boyfriend = love.filesystem.load("sprites/boyfriend.lua")()

		rating = love.filesystem.load("sprites/rating.lua")()

		rating.sizeX, rating.sizeY = 0.75, 0.75
		numbers = {}
		for i = 1, 3 do
			numbers[i] = sprites.numbers()

			numbers[i].sizeX, numbers[i].sizeY = 0.5, 0.5
		end

		enemyIcon = sprites.icons()
		boyfriendIcon = sprites.icons()

		if settings.downscroll then
			enemyIcon.y = -400
			boyfriendIcon.y = -400
		else
			enemyIcon.y = 350
			boyfriendIcon.y = 350
		end
		enemyIcon.sizeX, enemyIcon.sizeY = 1.5, 1.5
		boyfriendIcon.sizeX, boyfriendIcon.sizeY = -1.5, 1.5
		healthBarColorPlayer = {49,176,209}
		

		countdownFade = {}
		countdown = love.filesystem.load("sprites/countdown.lua")()

		function setDialogue(strList)
			dialogueList = strList
			curDialogue = 1
			timer = 0
			progress = 1
			output = ""
			isDone = false
		end
	end,

	load = function(self)
		missCounter = 0
		noteCounter = 0
		altScore = 0
		doingAnim = false -- for week 4 stuff
		hitSick = false
		paused = false
		pauseMenuSelection = 1
		
		for i = 1, 4 do
			notMissed[i] = true
		end
		useAltAnims = false

		cam.x, cam.y = -boyfriend.x + 100, -boyfriend.y + 75

		rating.x = girlfriend.x
		for i = 1, 3 do
			numbers[i].x = girlfriend.x - 100 + 50 * i
		end

		ratingVisibility = {0}
		combo = 0

		enemy:animate("idle")
		boyfriend:animate("idle")

		graphics.fadeIn(0.5)
	end,

	initUI = function(self)
		events = {}
		eventsP = {}
		enemyNotes = {}
		boyfriendNotes = {}
		picoNotes = {}
		health = 50
		score = 0
		missCounter = 0
		altScore = 0
		sicks = 0
		goods = 0
		bads = 0
		shits = 0
		hitCounter = 0

		local curInput = inputList[i]

		sprites.leftArrow = love.filesystem.load("sprites/notes/" .. noteskins[settings.noteSkins] .. "/left-arrow.lua")
		sprites.downArrow = love.filesystem.load("sprites/notes/" .. noteskins[settings.noteSkins] .. "/down-arrow.lua")
		sprites.upArrow = love.filesystem.load("sprites/notes/" .. noteskins[settings.noteSkins] .. "/up-arrow.lua")
		sprites.rightArrow = love.filesystem.load("sprites/notes/" .. noteskins[settings.noteSkins] .. "/right-arrow.lua")

		leftArrowSplash = love.filesystem.load("sprites/notes/noteSplashes.lua")()
		downArrowSplash = love.filesystem.load("sprites/notes/noteSplashes.lua")()
		upArrowSplash = love.filesystem.load("sprites/notes/noteSplashes.lua")()
		rightArrowSplash = love.filesystem.load("sprites/notes/noteSplashes.lua")()

		enemyArrows = {
			sprites.leftArrow(),
			sprites.downArrow(),
			sprites.upArrow(),
			sprites.rightArrow()
		}
		boyfriendArrows = {
			sprites.leftArrow(),
			sprites.downArrow(),
			sprites.upArrow(),
			sprites.rightArrow()
		}
		picoArrows = {
			sprites.leftArrow(),
			sprites.downArrow(),
			sprites.upArrow(),
			sprites.rightArrow()
		}

		for i = 1, 4 do
			if not settings.middleScroll then
				enemyArrows[i].x = -925 + 165 * i 
				boyfriendArrows[i].x = 100 + 165 * i 
				leftArrowSplash.x = 100 + 165 * 1 + 5
				downArrowSplash.x = 100 + 165 * 2 + 5
				upArrowSplash.x =  100 + 165 * 3 + 5
				rightArrowSplash.x = 100 + 165 * 4 + 5
			else
				boyfriendArrows[i].x = -410 + 165 * i
				-- ew stuff
				enemyArrows[1].x = -925 + 165 * 1 
				enemyArrows[2].x = -925 + 165 * 2
				enemyArrows[3].x = 100 + 165 * 3
				enemyArrows[4].x = 100 + 165 * 4
				leftArrowSplash.x = -440 + 165 * 1 + 5
				downArrowSplash.x = -440 + 165 * 2 + 5
				upArrowSplash.x =  -440 + 165 * 3 + 5
				rightArrowSplash.x = -440 + 165 * 4 + 5
			end
			if settings.downscroll then
				enemyArrows[i].y = 400
				boyfriendArrows[i].y = 400
				leftArrowSplash.y = 400
				downArrowSplash.y = 400
				upArrowSplash.y = 400
				rightArrowSplash.y = 400
			else
				enemyArrows[i].y = -400
				boyfriendArrows[i].y = -400
				leftArrowSplash.y = -400
				downArrowSplash.y = -400
				upArrowSplash.y = -400
				rightArrowSplash.y = -400
			end

			enemyNotes[i] = {}
			boyfriendNotes[i] = {}
			picoNotes[i] = {}
		end
	end,

	generatePicoNotes = function(self, chartP)

		for i = 1, #chartP do
			for j = 1, #chartP[i].sectionNotes do
				local spriteP

				local mustHitSectionP = chartP[i].mustHitSection
				local altAnimP = chartP[i].altAnim
				local noteTypeP = chartP[i].sectionNotes[j].noteType
				local noteTimeP = chartP[i].sectionNotes[j].noteTime

				if j == 1 then
					table.insert(
						eventsP, 
						{
							eventTime = chartP[i].sectionNotes[1].noteTime, 
							mustHitSection = mustHitSection, 
							altAnim = altAnimP
						}
					)
				end

				if noteTypeP == 0 or noteTypeP == 4 then
					spriteP = sprites.leftArrow
				elseif noteTypeP == 1 or noteTypeP == 5 then
					spriteP = sprites.downArrow
				elseif noteTypeP == 2 or noteTypeP == 6 then
					spriteP = sprites.upArrow
				elseif noteTypeP == 3 or noteTypeP == 7 then
					spriteP = sprites.rightArrow
				end

				local id = noteTypeP + 1
				local c = #picoNotes[id] + 1
				local x = picoNotes[id].x

				table.insert(picoNotes[id], spriteP())
				picoNotes[id][c].x = x
				picoNotes[id][c].y = 400 - noteTimeP * 0.6 * speed

				picoNotes[id][c]:animate("on", false)

				if chartP[i].sectionNotes[j].noteLength > 0 then
					local c

					for k = 71 / speed, chartP[i].sectionNotes[j].noteLength, 71 / speed do
						local c = #picoNotes[id] + 1

						table.insert(picoNotes[id], spriteP())
						picoNotes[id][c].x = x
						picoNotes[id][c].y = 400 - (noteTimeP + k) * 0.6 * speed

						picoNotes[id][c]:animate("hold", false)
					end

					c = #picoNotes[id]
					picoNotes[id][c].offsetY = 10
					picoNotes[id][c].sizeY = -1

					picoNotes[id][c]:animate("end", false)
				end
			end
		end
	end,

	generateNotes = function(self, chart)
		local eventBpm

		for i = 1, #chart do
			bpm = chart[i].bpm

			if bpm then
				break
			end
		end
		if not bpm then
			bpm = 100
		end

		if settings.customScrollSpeed == 1 then
			speed = chart.speed
		else
			speed = settings.customScrollSpeed
		end
		songName = chart.songName
		needsVoices = chart.needsVoices

		for i = 1, #chart do
			eventBpm = chart[i].bpm

			for j = 1, #chart[i].sectionNotes do
				local sprite

				local mustHitSection = chart[i].mustHitSection
				local altAnim = chart[i].altAnim
				local noteType = chart[i].sectionNotes[j].noteType
				local noteTime = chart[i].sectionNotes[j].noteTime

				if j == 1 then
					table.insert(events, {eventTime = chart[i].sectionNotes[1].noteTime, mustHitSection = mustHitSection, bpm = eventBpm, altAnim = altAnim})
				end

				if noteType == 0 or noteType == 4 then
					sprite = sprites.leftArrow
				elseif noteType == 1 or noteType == 5 then
					sprite = sprites.downArrow
				elseif noteType == 2 or noteType == 6 then
					sprite = sprites.upArrow
				elseif noteType == 3 or noteType == 7 then
					sprite = sprites.rightArrow
				end

					if settings.downscroll then
						if mustHitSection then
							if noteType >= 4 then
								local id = noteType - 3
								local c = #enemyNotes[id] + 1
								local x = enemyArrows[id].x

								table.insert(enemyNotes[id], sprite())
								enemyNotes[id][c].x = x
								enemyNotes[id][c].y = 400 - noteTime * 0.6 * speed

								enemyNotes[id][c]:animate("on", false)

								if chart[i].sectionNotes[j].noteLength > 0 then
									local c

									for k = 71 / speed, chart[i].sectionNotes[j].noteLength, 71 / speed do
										local c = #enemyNotes[id] + 1

										table.insert(enemyNotes[id], sprite())
										enemyNotes[id][c].x = x
										enemyNotes[id][c].y = 400 - (noteTime + k) * 0.6 * speed

										enemyNotes[id][c]:animate("hold", false)
									end

									c = #enemyNotes[id]
									enemyNotes[id][c].offsetY = 10
									enemyNotes[id][c].sizeY = -1

									enemyNotes[id][c]:animate("end", false)
								end
							else
								local id = noteType + 1
								local c = #boyfriendNotes[id] + 1
								local x = boyfriendArrows[id].x

								table.insert(boyfriendNotes[id], sprite())
								boyfriendNotes[id][c].x = x
								boyfriendNotes[id][c].y = 400 - noteTime * 0.6 * speed

								boyfriendNotes[id][c]:animate("on", false)

								if chart[i].sectionNotes[j].noteLength > 0 then
									local c

									for k = 71 / speed, chart[i].sectionNotes[j].noteLength, 71 / speed do
											local c = #boyfriendNotes[id] + 1

											table.insert(boyfriendNotes[id], sprite())
											boyfriendNotes[id][c].x = x
											boyfriendNotes[id][c].y = 400 - (noteTime + k) * 0.6 * speed

											boyfriendNotes[id][c]:animate("hold", false)
										end

									c = #boyfriendNotes[id]

									boyfriendNotes[id][c].offsetY = 10
									boyfriendNotes[id][c].sizeY = -1
									

									boyfriendNotes[id][c]:animate("end", false)
								end
							end
						else
							if noteType >= 4 then
								local id = noteType - 3
								local c = #boyfriendNotes[id] + 1
								local x = boyfriendArrows[id].x

								table.insert(boyfriendNotes[id], sprite())
								boyfriendNotes[id][c].x = x
								boyfriendNotes[id][c].y = 400 - noteTime * 0.6 * speed

								boyfriendNotes[id][c]:animate("on", false)

								if chart[i].sectionNotes[j].noteLength > 0 then
									local c

									for k = 71 / speed, chart[i].sectionNotes[j].noteLength, 71 / speed do
											local c = #boyfriendNotes[id] + 1

											table.insert(boyfriendNotes[id], sprite())
											boyfriendNotes[id][c].x = x
											boyfriendNotes[id][c].y = 400 - (noteTime + k) * 0.6 * speed

											boyfriendNotes[id][c]:animate("hold", false)
										end

									c = #boyfriendNotes[id]

									boyfriendNotes[id][c].offsetY = 10
									boyfriendNotes[id][c].sizeY = -1

									boyfriendNotes[id][c]:animate("end", false)
								end
							else
								local id = noteType + 1
								local c = #enemyNotes[id] + 1
								local x = enemyArrows[id].x

								table.insert(enemyNotes[id], sprite())
								enemyNotes[id][c].x = x
								enemyNotes[id][c].y = 400 - noteTime * 0.6 * speed

								enemyNotes[id][c]:animate("on", false)

								if chart[i].sectionNotes[j].noteLength > 0 then
									local c

									for k = 71 / speed, chart[i].sectionNotes[j].noteLength, 71 / speed do
											local c = #enemyNotes[id] + 1

											table.insert(enemyNotes[id], sprite())
											enemyNotes[id][c].x = x
											enemyNotes[id][c].y = 400 - (noteTime + k) * 0.6 * speed

											enemyNotes[id][c]:animate("hold", false)
										end

									c = #enemyNotes[id]


									enemyNotes[id][c].offsetY = 10
									enemyNotes[id][c].sizeY = -1
									

									enemyNotes[id][c]:animate("end", false)
								end
							end
						end
					else
						if mustHitSection then
							if noteType >= 4 then
								local id = noteType - 3
								local c = #enemyNotes[id] + 1
								local x = enemyArrows[id].x

								table.insert(enemyNotes[id], sprite())
								enemyNotes[id][c].x = x
								enemyNotes[id][c].y = -400 + noteTime * 0.6 * speed

								enemyNotes[id][c]:animate("on", false)

									if chart[i].sectionNotes[j].noteLength > 0 then
										local c

										for k = 71 / speed, chart[i].sectionNotes[j].noteLength, 71 / speed do
											local c = #enemyNotes[id] + 1

											table.insert(enemyNotes[id], sprite())
											enemyNotes[id][c].x = x
											enemyNotes[id][c].y = -400 + (noteTime + k) * 0.6 * speed

											enemyNotes[id][c]:animate("hold", false)
										end

										c = #enemyNotes[id]

										enemyNotes[id][c].offsetY = 10

										enemyNotes[id][c]:animate("end", false)
									end
							else
								local id = noteType + 1
								local c = #boyfriendNotes[id] + 1
								local x = boyfriendArrows[id].x

								table.insert(boyfriendNotes[id], sprite())
								boyfriendNotes[id][c].x = x
								boyfriendNotes[id][c].y = -400 + noteTime * 0.6 * speed

								boyfriendNotes[id][c]:animate("on", false)

									if chart[i].sectionNotes[j].noteLength > 0 then
										local c

										for k = 71 / speed, chart[i].sectionNotes[j].noteLength, 71 / speed do
											local c = #boyfriendNotes[id] + 1

											table.insert(boyfriendNotes[id], sprite())
											boyfriendNotes[id][c].x = x
											boyfriendNotes[id][c].y = -400 + (noteTime + k) * 0.6 * speed

											boyfriendNotes[id][c]:animate("hold", false)
										end

										c = #boyfriendNotes[id]

										boyfriendNotes[id][c].offsetY = 10

										boyfriendNotes[id][c]:animate("end", false)
									end
								
							end
						else
							if noteType >= 4 then
								local id = noteType - 3
								local c = #boyfriendNotes[id] + 1
								local x = boyfriendArrows[id].x

								table.insert(boyfriendNotes[id], sprite())
								boyfriendNotes[id][c].x = x
								boyfriendNotes[id][c].y = -400 + noteTime * 0.6 * speed
								

								boyfriendNotes[id][c]:animate("on", false)

									if chart[i].sectionNotes[j].noteLength > 0 then
										local c

										for k = 71 / speed, chart[i].sectionNotes[j].noteLength, 71 / speed do
											local c = #boyfriendNotes[id] + 1

											table.insert(boyfriendNotes[id], sprite())
											boyfriendNotes[id][c].x = x
											boyfriendNotes[id][c].y = -400 + (noteTime + k) * 0.6 * speed

											boyfriendNotes[id][c]:animate("hold", false)
										end

										c = #boyfriendNotes[id]

										boyfriendNotes[id][c].offsetY = 10

										boyfriendNotes[id][c]:animate("end", false)
									end
							else
								local id = noteType + 1
								local c = #enemyNotes[id] + 1
								local x = enemyArrows[id].x

								table.insert(enemyNotes[id], sprite())
								enemyNotes[id][c].x = x
								enemyNotes[id][c].y = -400 + noteTime * 0.6 * speed

								enemyNotes[id][c]:animate("on", false)

									if chart[i].sectionNotes[j].noteLength > 0 then
										local c

										for k = 71 / speed, chart[i].sectionNotes[j].noteLength, 71 / speed do
											local c = #enemyNotes[id] + 1

											table.insert(enemyNotes[id], sprite())
											enemyNotes[id][c].x = x
											enemyNotes[id][c].y = -400 + (noteTime + k) * 0.6 * speed
											if k > chart[i].sectionNotes[j].noteLength - 71 / speed then
												enemyNotes[id][c].offsetY = 10

												enemyNotes[id][c]:animate("end", false)
											else
												enemyNotes[id][c]:animate("hold", false)
											end
										end

										c = #enemyNotes[id]

										enemyNotes[id][c].offsetY = 10

										enemyNotes[id][c]:animate("end", false)
									end
							end
						end
					end
			end
		end

		if settings.downscroll then
			for i = 1, 4 do
				table.sort(enemyNotes[i], function(a, b) return a.y > b.y end)
				table.sort(boyfriendNotes[i], function(a, b) return a.y > b.y end)
			end
		else
			for i = 1, 4 do
				table.sort(enemyNotes[i], function(a, b) return a.y < b.y end)
				table.sort(boyfriendNotes[i], function(a, b) return a.y < b.y end)
			end
		end

		-- Workarounds for bad charts that have multiple notes around the same place
		for i = 1, 4 do
			local offset = 0

			for j = 2, #enemyNotes[i] do
				local index = j - offset

				if enemyNotes[i][index]:getAnimName() == "on" and enemyNotes[i][index - 1]:getAnimName() == "on" and ((not settings.downscroll and enemyNotes[i][index].y - enemyNotes[i][index - 1].y <= 10) or (settings.downscroll and enemyNotes[i][index].y - enemyNotes[i][index - 1].y >= -10)) then
					table.remove(enemyNotes[i], index)

					offset = offset + 1
				end
			end
		end
		for i = 1, 4 do
			local offset = 0

			for j = 2, #boyfriendNotes[i] do
				local index = j - offset

				if boyfriendNotes[i][index]:getAnimName() == "on" and boyfriendNotes[i][index - 1]:getAnimName() == "on" and ((not settings.downscroll and boyfriendNotes[i][index].y - boyfriendNotes[i][index - 1].y <= 10) or (settings.downscroll and boyfriendNotes[i][index].y - boyfriendNotes[i][index - 1].y >= -10)) then
					table.remove(boyfriendNotes[i], index)

					offset = offset + 1
				end
			end
		end
	end,

	doDialogue = function(dt)
		local fullDialogue = dialogueList[curDialogue]
		
		timer = timer + 0.75 * love.timer.getDelta()
		
		if timer >= 0.05 then
			if progress < string.len(fullDialogue) then
				sounds["text"]:play()

				progress = progress + 1

				output = string.sub(fullDialogue, 1, math.floor(progress))

				timer = 0
			else
				timer = 0
			end
		end
	end,

	advanceDialogue = function()
		local fullDialogue = dialogueList[curDialogue]

		if progress < string.len(fullDialogue) then
			progress = string.len(fullDialogue)
			output = string.sub(fullDialogue, 1, math.floor(progress))
		else
			if curDialogue < #dialogueList then
				sounds["continue"]:play()
				
				curDialogue = curDialogue + 1
				timer = 0
				progress = 1
				output = ""
			else
				sounds["continue"]:play()

				isDone = true
			end
		end
	end,

	-- Gross countdown script
	setupCountdown = function(self)
		lastReportedPlaytime = 0
		musicTime = (240 / bpm) * -1000

		musicThres = 0
		musicPos = 0

		countingDown = true
		countdownFade[1] = 0
		audio.playSound(sounds.countdown.three)
		Timer.after(
			(60 / bpm),
			function()
				countdown:animate("ready")
				countdownFade[1] = 1
				audio.playSound(sounds.countdown.two)
				Timer.tween(
					(60 / bpm),
					countdownFade,
					{0},
					"linear",
					function()
						countdown:animate("set")
						countdownFade[1] = 1
						audio.playSound(sounds.countdown.one)
						Timer.tween(
							(60 / bpm),
							countdownFade,
							{0},
							"linear",
							function()
								countdown:animate("go")
								countdownFade[1] = 1
								audio.playSound(sounds.countdown.go)
								Timer.tween(
									(60 / bpm),
									countdownFade,
									{0},
									"linear",
									function()
										countingDown = false

										previousFrameTime = love.timer.getTime() * 1000
										musicTime = 0

										voices:setVolume(settings.vocalsVol)
										if inst then 
											inst:setVolume(settings.instVol)
											inst:play() 
										end
										voices:play()
									end
								)
							end
						)
					end
				)
			end
		)
	end,

	safeAnimate = function(self, sprite, animName, loopAnim, timerID)
		sprite:animate(animName, loopAnim)

		spriteTimers[timerID] = 12
	end,

	update = function(self, dt)

		hitCounter = (sicks + goods + bads + shits)

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


        function tweenPauseButtons()
			if week ~= 5 then
				resume.x, resume.y = -1000, 120
				resumeH.x, resumeH.y = resume.x, resume.y
				restart.x, restart.y = -1000, 295
				restartH.x, restartH.y = restart.x, restart.y 
				exit.x, exit.y = -1000, 470
				exitH.x, exitH.y = exit.x, exit.y 
				options.x, options.y = -1000, 645
				optionsH.x, optionsH.y = options.x, options.y


				if resume.x == -1000 then
					Timer.tween(1, resume, {x = 550}, "out-back")
				end
				if resumeH.x == -1000 then
					Timer.tween(1, resumeH, {x = 550}, "out-back")
				end
				if restart.x == -1000 then
					Timer.tween(1.2, restart, {x = 500}, "out-back")
				end
				if restartH.x == -1000 then
					Timer.tween(1.2, restartH, {x = 500}, "out-back")
				end
				if exit.x == -1000 then
					Timer.tween(1.4, exit, {x = 450}, "out-back")
				end
				if exitH.x == -1000 then
					Timer.tween(1.4, exitH, {x = 450}, "out-back")
				end
				if options.x == -1000 then
					Timer.tween(1.6, options, {x = 400}, "out-back")
				end
				if optionsH.x == -1000 then
					Timer.tween(1.6, optionsH, {x = 400}, "out-back")
				end
			else
				resume.x, resume.y = -2500, 120 - 900
				resumeH.x, resumeH.y = resume.x, resume.y
				restart.x, restart.y = -2500, 295 - 900
				restartH.x, restartH.y = restart.x, restart.y 
				exit.x, exit.y = -2500, 470 - 900
				exitH.x, exitH.y = exit.x, exit.y 
				options.x, options.y = -2500, 645 - 900
				optionsH.x, optionsH.y = options.x, options.y


				if resume.x == -2500 then
					Timer.tween(1, resume, {x = -1750}, "out-back")
				end
				if resumeH.x == -2500 then
					Timer.tween(1, resumeH, {x = -1750}, "out-back")
				end
				if restart.x == -2500 then
					Timer.tween(1.2, restart, {x = -1700}, "out-back")
				end
				if restartH.x == -2500 then
					Timer.tween(1.2, restartH, {x = -1700}, "out-back")
				end
				if exit.x == -2500 then
					Timer.tween(1.4, exit, {x = -1650}, "out-back")
				end
				if exitH.x == -2500 then
					Timer.tween(1.4, exitH, {x = -1650}, "out-back")
				end
				if options.x == -2500 then
					Timer.tween(1.6, options, {x = -1600}, "out-back")
				end
				if optionsH.x == -2500 then
					Timer.tween(1.6, optionsH, {x = -1600}, "out-back")
				end
			end
        end

		currentSeconds = voices:tell("seconds")
		songLenth = voices:getDuration("seconds")
		timeLeft = songLenth - currentSeconds
		timeLeftFixed = math.floor(timeLeft)

		if input:pressed("pause") and not countingDown then
			if not paused then
				pauseTime = musicTime
				paused = true
				love.audio.pause(inst, voices)
				tweenPauseButtons()
				love.audio.play(sounds.breakfast)
			end
		end

		if paused then
			musicTime = pauseTime
			if input:pressed("confirm") and pauseMenuSelection == 1 then -- resume button
				paused = false
				love.audio.play(inst, voices)
			elseif input:pressed("confirm") and pauseMenuSelection == 2 then -- restart button 
				pauseRestart = true
				Gamestate.push(gameOver)
			elseif input:pressed("confirm") and pauseMenuSelection == 3 then --  exit button 
				paused = false
				if inst then inst:stop() end
				voices:stop()
				storyMode = false
			elseif input:pressed("confirm") and pauseMenuSelection == 4 then -- options button
				Gamestate.switch(menuSettings)
			end
		else
			love.audio.stop(sounds.breakfast)
		end

		if not doingDialogue and not cutscene and not video:isPlaying() then
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

			if settings.botPlay then
				hitSick = true
			end
			
			absMusicTime = math.abs(musicTime)
			musicThres = math.floor(absMusicTime / 100) -- Since "musicTime" isn't precise, this is needed

			for i = 1, #events do
				if events[i].eventTime <= absMusicTime then
					local oldBpm = bpm

					if events[i].bpm then
						bpm = events[i].bpm
						if not bpm then bpm = oldBpm end
					end

					if camTimer then
						Timer.cancel(camTimer)
					end
					if events[i].mustHitSection then
						camTimer = Timer.tween(1.25, cam, {x = -boyfriend.x + 100, y = -boyfriend.y + 75}, "out-quad")
					else
						camTimer = Timer.tween(1.25, cam, {x = -enemy.x - 100, y = -enemy.y + 75}, "out-quad")
					end

					if events[i].altAnim then
						useAltAnims = true
					else
						useAltAnims = false
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
			enemy:update(dt)
			boyfriend:update(dt)
			picoSpeaker:update(dt)
			leftArrowSplash:update(dt)
			rightArrowSplash:update(dt)
			upArrowSplash:update(dt)
			downArrowSplash:update(dt)

			if musicThres ~= oldMusicThres and math.fmod(absMusicTime, 120000 / bpm) < 100 then
				if spriteTimers[1] == 0 then
					girlfriend:animate("idle", false)
					picoSpeaker:animate("idle", false)
	
					girlfriend:setAnimSpeed(14.4 / (60 / bpm))
					picoSpeaker:setAnimSpeed(14.4 / (60 / bpm))
				end
				if spriteTimers[2] == 0 then
					if enemy:getAnimName() ~= "good" or (enemy:getAnimName() == "good" and not enemy:isAnimated()) then
						self:safeAnimate(enemy, "idle", false, 2)
					end
				end
				if spriteTimers[3] == 0 then
					self:safeAnimate(boyfriend, "idle", false, 3)
				end
			end

			for i = 1, 3 do
				local spriteTimer = spriteTimers[i]

				if spriteTimer > 0 then
					spriteTimers[i] = spriteTimer - 1
				end
			end
		end
	end,

	updateUI = function(self, dt)
		if not paused then
			if not doingDialogue and not cutscene and not video:isPlaying() then
				if settings.downscroll then
					musicPos = -musicTime * 0.6 * speed
				else
					musicPos = musicTime * 0.6 * speed
				end

				for i = 1, 4 do
					local enemyArrow = enemyArrows[i]
					local boyfriendArrow = boyfriendArrows[i]
					local picoArrow = picoArrows[i]
					local enemyNote = enemyNotes[i]
					local picoNote = picoNotes[i]
					local boyfriendNote = boyfriendNotes[i]
					local curAnim = animList[i]
					local curInput = inputList[i]

					local noteNum = i

					enemyArrow:update(dt)
					boyfriendArrow:update(dt)

					if not enemyArrow:isAnimated() then
						enemyArrow:animate("off", false)
					end
					if settings.botPlay then
						if not boyfriendArrow:isAnimated() then
							boyfriendArrow:animate("off", false)
						end
					end

					if #enemyNote > 0 then
						if (not settings.downscroll and enemyNote[1].y - musicPos <= -400) or (settings.downscroll and enemyNote[1].y - musicPos >= 400) then
							voices:setVolume(1)

							enemyArrow:animate("confirm", false)

							if enemyNote[1]:getAnimName() == "hold" or enemyNote[1]:getAnimName() == "end" then
								if useAltAnims then
									if (not enemy:isAnimated()) or enemy:getAnimName() == "idle" then self:safeAnimate(enemy, curAnim .. " alt", true, 2) end
								else
									if (not enemy:isAnimated()) or enemy:getAnimName() == "idle" then self:safeAnimate(enemy, curAnim, true, 2) end
								end
							else
								if useAltAnims then
									self:safeAnimate(enemy, curAnim .. " alt", false, 2)
								else
									self:safeAnimate(enemy, curAnim, false, 2)
								end
							end

							table.remove(enemyNote, 1)
						end
					end
					if #picoNote > 0 then
						if (not settings.downscroll and picoNote[1].y - musicPos <= -400) or (settings.downscroll and picoNote[1].y - musicPos >= 400) then
							voices:setVolume(1)

							picoArrow:animate("confirm", false)

							if picoNote[1]:getAnimName() == "hold" or picoNote[1]:getAnimName() == "end" then
								if (not picoSpeaker:isAnimated()) or picoSpeaker:getAnimName() == "idle" then self:safeAnimate(picoSpeaker, curAnim, true, 2) end
							else
								self:safeAnimate(picoSpeaker, curAnim, false, 2)
							end

							table.remove(picoNote, 1)
						end
					end

					if #boyfriendNote > 0 then
						if not countingDown then
							if (not settings.downscroll and boyfriendNote[1].y - musicPos < -500) or (settings.downscroll and boyfriendNote[1].y - musicPos > 500) then
								if not settings.botPlay then
									if inst then voices:setVolume(0) end

									notMissed[noteNum] = false

									table.remove(boyfriendNote, 1)

									if girlfriend:isAnimName("sad") then if combo >= 5 then self:safeAnimate(girlfriend, "sad", true, 1) end end

									hitSick = false

									combo = 0
									if not settings.noMiss then
										health = health - 2
									else
										health = 0
									end

									missCounter = missCounter + 1
								end
							end
						end
					end

					if not settings.botPlay then
						if input:down(curInput) then
							holdingInput = true
						else
							holdingInput = false
						end

						if input:pressed(curInput) then
							if settings.hitsounds then
								if sounds.hitsounds[#sounds.hitsounds]:isPlaying() then
									sounds.hitsounds[#sounds.hitsounds] = sounds.hitsounds[#sounds.hitsounds]:clone()
									sounds.hitsounds[#sounds.hitsounds]:play()
								else
									sounds.hitsounds[#sounds.hitsounds]:play()
								end
								for hit = 2, #sounds.hitsounds do
									if not sounds.hitsounds[hit]:isPlaying() then
										sounds.hitsounds[hit] = nil -- Nil afterwords to prevent memory leak
									end --                             maybe, idk how love2d works lmfao
								end
							end
							local success = false

							if settings.ghostTapping then
								success = true
								hitSick = false
							end

							boyfriendArrow:animate("press", false)

							if #boyfriendNote > 0 then
								for i = 1, #boyfriendNote do
									if boyfriendNote[i] and boyfriendNote[i]:getAnimName() == "on" then
										if (not settings.downscroll and boyfriendNote[i].y - musicPos <= -280) or (settings.downscroll and boyfriendNote[i].y - musicPos >= 280) then
											local notePos
											local ratingAnim

											notMissed[noteNum] = true

											if settings.downscroll then
												notePos = math.abs(400 - (boyfriendNote[i].y - musicPos))
											else
												notePos = math.abs(-400 - (boyfriendNote[i].y - musicPos))
											end

											voices:setVolume(1)

											if notePos <= 18 then -- "Sick Plus" Note: Just for a cooler looking rating. Does not give anything special
												score = score + 350
												ratingAnim = "sickPlus"
												altScore = altScore + 100.00
												sicks = sicks + 1
												hitSick = true
											elseif notePos <= 38 then -- "Sick"
												score = score + 350
												ratingAnim = "sick"
												altScore = altScore + 100.00
												sicks = sicks + 1
												hitSick = true
											elseif notePos <= 78 then -- "Good"
												score = score + 200
												ratingAnim = "good"
												altScore = altScore + 66.66
												goods = goods + 1
												hitSick = false
											elseif notePos <= 98 then -- "Bad"
												score = score + 100
												ratingAnim = "bad"
												altScore = altScore + 33.33
												bads = bads + 1
												hitSick = false
											else -- "Shit"
												if settings.ghostTapping then
													success = false
												else
													score = score + 50
												end
												altScore = altScore + 1.11
												ratingAnim = "shit"
												shits = shits + 1
												hitSick = false
											end

											combo = combo + 1

											rating:animate(ratingAnim, false)
											numbers[1]:animate(tostring(math.floor(combo / 100 % 10), false)) -- 100's
											numbers[2]:animate(tostring(math.floor(combo / 10 % 10), false)) -- 10's
											numbers[3]:animate(tostring(math.floor(combo % 10), false)) -- 1's

											for i = 1, 5 do
												if ratingTimers[i] then Timer.cancel(ratingTimers[i]) end
											end

											ratingVisibility[1] = 1
											rating.y = girlfriend.y - 50
											for i = 1, 3 do
												numbers[i].y = girlfriend.y + 50
											end

											ratingTimers[1] = Timer.tween(2, ratingVisibility, {0})
											ratingTimers[2] = Timer.tween(2, rating, {y = girlfriend.y - 100}, "out-elastic")
											if combo >= 100 then
												ratingTimers[3] = Timer.tween(2, numbers[1], {y = girlfriend.y + love.math.random(-10, 10)}, "out-elastic") -- 100's
											end
											if combo >= 10 then
												ratingTimers[4] = Timer.tween(2, numbers[2], {y = girlfriend.y + love.math.random(-10, 10)}, "out-elastic") -- 10's
											end
											ratingTimers[5] = Timer.tween(2, numbers[3], {y = girlfriend.y + love.math.random(-10, 10)}, "out-elastic") -- 1's

											table.remove(boyfriendNote, i)

											if not settings.ghostTapping or success then
												boyfriendArrow:animate("confirm", false)

												self:safeAnimate(boyfriend, curAnim, false, 3)
												doingAnim = false

												health = health + 1
												noteCounter = noteCounter + 1

												success = true
											end
										else
											break
										end
									end
								end
							end

							if not success then
								if not countingDown then
									if not settings.botPlay then
										audio.playSound(sounds.miss[love.math.random(3)])

										notMissed[noteNum] = false

										if girlfriend:isAnimName("sad") then if combo >= 5 then self:safeAnimate(girlfriend, "sad", true, 1) end end

										self:safeAnimate(boyfriend, "miss " .. curAnim, false, 3)

										hitSick = false

										score = score - 10
										combo = 0
										if not settings.noMiss then
											health = health - 2
										else
											health = 0
										end
										missCounter = missCounter + 1
									end
								end
							end
						end
					end

					if not settings.botPlay then
						if notMissed[noteNum] and #boyfriendNote > 0 and input:down(curInput) and ((not settings.downscroll and boyfriendNote[1].y - musicPos <= -400) or (settings.downscroll and boyfriendNote[1].y - musicPos >= 400)) and (boyfriendNote[1]:getAnimName() == "hold" or boyfriendNote[1]:getAnimName() == "end") then
							voices:setVolume(1)

							table.remove(boyfriendNote, 1)

							boyfriendArrow:animate("confirm", false)

							if (not boyfriend:isAnimated()) or boyfriend:getAnimName() == "idle" then self:safeAnimate(boyfriend, curAnim, true, 3) end

							health = health + 1
						end

						if input:released(curInput) then
							boyfriendArrow:animate("off", false)
						end
					else
						if #boyfriendNote > 0 and ((not settings.downscroll and boyfriendNote[1].y - musicPos <= -400) or (settings.downscroll and boyfriendNote[1].y - musicPos >= 400)) then
							voices:setVolume(1)

							boyfriendArrow:animate("confirm", false)

							if boyfriendNote[1]:getAnimName() == "hold" or boyfriendNote[1]:getAnimName() == "end" then
								if (not boyfriend:isAnimated()) or boyfriend:getAnimName() == "idle" then self:safeAnimate(boyfriend, curAnim, true, 2) end
							else
								self:safeAnimate(boyfriend, curAnim, false, 2)
							end

							table.remove(boyfriendNote, 1)
						end
					end
				end

				if health > 100 then
					health = 100
				elseif health > 20 and boyfriendIcon:getAnimName() == "boyfriend losing" then
					boyfriendIcon:animate("boyfriend", false)
				elseif health <= 0 then -- Game over
					health = 0
					if not settings.practiceMode then
						Gamestate.push(gameOver)
					end
				elseif health <= 20 and boyfriendIcon:getAnimName() == "boyfriend" then
					boyfriendIcon:animate("boyfriend losing", false)
				end

				enemyIcon.x = 425 - health * 10
				boyfriendIcon.x = 585 - health * 10

				if not countingDown then
					if musicThres ~= oldMusicThres and math.fmod(absMusicTime, 60000 / bpm) < 100 then
						if enemyIconTimer then Timer.cancel(enemyIconTimer) end
						if boyfriendIconTimer then Timer.cancel(boyfriendIconTimer) end

						enemyIconTimer = Timer.tween((60 / bpm) / 16, enemyIcon, {sizeX = 1.75, sizeY = 1.75}, "out-quad", function() enemyIconTimer = Timer.tween((60 / bpm), enemyIcon, {sizeX = 1.5, sizeY = 1.5}, "out-quad") end)
						boyfriendIconTimer = Timer.tween((60 / bpm) / 16, boyfriendIcon, {sizeX = -1.75, sizeY = 1.75}, "out-quad", function() boyfriendIconTimer = Timer.tween((60 / bpm), boyfriendIcon, {sizeX = -1.5, sizeY = 1.5}, "out-quad") end)
					end
				end

				if not countingDown and input:pressed("gameBack") then
					if inst then inst:stop() end
					voices:stop()

					storyMode = false
				end
			end
		end
	end,

	drawRating = function(self, multiplier)
		love.graphics.push()
			if multiplier then
				love.graphics.translate(cam.x * multiplier, cam.y * multiplier)
			else
				love.graphics.translate(cam.x, cam.y)
			end

			graphics.setColor(1, 1, 1, ratingVisibility[1])
				rating:draw()
				if combo >= 100 then
					numbers[1]:draw()
				end
				if combo >= 10 then
					numbers[2]:draw()
				end
				numbers[3]:draw()
			graphics.setColor(1, 1, 1)
		love.graphics.pop()
	end,

	drawUI = function(self)
		love.graphics.push()
			love.graphics.translate(lovesize.getWidth() / 2, lovesize.getHeight() / 2)
			love.graphics.scale(0.7, 0.7)

			for i = 1, 4 do
				if enemyArrows[i]:getAnimName() == "off" then
					graphics.setColor(0.6, 0.6, 0.6)
				end
				if settings.middleScroll then
					if paused then 
						love.graphics.setColor(0.6,0.6,0.6,0.3)
					else
						love.graphics.setColor(0.6,0.6,0.6,0.3)
					end
				else
					if paused then 
						love.graphics.setColor(0.6,0.6,0.6,0.3)
					else
						love.graphics.setColor(1,1,1)
					end
				end
				
				enemyArrows[i]:draw()--ate
				if paused then 
					love.graphics.setColor(0.6,0.6,0.6,0.3)
				else
					love.graphics.setColor(1, 1, 1, 1)
				end
				boyfriendArrows[i]:draw()
				if hitSick then
					if not settings.botPlay then
						if input:pressed("gameLeft") then
							leftArrowSplash:animate("left")
						elseif input:pressed("gameRight") then
							rightArrowSplash:animate("right")
						elseif input:pressed("gameUp") then
							upArrowSplash:animate("up")
						elseif input:pressed("gameDown") then
							downArrowSplash:animate("down")
						end
					else
						if boyfriendArrows[1]:getAnimName() == "confirm" then
							if wasReleased1 then
								leftArrowSplash:animate("left")
								wasReleased1 = false
							end
						end
						if boyfriendArrows[2]:getAnimName() == "confirm" then
							if wasReleased2 then
								downArrowSplash:animate("down")
								wasReleased2 = false
							end
						end
						if boyfriendArrows[3]:getAnimName() == "confirm" then
							if wasReleased3 then
								upArrowSplash:animate("up")
								wasReleased3 = false
							end
						end
						if boyfriendArrows[4]:getAnimName() == "confirm" then
							if wasReleased4 then
								rightArrowSplash:animate("right")
								wasReleased4 = false
							end
						end
					end
				end
				if settings.botPlay then
					if boyfriendArrows[1]:getAnimName() ~= "confirm" then
						wasReleased1 = true
					end
					if boyfriendArrows[2]:getAnimName() ~= "confirm" then
						wasReleased2 = true
					end
					if boyfriendArrows[3]:getAnimName() ~= "confirm" then
						wasReleased3 = true
					end
					if boyfriendArrows[4]:getAnimName() ~= "confirm" then
						wasReleased4 = true
					end
				end
				
				if not paused then
						if leftArrowSplash:isAnimated() then
							leftArrowSplash:draw()
						end
						if rightArrowSplash:isAnimated() then
							rightArrowSplash:draw()
						end
						if upArrowSplash:isAnimated() then
							upArrowSplash:draw()
						end
						if downArrowSplash:isAnimated() then
							downArrowSplash:draw()
						end
				end
				

				love.graphics.push()
					love.graphics.translate(0, -musicPos)

					for j = #enemyNotes[i], 1, -1 do
						if (not settings.downscroll and enemyNotes[i][j].y - musicPos <= 560) or (settings.downscroll and enemyNotes[i][j].y - musicPos >= -560) then
							local animName = enemyNotes[i][j]:getAnimName()

							if animName == "hold" or animName == "end" then
								graphics.setColor(1, 1, 1, 0.5)
							end
							if settings.middleScroll then
								graphics.setColor(1, 1, 1, 0.5)
							end
							enemyNotes[i][j]:draw()
							graphics.setColor(1, 1, 1)
						end
					end
					for j = #boyfriendNotes[i], 1, -1 do
						if (not settings.downscroll and boyfriendNotes[i][j].y - musicPos <= 560) or (settings.downscroll and boyfriendNotes[i][j].y - musicPos >= -560) then
							local animName = boyfriendNotes[i][j]:getAnimName()

							if settings.downscroll then
								if animName == "hold" or animName == "end" then
									graphics.setColor(1, 1, 1, math.min(0.5, (500 - (boyfriendNotes[i][j].y - musicPos)) / 150))
								else
									graphics.setColor(1, 1, 1, math.min(1, (500 - (boyfriendNotes[i][j].y - musicPos)) / 75))
								end
							else
								if animName == "hold" or animName == "end" then
									graphics.setColor(1, 1, 1, math.min(0.5, (500 + (boyfriendNotes[i][j].y - musicPos)) / 150))
								else
									graphics.setColor(1, 1, 1, math.min(1, (500 + (boyfriendNotes[i][j].y - musicPos)) / 75))
								end
							end
							boyfriendNotes[i][j]:draw()
						end
					end
					graphics.setColor(1, 1, 1)
				love.graphics.pop()
			end
			graphics.setColor(1, 1, 1, countdownFade[1])
			countdown:draw()
			graphics.setColor(1, 1, 1)
		love.graphics.pop()
	end,
	drawHealthBar = function()
		love.graphics.push()
			-- Scroll underlay
			if week ~= 5 then
				love.graphics.push()
					love.graphics.setColor(0,0,0,settings.scrollUnderlayTrans)
					if settings.middleScroll then
						love.graphics.rectangle("fill", 400, -100, 90 + 170 * 2.35, 1000)
					else
						love.graphics.rectangle("fill", 755, -100, 90 + 170 * 2.35, 1000)
					end
					love.graphics.setColor(1,1,1,1)
				love.graphics.pop()
				end
			if week ~= 5 then
				love.graphics.translate(lovesize.getWidth() / 2, lovesize.getHeight() / 2)
				love.graphics.scale(0.7, 0.7)
			end
			if settings.downscroll then
				graphics.setColor(healthBarColorEnemy[1]/255, healthBarColorEnemy[2]/255, healthBarColorEnemy[3]/255)
				love.graphics.rectangle("fill", -500, -400, 1000, 25)
				graphics.setColor(healthBarColorPlayer[1]/255, healthBarColorPlayer[2]/255, healthBarColorPlayer[3]/255)
				love.graphics.rectangle("fill", 500, -400, -health * 10, 25)
				graphics.setColor(0, 0, 0)
				love.graphics.setLineWidth(10)
				love.graphics.rectangle("line", -500, -400, 1000, 25)
				love.graphics.setLineWidth(1)
				graphics.setColor(1, 1, 1)
			else
				graphics.setColor(healthBarColorEnemy[1]/255, healthBarColorEnemy[2]/255, healthBarColorEnemy[3]/255)
				love.graphics.rectangle("fill", -500, 350, 1000, 25)
				graphics.setColor(healthBarColorPlayer[1]/255, healthBarColorPlayer[2]/255, healthBarColorPlayer[3]/255)
				love.graphics.rectangle("fill", 500, 350, -health * 10, 25)
				graphics.setColor(0, 0, 0)
				love.graphics.setLineWidth(10)
				love.graphics.rectangle("line", -500, 350, 1000, 25)
				love.graphics.setLineWidth(1)
				graphics.setColor(1, 1, 1)
			end

			boyfriendIcon:draw()
			enemyIcon:draw()
			love.graphics.setColor(uiTextColour[1],uiTextColour[2],uiTextColour[3])
			accForRatingText = (altScore / (noteCounter + missCounter))
			if accForRatingText >= 100 then
				ratingText = "PERFECT!!!!" -- i added one ! so i could feel like i actually did something
			elseif accForRatingText >= 90 then
				ratingText = "Great!"
			elseif accForRatingText >= 70 then
				ratingText = "Good!"
			elseif accForRatingText >= 69 then
				ratingText = "Nice!"
			elseif accForRatingText >= 60 then
				ratingText = "Okay"
			elseif accForRatingText >= 50 then
				ratingText = "Meh..."
			elseif accForRatingText >= 40 then
				ratingText = "Could be better..."
			elseif accForRatingText >= 30 then
				ratingText = "It's an issue of skill."
			elseif accForRatingText >= 20 then
				ratingText = "Bad."
			elseif accForRatingText >= 10 then
				ratingText = "How."
			elseif accForRatingText >= 0 then
				ratingText = "Bruh."
			end


				if settings.downscroll then
					if not settings.middleScroll then
						love.graphics.print("Time Remaining: " .. timeLeftFixed, 0, -400)
					else
						love.graphics.print("Time Remaining: " .. timeLeftFixed, 605, -400)
					end
				else
					if not settings.middlescroll then
						love.graphics.print("Time Remaining: " .. timeLeftFixed, 0, 350)
					else
						love.graphics.print("Time Remaining: " .. timeLeftFixed, 605, 350)
					end
				end

				if not settings.botPlay then
					if settings.downscroll then
						local convertedAcc = string.format(
							"%.2f%%",
							(altScore / (noteCounter + missCounter))
						)
						if noteCounter + missCounter <= 0 then
							if (math.floor((altScore / (noteCounter + missCounter)) / 3.5)) >= 100 then
								love.graphics.printf("Score: " .. score .. " | Misses: " .. missCounter .. " | Accuracy: 0% | Rating: ???", -550, -350, 1100, "center")
							else
								love.graphics.printf("Score: " .. score .. " | Misses: " .. missCounter .. " | Accuracy: 0% | Rating: ???", -550, -350, 1100, "center")
							end
						else
							if (math.floor((altScore / (noteCounter + missCounter)) / 3.5)) >= 100 then
								love.graphics.printf("Score: " .. score .. " | Misses: " .. missCounter .. " | Accuracy: 100% | Rating: PERFECT!!!", -550, -350, 1100, "center")
							else
								love.graphics.printf("Score: " .. score .. " | Misses: " .. missCounter .. " | Accuracy: " .. convertedAcc .. " | Rating: " .. ratingText, -550, -350, 1100, "center")
							end
						end
					else
						local convertedAcc = string.format(
							"%.2f%%",
							(altScore / (noteCounter + missCounter))
						)
						if noteCounter + missCounter <= 0 then
							if (math.floor((altScore / (noteCounter + missCounter)) / 3.5)) >= 100 then
								love.graphics.printf("Score: " .. score .. " | Misses: " .. missCounter .. " | Hits: " .. hitCounter .. " | Accuracy: 0% | Rating: ???", -550, 400, 1100, "center")
							else
								love.graphics.printf("Score: " .. score .. " | Misses: " .. missCounter .. " | Hits: " .. hitCounter .. " | Accuracy: 0% | Rating: ???", -550, 400, 1100, "center")
							end
						else
							if (math.floor((altScore / (noteCounter + missCounter)) / 3.5)) >= 100 then
								love.graphics.printf("Score: " .. score .. " | Misses: " .. missCounter .. " | Hits: " .. hitCounter .. " | Accuracy: 100% | Rating: PERFECT!!!", -550, 400, 1100, "center")
							else
								love.graphics.printf("Score: " .. score .. " | Misses: " .. missCounter .. " | Hits: " .. hitCounter .. " | Accuracy: " .. convertedAcc .. " | Rating: " .. ratingText, -550, 400, 1100, "center")
							end
						end
					end

					if settings.sideJudgements then
						love.graphics.printf(
							"Sicks: " .. sicks ..
							"\n\nGoods: " .. goods ..
							"\n\nBads: " .. bads ..
							"\n\nShits: " .. shits,
							-900,
							0, 
							750, -- annoying limit and i don't want to test if it works with nil 
							"left"
						)
					end
				end
		love.graphics.pop()
		if settings.keystrokes then
			love.graphics.push()
				-- keystrokes
				love.graphics.setColor(1, 1, 1)

				if input:down("gameUp") then
					love.graphics.rectangle("fill", 131, 631, 30, 30) 
				end
				
				if input:down("gameDown") then
					love.graphics.rectangle("fill", 100, 631, 30, 30)
				end
				
				if input:down("gameRight") then
					love.graphics.rectangle("fill", 162, 631, 30, 30)
				end
								
				if input:down("gameLeft") then
					love.graphics.rectangle("fill", 69, 631, 30, 30)
				end
				
				love.graphics.setColor(0, 0, 0)

				love.graphics.rectangle("line", 69, 631, 30, 30) -- left
				love.graphics.rectangle("line", 100, 631, 30, 30) -- down
				love.graphics.rectangle("line", 131, 631, 30, 30) -- up
				love.graphics.rectangle("line", 162, 631, 30, 30) -- right

				love.graphics.color.printf(customBindLeft, 74, 626, 20, "left", nil, 1.5, 1.5, 255, 255, 255)  -- left
				love.graphics.color.printf(customBindDown, 105, 626, 20, "left", nil, 1.5, 1.5, 255, 255, 255)  -- down
				love.graphics.color.printf(customBindUp, 136, 626, 20, "left", nil, 1.5, 1.5, 255, 255, 255)  -- up
				love.graphics.color.printf(customBindRight, 167, 626, 20, "left", nil, 1.5, 1.5, 255, 255, 255)  -- right

				love.graphics.setColor(1, 1, 1)
			love.graphics.pop()
		end
		love.graphics.push()
		if paused then
			if week == 5 then
				love.graphics.translate(lovesize.getWidth() / 2, lovesize.getHeight() / 2)
				love.graphics.scale(0.7, 0.7)
			end
			love.graphics.setColor(0, 0, 0, 0.8)
			love.graphics.rectangle("fill", -10000, -2000, 25000, 10000)
			love.graphics.setColor(1, 1, 1)
			if pauseMenuSelection == 1 then
				resumeH:draw()
				restart:draw()
				exit:draw()
				options:draw()
			elseif pauseMenuSelection == 2 then
				resume:draw()
				restartH:draw()
				exit:draw()
				options:draw()
			elseif pauseMenuSelection == 3 then
				resume:draw()
				restart:draw()
				exitH:draw()
				options:draw()
			else
				resume:draw()
				restart:draw()
				exit:draw()
				optionsH:draw()
			end
		end
	love.graphics.pop()
	end,

	drawDialogue = function()
		love.graphics.printf(output, 150, 435, 200, "left", 0, 4.7, 4.7)
	end,

	leave = function(self)
		if inst then inst:stop() end
		voices:stop()
		uiTextColour = {1,1,1}

		Timer.clear()

		fakeBoyfriend = nil
	end
}
