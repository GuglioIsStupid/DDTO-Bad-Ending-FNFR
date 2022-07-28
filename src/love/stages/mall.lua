return {
    enter = function()
        if song ~= 3 then
            stageImages = {
                graphics.newImage(love.graphics.newImage(graphics.imagePath("week5/walls"))), -- walls
			    graphics.newImage(love.graphics.newImage(graphics.imagePath("week5/escalator"))), -- escalator
			    graphics.newImage(love.graphics.newImage(graphics.imagePath("week5/christmas-tree"))), -- christmas tree
			    graphics.newImage(love.graphics.newImage(graphics.imagePath("week5/snow"))) -- snow
            }

			stageImages[2].x = 125
			stageImages[3].x = 75
			stageImages[4].y = 850
			stageImages[4].sizeX, stageImages[4].sizeY = 2, 2

			stageImages[5] = love.filesystem.load("sprites/week5/top-bop.lua")() -- top-bop
			stageImages[6] = love.filesystem.load("sprites/week5/bottom-bop.lua")() -- bottom-bop
			stageImages[7] = love.filesystem.load("sprites/week5/santa.lua")() -- santa

			stageImages[5].x, stageImages[5].y = 60, -250
			stageImages[6].x, stageImages[6].y = -75, 375
			stageImages[7].x, stageImages[7].y = -1350, 410
		end
        girlfriend = love.filesystem.load("sprites/week5/girlfriend.lua")()
		enemy = love.filesystem.load("sprites/week5/dearest-duo.lua")()
		boyfriend = love.filesystem.load("sprites/week5/boyfriend.lua")()
		fakeBoyfriend = love.filesystem.load("sprites/boyfriend.lua")() -- Used for game over

		girlfriend.x, girlfriend.y = -50, 410
		enemy.x, enemy.y = -780, 410
		boyfriend.x, boyfriend.y = 300, 620
		fakeBoyfriend.x, fakeBoyfriend.y = 300, 620
    end,

    load = function(self)
        if song == 3 then
            camScale.x, camScale.y = 0.9, 0.9
    
            if scaryIntro then
                cam.x, cam.y = -150, 750
                cam.sizeX, cam.sizeY = 2.5, 2.5
    
                graphics.setFade(1)
            else
                cam.sizeX, cam.sizeY = 0.9, 0.9
            end
    
            stageImages[1] = graphics.newImage(love.graphics.newImage(graphics.imagePath("week5/evil-bg"))) -- evil-bg
            stageImages[3] = graphics.newImage(love.graphics.newImage(graphics.imagePath("week5/evil-tree"))) -- evil-tree
            stageImages[4] = graphics.newImage(love.graphics.newImage(graphics.imagePath("week5/evil-snow"))) -- evil-snow
    
            stageImages[1].y = -250
            stageImages[3].x = 75
            stageImages[3].sizeX, stageImages[3].sizeY = 0.5, 0.5
            stageImages[4].x, stageImages[4].y = -50, 770
    
        end
    end,

    update = function(self, dt)
        if song ~= 3 then
            stageImages[5]:update(dt)
            stageImages[6]:update(dt)
            stageImages[7]:update(dt)

            if musicThres ~= oldMusicThres and math.fmod(absMusicTime, 60000 / bpm) < 100 then
                stageImages[5]:animate("anim", false)
                stageImages[6]:animate("anim", false)
                stageImages[7]:animate("anim", false)
            end
        end
    end,

    draw = function()
        love.graphics.push()
			love.graphics.translate(cam.x * 0.5, cam.y * 0.5)

			stageImages[1]:draw()
			if song ~= 3 then
				stageImages[5]:draw()
				stageImages[2]:draw()
			end
			stageImages[3]:draw()
		love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(cam.x * 0.9, cam.y * 0.9)

			if song ~= 3 then
				stageImages[2]:draw()
			end

			stageImages[4]:draw()

			girlfriend:draw()
		love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(cam.x, cam.y)

			if song ~= 3 then
				stageImages[7]:draw()
			end
			enemy:draw()
			boyfriend:draw()
		love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(cam.x * 1.1, cam.y * 1.1)
		love.graphics.pop()
    end,

    drawUI = function()
        love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
			love.graphics.scale(0.7, 0.7)

			love.graphics.push()
				love.graphics.translate(-graphics.getWidth() / 2 - 240, -graphics.getHeight() / 2 - 75)
				love.graphics.scale(1.37,1.37)
				love.graphics.setColor(0,0,0,settings.scrollUnderlayTrans)
				if settings.middleScroll then
					love.graphics.rectangle("fill", 400, -100, 90 + 170 * 2.35, 1000)
				else
					love.graphics.rectangle("fill", 755, -100, 90 + 170 * 2.35, 1000)
				end
				love.graphics.setColor(1,1,1,1)
			love.graphics.pop()
			for i = 1, 4 do
				if enemyArrows[i]:getAnimName() == "off" then
					graphics.setColor(0.6, 0.6, 0.6)
				end
				if settings.middleScroll then
					love.graphics.setColor(0.6,0.6,0.6,0.3)
				end
				enemyArrows[i]:draw()
				graphics.setColor(1, 1, 1)
				boyfriendArrows[i]:draw()

				if hitSick then
					if input:pressed("gameLeft") then
						leftArrowSplash:animate("left")
					elseif input:pressed("gameRight") then
						rightArrowSplash:animate("right")
					elseif input:pressed("gameUp") then
						upArrowSplash:animate("up")
					elseif input:pressed("gameDown") then
						downArrowSplash:animate("down")
					end
				end
				if leftArrowSplash:isAnimated() then
					leftArrowSplash:draw()
				elseif rightArrowSplash:isAnimated() then
					rightArrowSplash:draw()
				elseif upArrowSplash:isAnimated() then
					upArrowSplash:draw()
				elseif downArrowSplash:isAnimated() then
					downArrowSplash:draw()
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
                                love.graphics.setColor(1,1,1,0.3)
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

				boyfriendIcon:draw()
				enemyIcon:draw()

				weeks:drawHealthBar()

				graphics.setColor(1, 1, 1, countdownFade[1])
				countdown:draw()
				graphics.setColor(1, 1, 1)
			love.graphics.pop()
    end,

    leave = function()
		stageImages[1] = nil
		stageImages[2] = nil
		stageImages[3] = nil
		stageImages[4] = nil
		stageImages[5] = nil
		stageImages[6] = nil
		stageImages[7] = nil
    end
}