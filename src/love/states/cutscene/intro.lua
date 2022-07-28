return {
    enter = function(self)
        cutscene = love.graphics.newVideo("videos/intro.ogv")
        menu:musicStop()
        --cutscene:play()
        storyMode = true

        graphics.fadeIn(0.8)
    end,
    update = function(self, dt)
        if not graphics.isFading() and not cutscene:isPlaying() then
            status.setLoading(true)
            graphics.fadeOut(
                0.8,
                function()
                    Gamestate.switch(endingWeek)
                    status.setLoading(false)
                end
            )
        end
    end,
    draw = function(self)
        if cutscene:isPlaying() then
            love.graphics.draw(cutscene, 0, 0)
        end
    end
}