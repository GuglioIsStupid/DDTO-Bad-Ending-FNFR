local stageBack, stageFront, curtains
return {
	enter = function(self, from, songNum, songAppend)
		pauseColor = {129, 100, 223}
		weeks:enter()
		stages["clubroom"]:enter()
		poemTransitionSwirl = love.filesystem.load("sprites/ending/poemTransition.lua")()
		poemTransitionSwirl.sizeX, poemTransitionSwirl.sizeY = 2.2, 2.2

		song = 1
		notebookTimeBool = false
		sadTimeBool = false

		healthBarColours = {
			{149, 224, 250}, -- Sayori
			{200, 0, 255}, -- Yuri
			{175, 200, 15} -- Natsuki
		}

		enemyNames = {
			"sayori",
			"yuri",
			"natsuki"
		}

		self:load()
	end,

	load = function(self)
		weeks:load()
		stages["clubroom"]:load()
		notebookTime = false
		sadTime = false
		healthBarColorEnemy = {healthBarColours[song][1],healthBarColours[song][2],healthBarColours[song][3]}
		boyfriendIcon:animate("boyfriend", false)
		
		if song == 3 then
			inst = love.audio.newSource("songs/ending/dadbattle/Inst.ogg", "stream")
			voices = love.audio.newSource("songs/ending/dadbattle/Voices.ogg", "stream")
		elseif song == 2 then
			inst = love.audio.newSource("songs/ending/markov/Inst.ogg", "stream")
			voices = love.audio.newSource("songs/ending/markov/Voices.ogg", "stream")
		else
			inst = love.audio.newSource("songs/ending/stagnant/Inst.ogg", "stream")
			voices = love.audio.newSource("songs/ending/stagnant/Voices.ogg", "stream")
		end
		enemyIcon:animate(enemyNames[song], false)

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		if song == 3 then
			weeks:generateNotes(love.filesystem.load("songs/ending/home/home.lua")())
		elseif song == 2 then
			weeks:generateNotes(love.filesystem.load("songs/ending/markov/markov.lua")())
		else
			weeks:generateNotes(love.filesystem.load("songs/ending/stagnant/stagnant.lua")())
		end
	end,

	update = function(self, dt)
		weeks:update(dt)
		stages["clubroom"]:update(dt)
		poemTransitionSwirl:update(dt)

        if musicTime <= 100 then -- the camera is broken for some reason and I have no idea why
            cam.sizeX, cam.sizeY = 1, 1
		    camScale.x, camScale.y = 1, 1
        end

        if song == 1 then
			-- Stagnant
			if musicTime >= 108333 and musicTime <= 108383 then -- poem transitions
				poemTransitionSwirl:animate("anim", false)
			elseif musicTime >= 193666 and musicTime <= 193716 then
				poemTransitionSwirl:animate("anim", false)
			elseif musicTime >= 221333 and musicTime <= 221383 then
				poemTransitionSwirl:animate("anim", false)
			end
            if musicTime >= 23999 and musicTime <= 24049 then -- sad transition
				sadTime = true
				if enemyIcon:getAnimName() == enemyNames[song] then
					enemyIcon:animate(enemyNames[song].." sad", false)
				elseif enemyIcon:getAnimName() == enemyNames[song] .. " losing" then
					enemyIcon:animate(enemyNames[song].." sad losing", false)
				end
				if boyfriendIcon:getAnimName() == "boyfriend" or boyfriendIcon:getAnimName() == "boyfriend note" then
					boyfriendIcon:animate("boyfriend sad", false)
				elseif boyfriendIcon:getAnimName() == "boyfriend losing" or boyfriendIcon:getAnimName() == "boyfriend note losing" then
					boyfriendIcon:animate("boyfriend sad losing", false)
				end
				healthBarColorEnemy = {149, 182, 202}
				healthBarColorPlayer = {82, 115, 145}
			elseif musicTime >= 45333 and musicTime <= 45383 then -- exit sad
				sadTime = false
				if enemyIcon:getAnimName() == enemyNames[song] .. " sad" then
					enemyIcon:animate(enemyNames[song], false)
				elseif enemyIcon:getAnimName() == enemyNames[song] .. " sad losing" then
					enemyIcon:animate(enemyNames[song].." losing", false)
				end
				if boyfriendIcon:getAnimName() == "boyfriend sad" or boyfriendIcon:getAnimName() == "boyfriend note" then
					boyfriendIcon:animate("boyfriend", false)
				elseif boyfriendIcon:getAnimName() == "boyfriend sad losing" or boyfriendIcon:getAnimName() == "boyfriend note losing" then
					boyfriendIcon:animate("boyfriend losing", false)
				end
				healthBarColorEnemy = {healthBarColours[song][1],healthBarColours[song][2],healthBarColours[song][3]}
				healthBarColorPlayer = {49,176,209}
			elseif musicTime >= 66666 and musicTime <= 66716 then --2nd sad transition
				sadTime = true
				if enemyIcon:getAnimName() == enemyNames[song] then
					enemyIcon:animate(enemyNames[song].." sad", false)
				elseif enemyIcon:getAnimName() == enemyNames[song] .. " losing" then
					enemyIcon:animate(enemyNames[song].." sad losing", false)
				end
				if boyfriendIcon:getAnimName() == "boyfriend" or boyfriendIcon:getAnimName() == "boyfriend note" then
					boyfriendIcon:animate("boyfriend sad", false)
				elseif boyfriendIcon:getAnimName() == "boyfriend losing" or boyfriendIcon:getAnimName() == "boyfriend note losing" then
					boyfriendIcon:animate("boyfriend sad losing", false)
				end
				healthBarColorEnemy = {149, 182, 202}
				healthBarColorPlayer = {82, 115, 145}
			elseif musicTime >= 109999 and musicTime <= 109999 + 50 then -- notebook transition
				sadTime = false
				notebookTime = true
				if enemyIcon:getAnimName() == enemyNames[song] .. " sad" then
					enemyIcon:animate(enemyNames[song].." note", false)
				elseif enemyIcon:getAnimName() == enemyNames[song] .. " sad losing" then
					enemyIcon:animate(enemyNames[song].." note losing", false)
				end
				if boyfriendIcon:getAnimName() == "boyfriend" or boyfriendIcon:getAnimName() == "boyfriend sad" then
					boyfriendIcon:animate("boyfriend note", false)
				elseif boyfriendIcon:getAnimName() == "boyfriend losing" or boyfriendIcon:getAnimName() == "boyfriend sad losing" then
					boyfriendIcon:animate("boyfriend note losing", false)
				end
				healthBarColorEnemy = {255, 225, 225}
				healthBarColorPlayer = {255, 225, 225}
			elseif musicTime >= 151999 and musicTime <= 151999+50 then -- 3rd sad transition
				notebookTime = false
				sadTime = true
				if enemyIcon:getAnimName() == enemyNames[song] .. " note" then
					enemyIcon:animate(enemyNames[song] .. " sad", false)
				elseif enemyIcon:getAnimName() == enemyNames[song] .. " note losing" then
					enemyIcon:animate(enemyNames[song].." sad losing", false)
				end
				if boyfriendIcon:getAnimName() == "boyfriend" or boyfriendIcon:getAnimName() == "boyfriend note" then
					boyfriendIcon:animate("boyfriend sad", false)
				elseif boyfriendIcon:getAnimName() == "boyfriend losing" or boyfriendIcon:getAnimName() == "boyfriend note losing" then
					boyfriendIcon:animate("boyfriend sad losing", false)
				end
				healthBarColorEnemy = {149, 182, 202}
				healthBarColorPlayer = {82, 115, 145}
			elseif musicTime >= 194666 and musicTime <= 194666+50 then -- 2nd notebook transition
				sadTime = false
				notebookTime = true
				if enemyIcon:getAnimName() == enemyNames[song] .. " sad" then
					enemyIcon:animate(enemyNames[song].." note", false)
				elseif enemyIcon:getAnimName() == enemyNames[song] .. " sad losing" then
					enemyIcon:animate(enemyNames[song].." note losing", false)
				end
				if boyfriendIcon:getAnimName() == "boyfriend" or boyfriendIcon:getAnimName() == "boyfriend sad" then
					boyfriendIcon:animate("boyfriend note", false)
				elseif boyfriendIcon:getAnimName() == "boyfriend losing" or boyfriendIcon:getAnimName() == "boyfriend sad losing" then
					boyfriendIcon:animate("boyfriend note losing", false)
				end
				healthBarColorEnemy = {255, 225, 225}
				healthBarColorPlayer = {255, 225, 225}
			end
		elseif song == 2 then
			-- Markov
		else
			-- Home
        end

		if health >= 80 then
			if enemyIcon:getAnimName() == enemyNames[song] then
				enemyIcon:animate(enemyNames[song].." losing", false)
			elseif enemyIcon:getAnimName() == enemyNames[song].." sad" then
				enemyIcon:animate(enemyNames[song].." sad losing", false)
			elseif enemyIcon:getAnimName() == enemyNames[song].." note" then
				enemyIcon:animate(enemyNames[song].." note losing", false)
			elseif enemyIcon:getAnimName() == enemyNames[song].." glitch" then
				enemyIcon:animate(enemyNames[song].." glitch losing", false)
			elseif enemyIcon:getAnimName() == enemyNames[song].." closet" then
				enemyIcon:animate(enemyNames[song].." closet losing", false)
			elseif enemyIcon:getAnimName() == enemyNames[song].." i" then
				enemyIcon:animate(enemyNames[song].." i losing", false)
			elseif enemyIcon:getAnimName() == enemyNames[song].." i2" then
				enemyIcon:animate(enemyNames[song].." i2 losing", false)
			end
		else
			if enemyIcon:getAnimName() == enemyNames[song].." losing" then
				enemyIcon:animate(enemyNames[song], false)
			elseif enemyIcon:getAnimName() == enemyNames[song].." sad losing" then
				enemyIcon:animate(enemyNames[song] .. " sad", false)
			elseif enemyIcon:getAnimName() == enemyNames[song].." note losing" then
				enemyIcon:animate(enemyNames[song] .. " note", false)
			elseif enemyIcon:getAnimName() == enemyNames[song].." glitch losing" then
				enemyIcon:animate(enemyNames[song] .. " glitch", false)
			elseif enemyIcon:getAnimName() == enemyNames[song].." closet losing" then
				enemyIcon:animate(enemyNames[song] .. " closet", false)
			elseif enemyIcon:getAnimName() == enemyNames[song].." i losing" then
				enemyIcon:animate(enemyNames[song] .. " i", false)
			elseif enemyIcon:getAnimName() == enemyNames[song].." i2 losing" then
				enemyIcon:animate(enemyNames[song] .. " i2", false)
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

			stages["clubroom"]:draw()

			weeks:drawRating(0.9)
			if poemTransitionSwirl:isAnimated() and musicTime >= 10000 then
				poemTransitionSwirl:draw()
			end
		love.graphics.pop()

		weeks:drawHealthBar()
		if not paused then
			weeks:drawUI()
		end
	end,

	leave = function(self)
		stages["clubroom"]:leave()
		weeks:leave()
	end
}
