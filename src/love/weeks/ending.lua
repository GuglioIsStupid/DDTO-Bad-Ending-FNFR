return {
	enter = function(self, from, songNum, songAppend)
		pauseColor = {129, 100, 223}
		weeks:enter()
		poemTransitionSwirl = love.filesystem.load("sprites/ending/poemTransition.lua")()
		poemTransitionSwirl.sizeX, poemTransitionSwirl.sizeY = 2.2, 2.2

		transparent = {
			["BGSketch"] = 0,
			["enemysong2"] = 0,
			['backgroundsong2'] = 0,
			["enemyStrum"] = 1,
			["boyfriendStrum"] = 1,
			["screen"] = 1
		}
		

		song = 2

		if song == 1 then
			enemy = love.filesystem.load("sprites/characters/sayori.lua")()
			enemy2 = love.filesystem.load("sprites/characters/sayoriSad.lua")()
			enemy3 = love.filesystem.load("sprites/characters/sayoriHappyThoughts.lua")()
			enemy.x, enemy.y = -380, 270
			enemy2.x, enemy2.y = -380, 380
			enemy3.x, enemy3.y = -380, -30
		elseif song == 2 then
			enemy = love.filesystem.load("sprites/characters/yuri.lua")()
			enemy2 = love.filesystem.load("sprites/characters/yuriClose.lua")()
			enemy3 = love.filesystem.load("sprites/characters/yuriStart.lua")()
			enemy4 = love.filesystem.load("sprites/characters/yuriFinale.lua")()
			enemy3.x, enemy3.y = 25, 200
			enemy3.sizeX, enemy3.sizeY = 3, 3
		elseif song == 3 then
			enemy = love.filesystem.load("sprites/characters/sayori.lua")()
			enemy2 = love.filesystem.load("sprites/characters/sayoriSad.lua")()
			enemy3 = love.filesystem.load("sprites/characters/sayoriHappyThoughts.lua")()
			enemy.x, enemy.y = -380, 270
			enemy2.x, enemy2.y = -380, 380
			enemy3.x, enemy3.y = -380, -30
			sayo = love.filesystem.load("sprites/characters/sayori.lua")()
			yuri = love.filesystem.load("sprites/characters/yuri.lua")()
		end
	
		girlfriend.x, girlfriend.y = 30, 210
		
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

		closet = {
			closetBG = graphics.newImage(love.graphics.newImage(graphics.imagePath("ending/ClosetBG"))),
		}
		closet.closetBG.x, closet.closetBG.y = 125,150

		paperBG = love.filesystem.load("sprites/ending/paperBG.lua")()
		paperBG.sizeX, paperBG.sizeY = 1.4, 1.4

		-------------------

		function camZoom(time, num)
			local time = time or 0.5
			local num = num or 0.03
			if camTween then
				Timer.cancel(camTween)
			end
			camTween = Timer.tween(
				time,
				cam,
				{
					sizeX = cam.sizeX + num,
					sizeY = cam.sizeY + num
				},
				"out-quad"
			)
		end
		function changeVisiblity(name, value, time, wait)
			local time = time or 0.5
			local num = num or 0.03
			if visTween then
				Timer.cancel(visTween)
			end
			if wait then Timer.after(
				wait,
				function()
					visTween = Timer.tween(
						time,
						transparent,
						{
							[name] = value
						},
						"out-quad"
					)
				end
			)
			else
				visTween = Timer.tween(
					time,
					transparent,
					{
						[name] = value
					},
					"out-quad"
				)
			end
			
		end
		
		function sadTimeFunc() 
			weeks:safeAnimate(girlfriend, "glitch", false, 3)
			camZoom(0.65, 0.15, true)
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
			weeks:safeAnimate(girlfriend, "idle", false, 3)
			girlfriend.x, girlfriend.y = boyfriend.x - 200, boyfriend.y
			cam.sizeX, cam.sizeY = 0.95, 0.95
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
			weeks:safeAnimate(girlfriend, "idle", false, 3)
			cam.sizeX, cam.sizeY = 0.95, 0.95
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
		closeUp = true
				
		
		if song == 3 then
			inst = love.audio.newSource("songs/ending/home/Inst.ogg", "stream")
			voices = love.audio.newSource("songs/ending/home/Voices.ogg", "stream")
		elseif song == 2 then
			inst = love.audio.newSource("songs/ending/markov/Inst.ogg", "stream")
			voices = love.audio.newSource("songs/ending/markov/Voices.ogg", "stream")
			enemy = love.filesystem.load("sprites/characters/yuri.lua")()
			enemy2 = love.filesystem.load("sprites/characters/yuriClose.lua")()
			enemy3 = love.filesystem.load("sprites/characters/yuriStart.lua")()
			enemy4 = love.filesystem.load("sprites/characters/yuriFinale.lua")()
			enemy3.x, enemy3.y = 150, 350
			enemy2.x, enemy2.y = 150, 325
			enemy4.x, enemy4.y = 150, 325
			enemy3.sizeX, enemy3.sizeY = 1.55, 1.55
			enemy2.sizeX, enemy2.sizeY = 1.35, 1.35
			enemy4.sizeX, enemy4.sizeY = 1.35, 1.35
			enemy.x, enemy.y = -380, 270
			camZoom(0, 0.2)
			transparent["enemy"] = 0
			transparent["enemyStrum"] = 0
			transparent["screen"] = 1
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
			elseif musicTime >= 193666 and musicTime <= 193516 then
				poemTransitionSwirl:animate("anim", false)
			elseif musicTime >= 221000 and musicTime <= 221000+50 then
				poemTransitionSwirl:animate("anim", false)
				finalTransition = true
			end
			if musicTime >= 87999 and musicTime <= 87999+50 then -- cam zooms
				camZoom(0.35, 0.25)
			elseif musicTime >= 154444 and musicTime <= 154444+50 then
				camZoom(0.03, 0.01)
			elseif musicTime >= 154666 and musicTime <= 154666+50 then
				camZoom(0.03, 0.01)
			elseif musicTime >= 156000 and musicTime <= 156000+50 then
				camZoom(0.03, 0.01)
			elseif musicTime >= 156500 and musicTime <= 156500+50 then
				camZoom(0.03, 0.01)
			elseif musicTime >= 158666 and musicTime <= 158666+50 then
				camZoom(0.03, 0.01)
			elseif musicTime >= 161333 and musicTime <= 161333+50 then
				camZoom(0.03, 0.01)
			elseif musicTime >= 162666 and musicTime <= 162666+50 then
				camZoom(0.03, 0.01)
			elseif musicTime >= 164000 and musicTime <= 164000+50 then
				camZoom(0.03, 0.01)
			elseif musicTime >= 165333 and musicTime <= 165333+50 then
				camZoom(0.03, 0.01)
			elseif musicTime >= 166000 and musicTime <= 166000+50 then
				camZoom(0.03, 0.01)
			elseif musicTime >= 166666 and musicTime <= 166666+50 then
				camZoom(0.03, 0.01)
			elseif musicTime >= 167166 and musicTime <= 167166+50 then
				camZoom(0.03, 0.01)
			elseif musicTime >= 169333 and musicTime <= 169333+50 then
				camZoom(0.03, 0.01)
			elseif musicTime >= 172000 and musicTime <= 172000+50 then
				camZoom(0.03, 0.01)
			elseif musicTime >= 173333 and musicTime <= 173333+50 then
				camZoom(1, 0.05)
			elseif musicTime >= 178666 and musicTime <= 178666+50 then
				camZoom(1, 0.05)
			elseif musicTime >= 184000 and musicTime <= 184000+50 then
				camZoom(1, 0.05)
			elseif musicTime >= 189333 and musicTime <= 189333+50 then
				camZoom(1, 0.05)
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
			if musicTime >= 0 and musicTime <= 50 then
				changeVisiblity("backgroundsong2", 1, 8, 0)
				changeVisiblity("enemysong2", 1, 2, 8)
			end
			if musicTime >= 10787 and musicTime <= 10837 then 
				weeks:safeAnimate(enemy3, "appear", 2, false)
			end
			if musicTime >= 13150 and musicTime <= 13200 then
				changeVisiblity("enemyStrum", 1, 3, 0)
			end
			if musicTime >= 41404 and musicTime <= 41454 then
				changeVisiblity("enemysong2", 0, 2, 0.05)
				changeVisiblity("backgroundsong2", 0, 4, 1.2)
			end
			if musicTime >= 41712 and musicTime <= 41762 then
				changeVisiblity("enemyStrum", 0, 3, 0)
				changeVisiblity("boyfriendStrum", 0, 3, 0)
			end
			if musicTime >= 46027 and musicTime <= 46077 then
				changeVisiblity("enemyStrum", 1, 0, 0)
				changeVisiblity("boyfriendStrum", 1, 0, 0)
			end
			if musicTime >= 45924 and musicTime <= 45974 then 
				camZoom(0.1, 0.2)
			end
			if musicTime >= 84427 and musicTime <= 84477 then
				changeVisiblity("screen", 0, 1.4, 0)
			end
			if musicTime >= 86827 and musicTime <= 86877 then
				changeVisiblity("screen", 1, 0, 0)
			end
			if musicTime >= 106027 and musicTime <= 106077 then
				camZoom(0.3, -0.2)
			end
			if musicTime >= 126027 and musicTime <= 126077 then
				camZoom(0.03, 0.015)
			end
			if musicTime >= 137227 and musicTime <= 137277 then
				camZoom(0.03, 0.015)
			end
			if musicTime >= 138472 and musicTime <= 138522 then
				camZoom(0.03, 0.015)
			end
			if musicTime >= 139627 and musicTime <= 139677 then
				camZoom(0.03, 0.015)
			end
			if musicTime >= 140827 and musicTime <= 140877 then
				camZoom(0.03, 0.015)
			end
			if musicTime >= 142027 and musicTime <= 142077 then
				camZoom(0.03, 0.015)
			end
			if musicTime >= 143227 and musicTime <= 143277 then
				camZoom(0.03, 0.015)
			end
			if musicTime >= 144472 and musicTime <= 144522 then
				camZoom(0.3, -0.2)
			end
			if musicTime >= 173227 and musicTime <= 173277 then
				camZoom(0.4, 0.2)
				love.graphics.setBackgroundColor(1,1,1)
			end
			if musicTime >= 216427 and musicTime <= 216477 then
				changeVisiblity("backgroundsong2", 1, 0, 0)
			elseif musicTime >= 85927 and musicTime <= 85977 then
				changeVisiblity("backgroundsong2", 1, 0, 0)
			elseif musicTime >= 182452 and musicTime <= 182502 then
				changeVisiblity("backgroundsong2", 1, 0, 0)
			elseif musicTime >= 216727 and musicTime <= 216777 then
				changeVisiblity("backgroundsong2", 1, 0, 0)
			elseif musicTime >= 217927 and musicTime <= 217977 then
				changeVisiblity("backgroundsong2", 1, 0, 0)
			elseif musicTime >= 219127 and musicTime <= 219177 then
				changeVisiblity("backgroundsong2", 1, 0, 0)
			elseif musicTime >= 220327 and musicTime <= 220377 then
				changeVisiblity("backgroundsong2", 1, 0, 0)
			elseif musicTime >= 221527 and musicTime <= 221577 then
				changeVisiblity("backgroundsong2", 1, 0, 0)
			elseif musicTime >= 222727 and musicTime <= 222777 then
				changeVisiblity("backgroundsong2", 1, 0, 0)
			elseif musicTime >= 223927 and musicTime <= 223977 then
				changeVisiblity("backgroundsong2", 1, 0, 0)
			end
			if musicTime >= 223627 and musicTime <= 223677 then
				changeVisiblity("enemyStrum", 0, 0.2, 0)
				changeVisiblity("boyfriendStrum", 0, 0.2, 0)
			end
			if musicTime >= 224302 and musicTime <= 224352 then
				changeVisiblity("boyfriendStrum", 1, 0.5, 0)
			end
			if musicTime >= 228427 and musicTime <= 228477 then
				changeVisiblity("boyfriendStrum",0, 0.2, 0)
			end
			if closeUp then 
				cam.sizeX, cam.sizeY = 0.95, 0.95 
				cam.x, cam.y = -boyfriend.x + 100, -boyfriend.y + 150
			end
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
				if not inWhite then
					if song == 1 and (musicTime <= 23999) or song == 1 and (musicTime >= 45333 and musicTime <= 66666) then
						clubroom.farBG:draw()
						clubroom.mainBG:draw()
					end
					if sadTime then
						clubroom2.sky:draw()
						clubroom2.mainBG:draw()
						if song == 1 then
							if (musicTime >= 87999 and musicTime <= 110000) or (musicTime >= 189333 and musicTime <= 194666) then
								love.graphics.setColor(1,1,1,transparent["BGSketch"])
								clubroom2.bgSketch:draw()
								love.graphics.setColor(1,1,1,1)
							end
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
					if closeUp then
						love.graphics.setColor(1,1,1,transparent["backgroundsong2"])
						closet.closetBG:draw()
						love.graphics.setColor(1,1,1,1)
					end
					love.graphics.scale(0.75, 0.75)
					if song == 1 then
						if not notebookTime then
							girlfriend:draw()
						end
					elseif song == 2 then
						if not dontDrawBF then
							girlfriend:draw()
						end
					end
				end
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)
				love.graphics.scale(0.75, 0.75)
				-- Stagnant
				if song == 1 then
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
				
				-- Markov
				elseif song == 2 then
					if musicTime <= 44486 then
						closeUp = true
						graphics.setColor(1,1,1,transparent["enemysong2"])
						enemy3:draw()
						love.graphics.setColor(1,1,1,1)
						dontDrawBF = true
						sadTime = false
					end
					if (musicTime >= 44486 and musicTime <= 46027) or (musicTime >= 85927 and musicTime <= 125227) or (musicTime >= 182452 and musicTime <= 216427) or (musicTime >= 216727 and musicTime <= 217627) or (musicTime >= 217927 and musicTime <= 218827) or (musicTime >= 219127 and musicTime <= 220027) or (musicTime >= 220327 and musicTime <= 221227) or (musicTime >= 221527 and musicTime <= 222427) or (musicTime >= 222727 and musicTime <= 223627) or (musicTime >= 223927 and musicTime <= 224827) then
						closeUp = true
						enemy2:draw()
						dontDrawBF = true
						sadTime = false
					end
					if (musicTime >= 46027 and musicTime <= 85927) or (musicTime >= 125227 and musicTime <= 182452) then
						if girlfriend:getAnimName() ~= "glitch" then
							girlfriend:animate("glitch")
						end
						closeUp = false
						enemy:draw()
						dontDrawBF = false
						sadTime = true
					end
					if musicTime >= 224827 then
						if enemy4:getAnimName() == "down" or enemy4:getAnimName() == "up" then
							if not ballsFinish then weeks:safeAnimate(enemy4, "dies", 2, false, 30) end
							if ballsFinish then
								Timer.cancel(ballsFinish)
							end
							ballsFinish = Timer.tween(
								1.66,
								enemy,
								{
									x = enemy.x + 600
								},
								"out-quad"
							)
						end
						closeUp = true
						inWhite = true
						enemy4:draw()
						dontDrawBF = true
						sadTime = false
					end
					if (musicTime >= 216427 and musicTime <= 216727) or (musicTime >= 217627 and musicTime <= 217927) or (musicTime >= 218827 and musicTime <= 219127) or (musicTime >= 220027 and musicTime <= 220327) or (musicTime >= 221227 and musicTime <= 221527) or (musicTime >= 222427 and musicTime <= 222727) or (musicTime >= 223627 and musicTime <= 223927) then
						inWhite = false
						closeUp = true
						enemy4:draw()
						dontDrawBF = true
						sadTime = false
					end
					if not dontDrawBF then
						boyfriendSad:draw()
					end
				-- Home
				elseif song == 3 then
					enemy:draw()
					boyfriend:draw()
					sayo:draw()
					yuri:draw()
				end

			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 1.1, cam.y * 1.1)
				if song == 1 then
					if (musicTime <= 23999) or (musicTime >= 45333 and musicTime <= 66666) then
						clubroom.DesksFront:draw()
					end
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
