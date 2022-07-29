return {
    enter = function()
        stageImages = {
            graphics.newImage(love.graphics.newImage(graphics.imagePath("week1/stage-back"))), -- stage-back
		    graphics.newImage(love.graphics.newImage(graphics.imagePath("week1/stage-front"))), -- stage-front
		    graphics.newImage(love.graphics.newImage(graphics.imagePath("week1/curtains"))) -- curtains
        }

        stageImages[2].y = 400
        stageImages[3].y = -100

        
    end,

    load = function()

    end,

    update = function(self, dt)
    end,

    draw = function()
        love.graphics.push()
			love.graphics.translate(cam.x * 0.9, cam.y * 0.9)

			stageImages[1]:draw()
			stageImages[2]:draw()

            if not notebookTime then
			    girlfriend:draw()
            end
		love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(cam.x, cam.y)

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

			stageImages[3]:draw()
		love.graphics.pop()
    end,

    leave = function()
        stageImages[1] = nil
        stageImages[2] = nil
        stageImages[3] = nil
    end
}