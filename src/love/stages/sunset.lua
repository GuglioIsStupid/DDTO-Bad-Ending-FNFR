return {
    enter = function() -- TODO: Fix this stage
        stageImages = {
            graphics.newImage(love.graphics.newImage(graphics.imagePath("week4/sunset"))),
            love.filesystem.load("sprites/week4/bg-limo.lua")(), -- bg-limo
            love.filesystem.load("sprites/week4/limo-dancer.lua")(), -- limo-dancer
            love.filesystem.load("sprites/week4/limo.lua")() -- limo
        }
        girlfriend = love.filesystem.load("sprites/week4/girlfriend.lua")()
        enemy = love.filesystem.load("sprites/week4/mommy-mearest.lua")()
        boyfriend = love.filesystem.load("sprites/week4/boyfriend.lua")()
        fakeBoyfriend = love.filesystem.load("sprites/boyfriend.lua")() -- Used for game over

        fakeBoyfriend.x, fakeBoyfriend.y = 350, -100
        stageImages[1].y = 250
        stageImages[2].y = -130
        stageImages[3].y = 375
        girlfriend.x, girlfriend.y = 30, -50
        enemy.x, enemy.y = -380, -10
        boyfriend.x, boyfriend.y = 340, -100
    end,

    load = function()

    end,

    update = function(self, dt)
        stageImages[2]:update(dt)
		stageImages[3]:update(dt)
		stageImages[4]:update(dt)

        if musicThres ~= oldMusicThres and math.fmod(absMusicTime, 120000 / bpm) < 100 then
			stageImages[3]:animate("anim", false)

			stageImages[3]:setAnimSpeed(14.4 / (60 / bpm))
		end
    end,

    draw = function()
        love.graphics.push()
			love.graphics.translate(cam.x * 0.5, cam.y * 0.5)

			stageImages[1]:draw()

			stageImages[2]:draw()
			for i = -475, 725, 400 do
				stageImages[3].x = i

				stageImages[3]:draw()
			end
		love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(cam.x, cam.y)

			girlfriend:draw()
			stageImages[4]:draw()
			enemy:draw()
			boyfriend:draw()
		love.graphics.pop()
    end,

    leave = function()
        stageImages[1] = nil
        stageImages[2] = nil
        stageImages[3] = nil
        stageImages[4] = nil
    end
}