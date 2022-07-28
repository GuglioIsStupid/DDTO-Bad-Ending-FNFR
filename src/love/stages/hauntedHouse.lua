return {
    enter = function()
        stageImages = {
            love.filesystem.load("sprites/week2/haunted-house.lua")() -- Haunted House
        }
        
		enemy = love.filesystem.load("sprites/week2/skid-and-pump.lua")()

		girlfriend.x, girlfriend.y = -200, 50
		enemy.x, enemy.y = -610, 140
		boyfriend.x, boyfriend.y = 30, 240
    end,

    load = function()
    end,

    update = function(self, dt)
        stageImages[1]:update(dt)
        if not stageImages[1]:isAnimated() then
			stageImages[1]:animate("normal", false)
		end
        if song == 1 and musicThres ~= oldMusicThres and math.fmod(absMusicTime, 60000 * (love.math.random(17) + 7) / bpm) < 100 then
			audio.playSound(sounds["thunder"][love.math.random(2)])

			stageImages[1]:animate("lightning", false)
			weeks:safeAnimate(girlfriend, "fear", true, 1)
			weeks:safeAnimate(boyfriend, "shaking", true, 3)
		end
    end,

    draw = function()
        love.graphics.push()
			love.graphics.translate(cam.x * 0.9, cam.y * 0.9)

			stageImages[1]:draw()
			girlfriend:draw()
		love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(cam.x, cam.y)

			enemy:draw()
			boyfriend:draw()
		love.graphics.pop()
    end,

    leave = function()
        stageImages[1] = nil
    end
}