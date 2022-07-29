return {
	enter = function(self, from, songNum, songAppend)
		pauseColor = {129, 100, 223}
		weeks:enter()
		poemTransitionSwirl = love.filesystem.load("sprites/ending/poemTransition.lua")()
		poemTransitionSwirl.sizeX, poemTransitionSwirl.sizeY = 2.2, 2.2

		transparent = {
			["BGSketch"] = 0
		}

		song = 1

		enemy = love.filesystem.load("sprites/characters/sayori.lua")()
		enemy2 = love.filesystem.load("sprites/characters/sayoriSad.lua")()
		enemy3 = love.filesystem.load("sprites/characters/sayoriHappyThoughts.lua")()

		girlfriend.x, girlfriend.y = 30, 210
		enemy.x, enemy.y = -380, 270
		enemy2.x, enemy2.y = -380, 380
		enemy3.x, enemy3.y = -380, -30
		boyfriend.x, boyfriend.y = 260, 410
		boyfriendSad.x, boyfriendSad.y = 260, 460
		boyfriendHappy.x, boyfriendHappy.y = 260, 100

		healthBarColours = {
			{149, 224, 250}, -- Sayori
			{200, 0, 255}, -- Yuri
			{175, 200, 15} -- Natsuki
		}

        cam.sizeX, cam.sizeY = 0.95, 0.95
		camScale.x, camScale.y = 0.95, 0.95

		enemyNames = {
			"sayori",
			"yuri",
			"natsuki"
		}

		-- stage stuffies --

		-- Clubroom
		clubroom = {
			mainBG = graphics.newImage(love.graphics.newImage(graphics.imagePath("ending/DDLCBG"))),
			farBG = graphics.newImage(love.graphics.newImage(graphics.imagePath("ending/DDLCfarBG"))),
			DesksFront = graphics.newImage(love.graphics.newImage(graphics.imagePath("ending/DesksFront")))
		}
		clubroom.mainBG.sizeX, clubroom.mainBG.sizeY = 1.4, 1.4
		clubroom.farBG.sizeX, clubroom.farBG.sizeY = 1.4, 1.4
		clubroom.DesksFront.sizeX, clubroom.DesksFront.sizeY = 1.4, 1.4
		-- Ruinedclub
		ruinedclub = {
			mainBG = graphics.newImage(love.graphics.newImage(graphics.imagePath("ending/BG"))),
			glitchFront = graphics.newImage(love.graphics.newImage(graphics.imagePath("ending/glitchfront1"))),
			glitchBack = graphics.newImage(love.graphics.newImage(graphics.imagePath("ending/glitchback1")))
		}
		ruinedclub.mainBG.sizeX, ruinedclub.mainBG.sizeY = 1.4, 1.4
		ruinedclub.glitchFront.sizeX, ruinedclub.glitchFront.sizeY = 1.4, 1.4
		ruinedclub.glitchBack.sizeX, ruinedclub.glitchBack.sizeY = 1.4, 1.4
		-- Clubroom2
		clubroom2 = {
			mainBG = graphics.newImage(love.graphics.newImage(graphics.imagePath("ending/BGRoom"))),
			sky = graphics.newImage(love.graphics.newImage(graphics.imagePath("ending/Sky"))),
			bgSketch = love.filesystem.load("sprites/ending/BGsketch.lua")(),
		}
		clubroom2.mainBG.sizeX, clubroom2.mainBG.sizeY = 1.4, 1.4
		clubroom2.sky.sizeX, clubroom2.sky.sizeY = 1.4, 1.4
		clubroom2.bgSketch.sizeX, clubroom2.bgSketch.sizeY = 1.4, 1.4
		-- Notepad
		notepad = {
			notepad = graphics.newImage(love.graphics.newImage(graphics.imagePath("ending/notepad"))),
			notepadOverlay = graphics.newImage(love.graphics.newImage(graphics.imagePath("ending/notepad_overlay"))),
		}
		notepad.notepad.sizeX, notepad.notepad.sizeY = 1.4, 1.4
		notepad.notepadOverlay.sizeX, notepad.notepadOverlay.sizeY = 1.4, 1.4
		notepad.notepad.x = 100
		notepad.notepadOverlay.x = 100
		notepad.notepad.y = 50
		notepad.notepadOverlay.y = 50

		paperBG = love.filesystem.load("sprites/ending/paperBG.lua")()
		paperBG.sizeX, paperBG.sizeY = 1.4, 1.4

		-------------------

		function sadTimeFunc() 
			sadTime = true
			notebookTime = false
			girlfriend.x, girlfriend.y = 30, 230
			if enemyIcon:getAnimName() == enemyNames[song] or enemyIcon:getAnimName() == enemyNames[song] .. " note" then
				enemyIcon:animate(enemyNames[song].." sad", false)
			elseif enemyIcon:getAnimName() == enemyNames[song] .. " losing" or enemyIcon:getAnimName() == enemyNames[song] .. " note losing" then
				enemyIcon:animate(enemyNames[song].." sad losing", false)
			end
			if boyfriendIcon:getAnimName() == "boyfriend" or boyfriendIcon:getAnimName() == "boyfriend note" then
				boyfriendIcon:animate("boyfriend sad", false)
			elseif boyfriendIcon:getAnimName() == "boyfriend losing" or boyfriendIcon:getAnimName() == "boyfriend note losing" then
				boyfriendIcon:animate("boyfriend sad losing", false)
			end
			healthBarColorEnemy = {149, 182, 202}
			healthBarColorPlayer = {82, 115, 145}
		end
		function notebookTimeFunc()
			sadTime = false
			notebookTime = true
			if enemyIcon:getAnimName() == enemyNames[song] .. " sad" or enemyIcon:getAnimName() == enemyNames[song] then
				enemyIcon:animate(enemyNames[song].." note", false)
			elseif enemyIcon:getAnimName() == enemyNames[song] .. " sad losing" or enemyIcon:getAnimName() == enemyNames[song] .. " losing" then
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
		function exitSpecial()
			sadTime = false
			notebookTime = false
			girlfriend.x, girlfriend.y = 30, 140
			if enemyIcon:getAnimName() == enemyNames[song] .. " sad" or enemyIcon:getAnimName() == enemyNames[song] .. " note" then
				enemyIcon:animate(enemyNames[song], false)
			elseif enemyIcon:getAnimName() == enemyNames[song] .. " sad losing" or enemyIcon:getAnimName() == enemyNames[song] .. " note losing" then
				enemyIcon:animate(enemyNames[song].." losing", false)
			end
			if boyfriendIcon:getAnimName() == "boyfriend sad" or boyfriendIcon:getAnimName() == "boyfriend note" then
				boyfriendIcon:animate("boyfriend", false)
			elseif boyfriendIcon:getAnimName() == "boyfriend sad losing" or boyfriendIcon:getAnimName() == "boyfriend note losing" then
				boyfriendIcon:animate("boyfriend losing", false)
			end
			healthBarColorEnemy = {healthBarColours[song][1],healthBarColours[song][2],healthBarColours[song][3]}
			healthBarColorPlayer = {49,176,209}
		end

		self:load()
	end,

	load = function(self)
		weeks:load()
 		notebookTime = false
		sadTime = false
		healthBarColorEnemy = {healthBarColours[song][1],healthBarColours[song][2],healthBarColours[song][3]}
		healthBarColorPlayer = {49,176,209}
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
		poemTransitionSwirl:update(dt)
		paperBG:update(dt)
		clubroom2.bgSketch:update(dt)

        if musicTime <= 100 then -- the camera is broken for some reason and I have no idea why
            cam.sizeX, cam.sizeY = 0.95, 0.95
		    camScale.x, camScale.y = 0.95, 0.95
        end

        if song == 1 then
			-- Stagnant
			if musicTime >= 108333 and musicTime <= 108383 then -- poem transitions
				poemTransitionSwirl:animate("anim", false)
			elseif musicTime >= 193666 and musicTime <= 193716 then
				poemTransitionSwirl:animate("anim", false)
			elseif musicTime >= 221333 and musicTime <= 221383 then
				poemTransitionSwirl:animate("anim", false)
				finalTransition = true
			end
			if musicTime <= 87999 or musicTime >= 110000 or musicTime <= 189333 and musicTime >= 194666 then
				transparent["BGSketch"] = 0
			end
			if (musicTime >= 87999 and musicTime <= 87999+50) or (musicTime >= 189333 and musicTime <= 189383) then
				Timer.tween(2.8, transparent, { ["BGSketch"] = 1 }, 'linear')
			end
            if musicTime >= 23999 and musicTime <= 24049 then -- sad transition
				sadTimeFunc()
			elseif musicTime >= 45333 and musicTime <= 45383 then -- exit sad
				exitSpecial()
			elseif musicTime >= 66666 and musicTime <= 66716 then --2nd sad transition
				sadTimeFunc()
			elseif musicTime >= 109949 and musicTime <= 109999 then -- notebook transition
				notebookTimeFunc()
			elseif musicTime >= 151999 and musicTime <= 151999+50 then -- 3rd sad transition
				sadTimeFunc()
			elseif musicTime >= 194616 and musicTime <= 194666 then -- 2nd notebook transition
				notebookTimeFunc()
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
			if song == 1 and (finalTransition and not poemTransitionSwirl:isAnimated()) then
				love.graphics.setColor(1,1,1,0)
			end
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
			love.graphics.scale(cam.sizeX, cam.sizeY)

			love.graphics.push()
				love.graphics.translate(cam.x * 0.9, cam.y * 0.9)
				if song == 1 and (musicTime <= 23999) or (musicTime >= 45333 and musicTime <= 66666) then
					clubroom.farBG:draw()
					clubroom.mainBG:draw()
				elseif song == 2 then
					clubroom.farBG:draw()
					clubroom.mainBG:draw()
				end
				if sadTime then
					clubroom2.sky:draw()
					clubroom2.mainBG:draw()
					if (musicTime >= 87999 and musicTime <= 110000) or (musicTime >= 189333 and musicTime <= 194666) then
						love.graphics.setColor(1,1,1,transparent["BGSketch"])
						clubroom2.bgSketch:draw()
						love.graphics.setColor(1,1,1,1)
					end
				end
				if ruinedTime then
					ruinedclub.glitchBack:draw()
					ruinedclub.mainBG:draw()
					ruinedclub.glitchFront:draw()
				end
				if notebookTime then
					paperBG:draw()
				end
				love.graphics.scale(0.75, 0.75)
				if not notebookTime then
					girlfriend:draw()
				end
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)
				love.graphics.scale(0.75, 0.75)
				if (musicTime <= 23999) or (musicTime >= 45333 and musicTime <= 66666) then
					enemy:draw()
					boyfriend:draw()
				end
				if sadTime then
					enemy2:draw()
					boyfriendSad:draw()
				end
				if notebookTime then
					enemy3:draw()
					boyfriendHappy:draw()
				end
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 1.1, cam.y * 1.1)
				if (musicTime <= 23999) or (musicTime >= 45333 and musicTime <= 66666) then
					clubroom.DesksFront:draw()
				end
			love.graphics.pop()

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
		weeks:leave()
	end
}
