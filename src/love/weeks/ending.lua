return {
	enter = function(self, from, songNum, songAppend)
		pauseColor = {129, 100, 223}
		weeks:enter()
		poemTransitionSwirl = love.filesystem.load("sprites/ending/poemTransition.lua")()
		poemTransitionSwirl.sizeX, poemTransitionSwirl.sizeY = 2.2, 2.2
		static = love.filesystem.load("sprites/ending/HomeStatic.lua")()
		static.sizeX, static.sizeY = 1.5, 1.5
		static:animate("anim", true)
		TIMERS = {}
		CAMTIMERS = {}

		transparent = {
			["BGSketch"] = 0,
			["enemysong2"] = 0,
			['backgroundsong2'] = 0,
			["enemyStrum"] = 1,
			["boyfriendStrum"] = 1,
			["screen"] = 1,
			["enemysong3"] = 0,
			["boyfriendsong3"] = 0,
			["girlfriendsong3"] = 0,
			["sayorisong3"] = 0,
			["yurisong3"] = 0,
			["static"] = 0
		}
		song = 1

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
			enemy = love.filesystem.load("sprites/characters/silhouette_nat.lua")()
			enemy2 = love.filesystem.load("sprites/characters/Doki_NatSad_Assets.lua")()
			enemy3 = love.filesystem.load("sprites/characters/Doki_Home_Nat_Assets.lua")()
			enemy.x, enemy.y = -380, 270
			enemy2.x, enemy2.y = -380, 380
			enemy3.x, enemy3.y = -380, -30
			sayori = love.filesystem.load("sprites/characters/sayori.lua")()
			yuri = love.filesystem.load("sprites/characters/yuri.lua")()
			silhouette_gf = love.filesystem.load("sprites/characters/silhouette_gf.lua")()
			silhouette_gf.x, silhouette_gf.y = 30, 210
		end
		showStatic = false
	
		girlfriend.x, girlfriend.y = 30, 210
		
		boyfriend.x, boyfriend.y = 260, 410
		silhouette_bf.x, silhouette_bf.y = 260, 410
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

		silhouettes = {
			["enemy"] = {1,1,1},
			["boyfriend"] = {1,1,1},
			["girlfriend"] = {1,1,1},
			["sayori"] = {1,1,1},
			["yuri"] = {1,1,1}
		}

		-- stage stuffies --

		-- Clubroom
		clubroom = {
			mainBG = graphics.newImage(love.graphics.newImage(graphics.imagePath("ending/DDLCbg"))),
			farBG = graphics.newImage(love.graphics.newImage(graphics.imagePath("ending/DDLCfarbg"))),
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
		ruinedclub.mainBG.sizeX, ruinedclub.mainBG.sizeY = 1.15, 1.15
		ruinedclub.glitchFront.sizeX, ruinedclub.glitchFront.sizeY = 1.15, 1.15
		ruinedclub.glitchBack.sizeX, ruinedclub.glitchBack.sizeY = 1.15, 1.15
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

		function camZoom(time, num, name)
			local time = time or 0.5
			local num = num or 0.03
			local name = name or "default"
			if CAMTIMERS[name] then
				Timer.cancel(CAMTIMERS[name])
			end
			CAMTIMERS[name] = Timer.tween(
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
			if TIMERS[name] then
				Timer.cancel(TIMERS[name])
			end
			if wait then Timer.after(
				wait,
				function()
					TIMERS[name] = Timer.tween(
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
		closeUp = false
		inWhite = false
		love.graphics.setBackgroundColor(0,0,0)
		
		if song == 3 then
			inst = love.audio.newSource("songs/ending/home/Inst.ogg", "stream")
			voices = love.audio.newSource("songs/ending/home/Voices.ogg", "stream")
			clubroom = {
				mainBG = graphics.newImage(love.graphics.newImage(graphics.imagePath("ending/DDLCbg-Grayscale"))),
				farBG = graphics.newImage(love.graphics.newImage(graphics.imagePath("ending/DDLCfarbg-Grayscale"))),
				DesksFront = graphics.newImage(love.graphics.newImage(graphics.imagePath("ending/DesksFront-Grayscale")))
			}
			clubroom.mainBG.sizeX, clubroom.mainBG.sizeY = 1.4, 1.4
			clubroom.farBG.sizeX, clubroom.farBG.sizeY = 1.4, 1.4
			clubroom.DesksFront.sizeX, clubroom.DesksFront.sizeY = 1.4, 1.4
			for i = 1, 3 do
				silhouettes["enemy"][i] = 0
				silhouettes["boyfriend"][i] = 0
				silhouettes["girlfriend"][i] = 0
				silhouettes["sayori"][i] = 0.35
				silhouettes["yuri"][i] = 0.35
			end
			transparent["screen"] = 0
			enemy = love.filesystem.load("sprites/characters/silhouette_nat.lua")()
			enemy2 = love.filesystem.load("sprites/characters/Doki_NatSad_Assets.lua")()
			enemy3 = love.filesystem.load("sprites/characters/Doki_Home_Nat_Assets.lua")()
			enemy.x, enemy.y = -380, 270
			enemy2.x, enemy2.y = -380, 380
			enemy3.x, enemy3.y = -380, 380
			sayori = love.filesystem.load("sprites/characters/silhouette_sayo.lua")()
			yuri = love.filesystem.load("sprites/characters/silhouette_yuri.lua")()
			silhouette_gf = love.filesystem.load("sprites/characters/silhouette_gf.lua")()
			mGirlfriend = love.filesystem.load("sprites/characters/DDLCGF_Markov.lua")()
			silhouette_gf.x, silhouette_gf.y = 30, 210
			mGirlfriend.x, mGirlfriend.y = 30, 210
			boyfriend = love.filesystem.load("sprites/characters/HAPPYBoyFriend_Assets.lua")()
			boyfriend.x, boyfriend.y = 260, 410
			sayori.x = -500
			yuri.x = 500
			transparent["enemy"] = 1
			transparent["boyfriend"] = 1
			boyfriendHappy.x, boyfriendHappy.y = 260, 410
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
			girlfriend.x, girlfriend.y = 30, 230
			camZoom(0, 0.2)
			transparent["enemy"] = 0
			transparent["enemyStrum"] = 0
			transparent["screen"] = 1
			boyfriendIcon:animate("boyfriend sad", false)
			healthBarColorPlayer = {82, 115, 145}
			enemyIcon:animate("yuri closet", false)
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
		static:update(dt)
		if song == 3 then
			sayori:update(dt)
			yuri:update(dt)
		end
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
			elseif musicTime >= 220416 and musicTime <= 220466 then
				poemTransitionSwirl:animate("anim", false)
				finalTransition = true
				if not poemTransitionSwirl:isAnimated() then
					poemTransitionSwirl:animate("animFinal", true)
				end
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
				changeVisiblity("enemysong2", 1, 4, 8)
			end
			if musicTime >= 10787 and musicTime <= 10837 then 
				weeks:safeAnimate(enemy3, "appear", 2, false)
			end
			if musicTime >= 13150 and musicTime <= 13200 then
				changeVisiblity("enemyStrum", 1, 3, 0)
			end
			if musicTime >= 41404 and musicTime <= 41454 then
				changeVisiblity("enemysong2", 0, 4, 0.05)
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
			if musicTime >= 227227 and musicTime <= 227277 then
				weeks:safeAnimate(enemy4, "dies", false, 2, 30)
			end
			if closeUp then 
				cam.sizeX, cam.sizeY = 0.95, 0.95 
				cam.x, cam.y = -boyfriend.x + 100, -boyfriend.y + 150
			end
			if enemy4:getAnimName() == "dies" and not enemy4:isAnimated() then
				transparent["enemysong2"] = 0
			end
		elseif song == 3 then
			-- Home
			if musicTime <= 50 then
				transparent["screen"] = 0
				transparent["enemyStrum"] = 0
				transparent["boyfriendStrum"] = 0
			end
			if musicTime >= 3600 and musicTime <= 3670 then
				changeVisiblity("screen", 1, 5, 0)
			end
			if musicTime >= 9075 and musicTime <= 9155 then
				changeVisiblity("enemyStrum", 1, 1, 0)
			end
			if musicTime >= 9600 and musicTime <= 9670 then
				changeVisiblity("enemysong3", 1, 0.7, 0)
			end
			if musicTime >= 11400 and musicTime <= 11470 then
				changeVisiblity("boyfriendStrum", 1, 1, 0)
			end
			if musicTime >= 12000 and musicTime <= 12070 then
				changeVisiblity("boyfriendsong3", 1, 0.7, 0)
			end
			if musicTime >= 19200 and musicTime <= 19270 then
				changeVisiblity("girlfriendsong3", 1, 0.7, 0)
			end
			if musicTime >= 19275 and musicTime <= 19345 then -- baka doodles
			end
			if musicTime >= 28800 and musicTime <= 28900 then
				camZoom(5, 0.7)
			end
			if musicTime >= 33600 and musicTime <= 33670 then
				-- doodles
				changeVisiblity("enemyStrum", 0, 1, 0)
				changeVisiblity("boyfriendStrum", 0, 1, 0)
				changeVisiblity("boyfriendsong3", 0, 1, 0)
				changeVisiblity("girlfriendsong3", 0, 1, 0)
				changeVisiblity("enemysong3", 0, 1, 0)
			end
			if musicTime >= 35325 and musicTime <= 35395 then
				showStatic = true
				changeVisiblity("static", 0.2, 1.8, 0)
			end
			if musicTime >= 37200 and musicTime <= 37270 then
				changeVisiblity("static", 0.2, 0.25, 0)
				cam.sizeX, cam.sizeY = 0.95, 0.95
				changeVisiblity("enemyStrum", 1, 0, 0)
				changeVisiblity("boyfriendStrum", 1, 0, 0)
				changeVisiblity("boyfriendsong3", 1, 0, 0)
				changeVisiblity("girlfriendsong3", 1, 0, 0)
				changeVisiblity("enemysong3", 1, 0, 0)
			end
			if musicTime >= 56400 and musicTime <= 56470 then
				weeks:safeAnimate(enemy2, "eyes", false, 2)
				camZoom(0.2, 0.55)
			end
			if musicTime >= 114000 and musicTime <= 114070 then
				if camBallsTween then
					Timer.cancel(camBallsTween)
				end
				camBallsTween = Timer.tween(
					0.5,
					cam,
					{
						x = mGirlfriend.x,
						y = mGirlfriend.y - 70
					},
					"out-quad"
				)
				mGirlfriend:animate("end", false)
			end
			if musicTime >= 116400 and musicTime <= 116470 then
				mGirlfriend:animate("home", false)
			end

			if musicTime >= 180750 and musicTime <= 180820 then
				changeVisiblity("sayorisong3", 1, 0.7, 0)
			end
			if musicTime >= 195150 and musicTime <= 195220 then
				changeVisiblity("yurisong3", 1, 0.7, 0)
			end
			------------------------------------  Hard coded extra character animations ------------------------------------
			-- Sayori --
			if musicTime >= 175000 then
				if not sayori:isAnimated() then
					sayori:animate("idle")
				end
				if musicTime >= 181200 and musicTime <= 181950 then
					sayori:nanimate("up")
				end
				if musicTime >= 182025 and musicTime <= 182925 then
					sayori:nanimate("left")
				end
				if musicTime >= 183000 and musicTime <= 183525 then
					sayori:nanimate("up")
				end
				if musicTime >= 183600 and musicTime <= 183600 + 900 then
					sayori:nanimate("down")
				end
				if musicTime >= 184500 and musicTime <= 184500 + 825 then
					sayori:nanimate("up")
				end
				if musicTime >= 185400 and musicTime <= 185925 then
					sayori:nanimate("left")
				end
				if musicTime >= 186000 and musicTime <= 186000 + 1125 then
					sayori:nanimate("right")
				end
				if musicTime >= 187200 and musicTime <= 187200 + 1125 then
					sayori:nanimate("down")
				end
				if musicTime >= 188400 and musicTime <= 188400 + 1125 then
					sayori:nanimate("left")
				end
				if musicTime >= 189600 and musicTime <= 189600 + 1125 then
					sayori:nanimate("right")
				end
				if musicTime >= 190800 and musicTime <= 190800 + 1125 then
					sayori:nanimate("down")
				end
				if musicTime >= 192000 and musicTime <= 192000 + 1125 then
					sayori:nanimate("right")
				end
				if musicTime >= 193200 and musicTime <= 193200+ 1125 then
					sayori:nanimate("up")
				end
				if musicTime >= 194400 and musicTime <= 194400+ 1125 then
					sayori:nanimate("down")
				end
				if musicTime >= 198000 and musicTime <= 198000 + 825 then
					sayori:nanimate("left")
				end
				if musicTime >= 198900 and musicTime <= 198900 + 1425 then
					sayori:nanimate("up")
				end
				if musicTime >= 200400 and musicTime <= 200400 + 2325 then
					sayori:nanimate("left")
				end
				if musicTime >= 202800 and musicTime <= 202800 + 2325 then
					sayori:nanimate("down")
				end
				if musicTime >= 205200 and musicTime <= 205725 then
					sayori:nanimate("left")
				end
				if musicTime >= 205800 and musicTime <= 205800 + 525 then
					sayori:nanimate("right")
				end
				if musicTime >= 206400 and musicTime <= 206400 + 525 then
					sayori:nanimate("down")
				end
				if musicTime >= 207000 and musicTime <= 207525 then
					sayori:nanimate("left")
				end
				if musicTime >= 207600 and musicTime <= 207600 + 525 then
					sayori:nanimate("up")
				end
				if musicTime >= 208200 and musicTime <= 208725 then
					sayori:nanimate("left")
				end
				if musicTime >= 208800 and musicTime <= 208800 + 225 then
					sayori:nanimate("right")
				end
				if musicTime >= 209100 and musicTime <= 209250 then
					sayori:nanimate("down")
				end
				if musicTime >= 209325 and musicTime <= 209925 then
					sayori:nanimate("up")
				end
				if musicTime >= 210825 and musicTime <= 210875 then
					sayori:nanimate("down")
				end
				if musicTime >= 210525 and musicTime <= 210575 then
					sayori:nanimate("right")
				end
				if musicTime >= 210300 and musicTime <= 210350 then
					sayori:nanimate("left")
				end
				if musicTime >= 210000 and musicTime <= 210050 then
					sayori:nanimate("right")
				end
				if musicTime >= 211425 and musicTime <= 211475 then
					sayori:nanimate("right")
				end
				if musicTime >= 211200 and musicTime <= 211250 then
					sayori:nanimate("left")
				end
				if musicTime >= 211800 and musicTime <= 211850 then
					sayori:nanimate("down")
				end
				if musicTime >= 212100 and musicTime <= 212150 then
					sayori:nanimate("up")
				end
				if musicTime >= 212400 and musicTime <= 212550 then
					sayori:nanimate("down")
				end
				if musicTime >= 213000 and musicTime <= 213150 then
					sayori:nanimate("right")
				end
				if musicTime >= 212700 and musicTime <= 212850 then
					sayori:nanimate("left")
				end
				if musicTime >= 213300 and musicTime <= 213450 then
					sayori:nanimate("down")
				end
				if musicTime >= 213600 and musicTime <= 213750 then
					sayori:nanimate("left")
				end
				if musicTime >= 213900 and musicTime <= 214050 then
					sayori:nanimate("right")
				end
				if musicTime >= 214200 and musicTime <= 214050 then
					sayori:nanimate("left")
				end
				if musicTime >= 214500 and musicTime <= 214650 then
					sayori:nanimate("up")
				end
				-- Yuri --
				if not yuri:isAnimated() then
					yuri:animate("idle")
				end
				if musicTime >= 195600 and musicTime <= 195600 then
					yuri:nanimate("left")
				end
				if musicTime >= 196500 and musicTime <= 196550 then
					yuri:nanimate("left")
				end
				if musicTime >= 195900 and musicTime <= 195950 then
					yuri:nanimate("up")
				end
				if musicTime >= 196200 and musicTime <= 196250 then
					yuri:nanimate("down")
				end
				if musicTime >= 197100 and musicTime <= 197150 then
					yuri:nanimate("down")
				end
				if musicTime >= 196800 and musicTime <= 196850 then
					yuri:nanimate("right")
				end
				if musicTime >= 197400 and musicTime <= 197450 then
					yuri:nanimate("left")
				end
				if musicTime >= 197700 and musicTime <= 197750 then
					yuri:nanimate("down")
				end
			end
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
		if input:pressed("BALLS") then
			inst:stop()
			voices:stop()
			song = song + 1

			self:load()
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
					if song == 1 then
						if (musicTime <= 23999) or song == 1 and (musicTime >= 45333 and musicTime <= 66666) then
							clubroom.farBG:draw()
							clubroom.mainBG:draw()
						end
					elseif song == 3 then
						graphics.setColor(1,1,1,transparent["screen"])
						if musicTime <= 33600 then
							clubroom.farBG:draw()
							clubroom.mainBG:draw()
						elseif musicTime >= 33600 and musicTime <= 37200 then
							paperBG:draw()
						elseif musicTime >= 37200 and musicTime <= 135600 then
							clubroom2.sky:draw()
							clubroom2.mainBG:draw()
						elseif musicTime >= 135600 and musicTime <= 154800 then
							static:draw()
							ruinedclub.glitchBack:draw()
							ruinedclub.mainBG:draw()
							ruinedclub.glitchFront:draw()
						elseif musicTime >= 154800 and musicTime <= 164400 then
							notepad.notepad:draw()
							notepad.notepadOverlay:draw()
						elseif musicTime >= 164400 and musicTime <= 176400 then
							static:draw()
							ruinedclub.glitchBack:draw()
							ruinedclub.mainBG:draw()
							ruinedclub.glitchFront:draw()
						end
						graphics.setColor(1,1,1)
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
					elseif song == 3 then
						if musicTime <= 33600 or musicTime >= 176400 then
							graphics.setColor(silhouettes["girlfriend"][1], silhouettes["girlfriend"][2], silhouettes["girlfriend"][3], transparent["girlfriendsong3"])
							silhouette_gf:draw()
							graphics.setColor(1,1,1)
						end
						if (musicTime >= 37200 and musicTime <= 154800) or (musicTime >= 164400 and musicTime <= 176400)  then
							mGirlfriend:draw()
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
						graphics.setColor(1,1,1,1)
						dontDrawBF = true
						sadTime = false
					end
					if (musicTime >= 44486 and musicTime <= 46027) or (musicTime >= 85927 and musicTime <= 125227) or (musicTime >= 182452 and musicTime <= 216427) or (musicTime >= 216727 and musicTime <= 217627) or (musicTime >= 217927 and musicTime <= 218827) or (musicTime >= 219127 and musicTime <= 220027) or (musicTime >= 220327 and musicTime <= 221227) or (musicTime >= 221527 and musicTime <= 222427) or (musicTime >= 222727 and musicTime <= 223627) or (musicTime >= 223927 and musicTime <= 224827) then
						enemyIcon:animate("yuri glitch", false)
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
					if musicTime <= 33600 or musicTime >= 176400 then
						if musicTime >= 176400 then
							cam.sizeX, cam.sizeY = 0.95, 0.95
						end
						-- sillhouets
						graphics.setColor(silhouettes["sayori"][1], silhouettes["sayori"][2], silhouettes["sayori"][3], transparent["sayorisong3"])
						sayori:draw()
						graphics.setColor(silhouettes["yuri"][1], silhouettes["yuri"][2], silhouettes["yuri"][3], transparent["yurisong3"])
						yuri:draw()
						graphics.setColor(silhouettes["enemy"][1], silhouettes["enemy"][2], silhouettes["enemy"][3], transparent["enemysong3"])
						enemy:draw()
						graphics.setColor(silhouettes["boyfriend"][1], silhouettes["boyfriend"][2], silhouettes["boyfriend"][3], transparent["boyfriendsong3"])
						silhouette_bf:draw()
						graphics.setColor(1,1,1)
					end		
					if musicTime >=	37200 and musicTime <= 135600 then
						graphics.setColor(1,1,1,transparent["enemy"])
						if musicTime >= 58800 and musicTime <= 97275 then 
							if BALLSTWEEN then
								Timer.cancel(BALLSTWEEN)
							else
								enemy2:animate("idle", false)
							end
							BALLSTWEEN = Timer.tween(
								0.35,
								enemy3,
								{
									x = 25
								},
								"out-quad"
							)		
							for i = 1, 3 do
								silhouettes["enemy"][i] = 0.85
								silhouettes["boyfriend"][i] = 0.85
								silhouettes["girlfriend"][i] = 0.35
								silhouettes["sayori"][i] = 0.35
								silhouettes["yuri"][i] = 0.35
							end
						elseif musicTime <= 116400 and musicTime >= 97275 then 
							enemy2:draw()
						end
						if musicTime <= 58800 and musicTime <= 116400 then
							enemy2:draw()
						elseif musicTime >= 58800 and musicTime <= 97275 then
							enemy3:draw()
						end
						if musicTime <= 116400 then
							boyfriendSad:draw()
						else
							boyfriend:draw()
						end
					end
					if musicTime >= 116400 and musicTime <= 154800 then
						enemy3:draw()
					end
					graphics.setColor(1,1,1,transparent["boyfriend"])
					if musicTime >= 135600 and musicTime <= 154800 then
						enemy3:draw()
						boyfriend:draw()
					end
					if musicTime >= 154800 and musicTime <= 164400 then
						transparent["static"] = 0
						boyfriendHappy:draw()
					end
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
			if showStatic then
				graphics.setColor(1,1,1,transparent["static"])
				static:draw()
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
