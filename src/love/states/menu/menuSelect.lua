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

local leftFunc, rightFunc, confirmFunc, backFunc, drawFunc

local menuState

local menuButton

local selectSound = love.audio.newSource("sounds/menu/select.ogg", "static")
local confirmSound = love.audio.newSource("sounds/menu/confirm.ogg", "static")

local function switchMenu(menu)
	menuState = 1
end

return {
	enter = function(self, previous)
        changingMenu = false
        function tweenButtons()
            if story.y == 400 then
                Timer.tween(1, story, {y = -200}, "out-expo")
            end
            if freeplay.y == 400 then
                Timer.tween(1, freeplay, {y = 0}, "out-expo")
            end
            if story.y == 400 then
                Timer.tween(1, options, {y = 200}, "out-expo")
            end
            Timer.tween(0.3, titleBG, {y = 15}, "out-quad")
        end
		menuButton = 1
		songNum = 0
        titleBG = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/menuBG")))

        titleBG.sizeX, titleBG.sizeY = 1.15

        options = love.filesystem.load("sprites/menu/menuButtons.lua")()
        story = love.filesystem.load("sprites/menu/menuButtons.lua")()
        freeplay = love.filesystem.load("sprites/menu/menuButtons.lua")()
        story:animate("story hover", true)
        freeplay:animate("freeplay", true)
        options:animate("options", true)

        story.y = 400
        freeplay.y = 400
        options.y = 400
        tweenButtons()

		cam.sizeX, cam.sizeY = 0.9, 0.9
		camScale.x, camScale.y = 0.9, 0.9
        Timer.after(
            0.8,
            function()
                Timer.tween(
                    0.42,
                    camScale,
                    {
                        x = 1,
                        y = 1
                    },
                    "out-expo"
                )
            end
        )
        

		switchMenu(1)

		graphics.setFade(0)
		graphics.fadeIn(0.5)

        if useDiscordRPC then
            presence = {
                state = "Choosing a mode",
                details = "In the Main Menu",
                largeImageKey = "logo",
                startTimestamp = now,
            }
            nextPresenceUpdate = 0
        end

	end,

	update = function(self, dt)
        options:update(dt)
        story:update(dt)
        freeplay:update(dt)

        if not music:isPlaying() then
			music:play()
		end

		if not graphics.isFading() then
			if input:pressed("up") then
				audio.playSound(selectSound)

                if menuButton ~= 1 then
                    menuButton = menuButton - 1
                else
                    menuButton = 3
                end -- change 3 to the amount of options there are.

                if menuButton == 1 then
                    story:animate("story hover", true)
                    freeplay:animate("freeplay", true)
                    options:animate("options", true)

                    Timer.tween(0.3, titleBG, {y = 15}, "out-quad")
                elseif menuButton == 2 then
                    story:animate("story", true)
                    freeplay:animate("freeplay hover", true)
                    options:animate("options", true)

                    Timer.tween(0.3, titleBG, {y = 0}, "out-quad")
                elseif menuButton == 3 then
                    story:animate("story", true)
                    freeplay:animate("freeplay", true)
                    options:animate("options hover", true)

                    Timer.tween(0.3, titleBG, {y = -15}, "out-quad")
                end

			elseif input:pressed("down") then
				audio.playSound(selectSound)

                if menuButton ~= 3 then
                    menuButton = menuButton + 1
                else
                    menuButton = 1
                end

                if menuButton == 1 then
                    story:animate("story hover", true)
                    freeplay:animate("freeplay", true)
                    options:animate("options", true)

                    Timer.tween(0.3, titleBG, {y = 15}, "out-quad")
                elseif menuButton == 2 then
                    story:animate("story", true)
                    freeplay:animate("freeplay hover", true)
                    options:animate("options", true)

                    Timer.tween(0.3, titleBG, {y = 0}, "out-quad")
                elseif menuButton == 3 then
                    story:animate("story", true)
                    freeplay:animate("freeplay", true)
                    options:animate("options hover", true)

                    Timer.tween(0.3, titleBG, {y = -15}, "out-quad")
                end

			elseif input:pressed("confirm") then
				audio.playSound(confirmSound)

				--confirmFunc()
                if menuButton == 1 then
                    status.setLoading(true)
                    graphics.fadeOut(
                        0.3,
                        function()
                            Gamestate.switch(cutscene.intro)
                            status.setLoading(false)
                        end
	            	)
                    Timer.tween(0.9, story, {y = 0}, "out-expo")
                    Timer.tween(0.9, freeplay, {y = 700}, "out-expo")
                    Timer.tween(0.9, options, {y = 700}, "out-expo")
                elseif menuButton == 2 then
                    status.setLoading(true)
                    graphics.fadeOut(
                        0.3,
                        function()
                            Gamestate.switch(menuFreeplay)
                            status.setLoading(false)
                        end
	            	)
                    Timer.tween(0.9, story, {y = -700}, "out-expo")
                    Timer.tween(0.9, options, {y = 700}, "out-expo")
                elseif menuButton == 3 then
                    status.setLoading(true)
                    graphics.fadeOut(
                        0.3,
                        function()
                            Gamestate.switch(menuSettings)
                            status.setLoading(false)
                        end
	            	)
                    Timer.tween(0.9, freeplay, {y = -700}, "out-expo")
                    Timer.tween(0.9, options, {y = 0}, "out-expo")
                    Timer.tween(0.9, story, {y = -700}, "out-expo")
                end
                Timer.tween(1.1, camScale, {x = 4, y = 4}, "linear")
			elseif input:pressed("back") then
				audio.playSound(selectSound)

				Gamestate.switch(menu)
			end
		end
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)

            love.graphics.push()
                love.graphics.scale(camScale.x, camScale.y)
			    titleBG:draw()
            love.graphics.pop()

            story:draw()
            options:draw()
            freeplay:draw()

			love.graphics.push()
				love.graphics.scale(cam.sizeX, cam.sizeY)
                love.graphics.color.printf(
                    "Vanilla Engine v1.0.0 pre-release 1" ..
                    "\nFNFR: v1.1.0-beta2",
                    -708,
                    340, 
                    833,
                    "left", 
                    nil, 
                    1, 
                    1, 
                    0, --R
                    0, --G
                    0, --B
                    1  --A
                )
			love.graphics.pop()
		love.graphics.pop()
	end,

	leave = function(self)
        titleBG = nil
        story = nil
        freeplay = nil
        options = nil
		Timer.clear()
	end
}