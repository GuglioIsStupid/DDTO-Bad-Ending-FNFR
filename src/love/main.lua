--[[----------------------------------------------------------------------------
Friday Night Funkin' Rewritten v1.1.0 beta 2

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
if love.system.getOS() == "Windows" and love.filesystem.isFused() then -- Delete this if statement if you don't want Discord RPC
	useDiscordRPC = true
	discordRPC = require "lib.discordRPC"
	appId = require "lib.applicationID"
end
love.graphics.color = {}
color = {}

volFade = 0
function HSL(h, s, l, a)
	if s<=0 then return l,l,l,a end
	h, s, l = h*6, s, l
	local c = (1-math.abs(2*l-1))*s
	local x = (1-math.abs(h%2-1))*c
	local m,r,g,b = (l-.5*c), 0,0,0
	if h < 1     then r,g,b = c,x,0
	elseif h < 2 then r,g,b = x,c,0
	elseif h < 3 then r,g,b = 0,c,x
	elseif h < 4 then r,g,b = 0,x,c
	elseif h < 5 then r,g,b = x,0,c
	else              r,g,b = c,0,x
	end return r+m, g+m, b+m, a
end
function uitextf(text,x,y,limit,align,r,sx,sy,ox,oy,kx,ky)
	local x = x or 0
	local y = y or 0
	local r = r or 0
	local limit = limit or 750
	local align = align or "left"
	local sx = sx or 1
	local sy = sy or 1
	local ox = ox or 0
	local oy = oy or 0
	local kx = kx or 0
	local ky = ky or 0
	graphics.setColor(0,0,0)
	love.graphics.printf(text,x-2,y,limit,align,r,sx,sy,ox,oy,kx,ky)
	love.graphics.printf(text,x+2,y,limit,align,r,sx,sy,ox,oy,kx,ky)
	love.graphics.printf(text,x,y-2,limit,align,r,sx,sy,ox,oy,kx,ky)
	love.graphics.printf(text,x,y+2,limit,align,r,sx,sy,ox,oy,kx,ky)
	graphics.setColor(1,1,1)
    love.graphics.printf(text,x,y,limit,align,r,sx,sy,ox,oy,kx,ky)
end
function uitext(text,x,y,r,sx,sy,ox,oy,kx,ky)
	local x = x or 0
	local y = y or 0
	local r = r or 0
	local sx = sx or 1
	local sy = sy or 1
	local ox = ox or 0
	local oy = oy or 0
	local kx = kx or 0
	local ky = ky or 0
	graphics.setColor(0,0,0)
	love.graphics.print(text,x-2,y,r,sx,sy,a,ox,oy,kx,ky)
	love.graphics.print(text,x+2,y,r,sx,sy,a,ox,oy,kx,ky)
	love.graphics.print(text,x,y-2,r,sx,sy,a,ox,oy,kx,ky)
	love.graphics.print(text,x,y+2,r,sx,sy,a,ox,oy,kx,ky)
	graphics.setColor(1,1,1)
    love.graphics.print(text,x,y,r,sx,sy,a,ox,oy,kx,ky)
end
function love.load()
	local curOS = love.system.getOS()

	local selectSound = love.audio.newSource("sounds/menu/select.ogg", "static")
	local confirmSound = love.audio.newSource("sounds/menu/confirm.ogg", "static")

	-- Load libraries
	baton = require "lib.baton"
	ini = require "lib.ini"
	lovesize = require "lib.lovesize"
	Gamestate = require "lib.gamestate"
	Timer = require "lib.timer"
	lume = require "lib.lume"

	-- Load modules
	status = require "modules.status"
	audio = require "modules.audio"
	graphics = require "modules.graphics"

	-- Load settings
	settings = require "settings"
	input = require "input"

	-- Load states
	clickStart = require "states.click-start"

	debugMenu = require "states.debug.debugMenu"
	spriteDebug = require "states.debug.sprite-debug"
	stageDebug = require "states.debug.stage-debug"
	
	-- Load menus
	menu = require "states.menu.menu"
	menuWeek = require "states.menu.menuWeek"
	menuSelect = require "states.menu.menuSelect"
	menuFreeplay = require "states.menu.menuFreeplay"
	menuSettings = require "states.menu.menuSettings"

	-- Load stages
	stages = {
		["clubroom"] = require "stages.stage"
	}

	-- Load weeks
	weeks = require "states.weeks.weeks"
	weeks7 = require "states.weeks.weeks7" -- Week7 goes slkjdfhbskdljgfbskdjfgb so it uses a new weeks file
	weeks_test = require "states.weeks.week_test" -- Not updated, just used when I want to fuck around - Guglio

	-- Load substates
	gameOver = require "substates.game-over"

	uiTextColour = {1,1,1} -- Set a custom UI colour (Put it in the weeks file to change it for only that week)
	-- When adding custom colour for the health bar. Make sure to use 255 RGB values. It will automatically convert it for you.
	healthBarColorPlayer = {49,176,209} -- BF's icon colour
	healthBarColorEnemy = {165,0,77} -- GF's icon colour
	pauseColor = {0,0,0} -- Pause screen colour

	function setDialogue(strList)
		dialogueList = strList
		curDialogue = 1
		timer = 0
		progress = 1
		output = ""
		isDone = false
	end

	function volumeControl()
		-- ch's volume control stuff
		love.graphics.setColor(1, 1, 1, volFade)
		local fixVol = string.format(
			"%.1f  ",
			(love.audio.getVolume())
		)
		love.graphics.setColor(0.5, 0.5, 0.5, volFade - 0.3)

		love.graphics.rectangle("fill", 490, 0, 161, 50)

		love.graphics.setColor(1, 1, 1, volFade)

		if tonumber(fixVol) >= 0.1 then
			love.graphics.rectangle("fill", 500, 0, 8, 40)
		end
		if tonumber(fixVol) >= 0.2 then
			love.graphics.rectangle("fill", 515, 0, 8, 40)
		end
		if tonumber(fixVol) >= 0.3 then
			love.graphics.rectangle("fill", 530, 0, 8, 40)
		end
		if tonumber(fixVol) >= 0.4 then
			love.graphics.rectangle("fill", 545, 0, 8, 40)
		end
		if tonumber(fixVol) >= 0.5 then
			love.graphics.rectangle("fill", 560, 0, 8, 40)
		end
		if tonumber(fixVol) >= 0.6 then
			love.graphics.rectangle("fill", 575, 0, 8, 40)
		end
		if tonumber(fixVol) >= 0.7 then
			love.graphics.rectangle("fill", 590, 0, 8, 40)
		end
		if tonumber(fixVol) >= 0.8 then
			love.graphics.rectangle("fill", 605, 0, 8, 40)
		end
		if tonumber(fixVol) >= 0.9 then
			love.graphics.rectangle("fill", 620, 0, 8, 40)
		end
		if tonumber(fixVol) >= 1 then
			love.graphics.rectangle("fill", 635, 0, 8, 40)
		end
		love.graphics.setColor(1, 1, 1, 1)
	end

	-- Load week data
	endingWeek = require "weeks.ending"
	cutscene = {
		intro = require "states.cutscene.intro"
	}

	noteskins = {
		"arrows",
		"circles"
	}

	testSong = require "weeks.test" -- Test song easter egg

	-- You don't need to mess with this unless you are adding a custom setting (Will nil be default (AKA. False)) --
	if love.filesystem.getInfo("settings") then 
		file = love.filesystem.read("settings")
        data = lume.deserialize(file)
		settings.hardwareCompression = data.saveSettingsMoment.hardwareCompression
		settings.downscroll = data.saveSettingsMoment.downscroll
		settings.ghostTapping = data.saveSettingsMoment.ghostTapping
		settings.showDebug = data.saveSettingsMoment.showDebug
		graphics.setImageType(data.saveSettingsMoment.setImageType)
		settings.sideJudgements = data.saveSettingsMoment.sideJudgements
		settings.botPlay = data.saveSettingsMoment.botPlay
		settings.middleScroll = data.saveSettingsMoment.middleScroll
		settings.randomNotePlacements = data.saveSettingsMoment.randomNotePlacements
		settings.practiceMode = data.saveSettingsMoment.practiceMode
		settings.noMiss = data.saveSettingsMoment.noMiss
		settings.customScrollSpeed = data.saveSettingsMoment.customScrollSpeed
		settings.keystrokes = data.saveSettingsMoment.keystrokes
		settings.scrollUnderlayTrans = data.saveSettingsMoment.scrollUnderlayTrans
		settings.instVol = data.saveSettingsMoment.instVol
		settings.vocalsVol = data.saveSettingsMoment.vocalsVol
		settings.hitsounds = data.saveSettingsMoment.hitsounds
		settings.hitsoundVol = data.saveSettingsMoment.hitsoundVol
		settings.noteSkins = data.saveSettingsMoment.noteSkins

		settingsVer = data.saveSettingsMoment.settingsVer

		data.saveSettingsMoment = {
			hardwareCompression = settings.hardwareCompression,
			downscroll = settings.downscroll,
			ghostTapping = settings.ghostTapping,
			showDebug = settings.showDebug,
			setImageType = "dds",
			sideJudgements = settings.sideJudgements,
			botPlay = settings.botPlay,
			middleScroll = settings.middleScroll,
			randomNotePlacements = settings.randomNotePlacements,
			practiceMode = settings.practiceMode,
			noMiss = settings.noMiss,
			customScrollSpeed = settings.customScrollSpeed,
			keystrokes = settings.keystrokes,
			scrollUnderlayTrans = settings.scrollUnderlayTrans,
			hitsounds = settings.hitsounds,
			instVol = settings.instVol,
			vocalsVol = settings.vocalsVol,
			hitsoundVol = settings.hitsoundVol,
			noteSkins = settings.noteSkins,
			settingsVer = settingsVer
		}
		serialized = lume.serialize(data)
		love.filesystem.write("settings", serialized)
	end
	if settingsVer ~= 3 then
		love.window.showMessageBox("Uh Oh!", "Settings have been reset.", "warning")
		love.filesystem.remove("settings.data")
	end
	if not love.filesystem.getInfo("settings") or settingsVer ~= 3 then
		settings.hardwareCompression = true
		graphics.setImageType("dds")
		settings.downscroll = false
		settings.middleScroll = false
		settings.ghostTapping = false
		settings.showDebug = false
		settings.sideJudgements = false
		settings.botPlay = false
		settings.randomNotePlacements = false
		settings.practiceMode = false
		settings.noMiss = false
		settings.customScrollSpeed = 1
		settings.keystrokes = false
		settings.scrollUnderlayTrans = 0
		settings.hitsounds = false
		settings.instVol = 1
		settings.vocalsVol = 1
		settings.hitsoundVol = 1
		settings.noteSkins = 1
		settingsVer = 3
		data = {}
		data.saveSettingsMoment = {
			hardwareCompression = settings.hardwareCompression,
			downscroll = settings.downscroll,
			ghostTapping = settings.ghostTapping,
			showDebug = settings.showDebug,
			setImageType = "dds",
			sideJudgements = settings.sideJudgements,
			botPlay = settings.botPlay,
			middleScroll = settings.middleScroll,
			randomNotePlacements = settings.randomNotePlacements,
			practiceMode = settings.practiceMode,
			noMiss = settings.noMiss,
			customScrollSpeed = settings.customScrollSpeed,
			keystrokes = settings.keystrokes,
			scrollUnderlayTrans = settings.scrollUnderlayTrans,
			instVol = settings.instVol,
			vocalsVol = settings.vocalsVol,
			hitsounds = settings.hitsounds,
			hitsoundVol = settings.hitsoundVol,
			noteSkins = settings.noteSkins,
			
			settingsVer = settingsVer
		}
		serialized = lume.serialize(data)
		love.filesystem.write("settings", serialized)
	end


	-----------------------------------------------------------------------------------------

	-- LÖVE init
	if curOS == "OS X" then
		love.window.setIcon(love.image.newImageData("icons/macos.png"))
	else
		love.window.setIcon(love.image.newImageData("icons/default.png"))
	end

	lovesize.set(1280, 720)

	-- Variables
	font = love.graphics.newFont("fonts/vcr.ttf", 24)

	weekNum = 1
	songDifficulty = 2

	spriteTimers = {
		0, -- Girlfriend
		0, -- Enemy
		0 -- Boyfriend
	}

	storyMode = false
	countingDown = false

	cam = {x = 0, y = 0, sizeX = 0.9, sizeY = 0.9}
	camScale = {x = 0.9, y = 0.9}
	uiScale = {x = 0.7, y = 0.7}

	musicTime = 0
	health = 0
	if useDiscordRPC then 
		discordRPC.initialize(appId, true)
		local now = os.time(os.date("*t"))
		presence = {
			state = "Press Enter",
			details = "In the menu",
			largeImageKey = "logo",
			startTimestamp = now,
		}
		nextPresenceUpdate = 0
	end

	if curOS == "Web" then
		Gamestate.switch(clickStart)
	else
		Gamestate.switch(menu)
	end
end
function love.graphics.setColorF(R,G,B,A)
	local R, G, B = R/255 or 1, G/255 or 1, B/255 or 1 -- convert 255 values to work with the setColor
	graphics.setColor(R,G,B,A or 1) -- Alpha is not converted because using 255 alpha can be strange (I much rather 0-1 values lol)
end
function love.graphics.color.print(text,x,y,r,sx,sy,R,G,B,A,ox,oy,kx,ky)
    graphics.setColorF(R or 255,G or 255,B or 255,A or 1)
    love.graphics.print(text,x,y,r,sx,sy,a,ox,oy,kx,ky) -- When I learn the code for remaking love.graphics.print() I will update it (Although this works too)
    love.graphics.setColorF(255,255,255,1)
end

function love.graphics.color.printf(text,x,y,limit,align,r,sx,sy,R,G,B,A,ox,oy,kx,ky)
    graphics.setColorF(R or 255,G or 255,B or 255,A or 1)
    love.graphics.printf(text,x,y,limit,align,r,sx,sy,ox,oy,kx,ky) -- Part 2
    love.graphics.setColorF(255,255,255,1)
end
if useDiscordRPC then
	function discordRPC.ready(userId, username, discriminator, avatar)
		print(string.format("Discord: ready (%s, %s, %s, %s)", userId, username, discriminator, avatar))
	end

	function discordRPC.disconnected(errorCode, message)
		print(string.format("Discord: disconnected (%d: %s)", errorCode, message))
	end

	function discordRPC.errored(errorCode, message)
		print(string.format("Discord: error (%d: %s)", errorCode, message))
	end
end

function love.resize(width, height)
	lovesize.resize(width, height)
end

function love.keypressed(key)
	if key == "6" then
		love.filesystem.createDirectory("screenshots")

		love.graphics.captureScreenshot("screenshots/" .. os.time() .. ".png")
	elseif key == "7" then
		Gamestate.switch(debugMenu)
	elseif key == "0" then
		volFade = 1
		if love.audio.getVolume() == 0 then
			love.audio.setVolume(lastAudioVolume)
		else
			lastAudioVolume = love.audio.getVolume()
			love.audio.setVolume(0)
		end
	elseif key == "-" then
		volFade = 1
		if love.audio.getVolume() >= -0.1 then -- weird decimals moment
			love.audio.setVolume(love.audio.getVolume() - 0.1)
		end
	elseif key == "=" then
		volFade = 1
		if love.audio.getVolume() <= 0.9 then
			love.audio.setVolume(love.audio.getVolume() + 0.1)
		end
	elseif key == "f11" then
		fullscreen = not fullscreen
		love.window.setFullscreen(fullscreen, fstype)
		love.resize(love.graphics.getDimensions())
	else
		Gamestate.keypressed(key)
	end
end

function love.mousepressed(x, y, button, istouch, presses)
	Gamestate.mousepressed(x, y, button, istouch, presses)
end

function love.update(dt)
	dt = math.min(dt, 1 / 30)

	delta = love.timer.getDelta()

	if volFade > 0 then
		volFade = volFade - 0.4 * delta
	end

	input:update()

	if status.getNoResize() then
		Gamestate.update(dt)
	else
		love.graphics.setFont(font)
		graphics.screenBase(lovesize.getWidth(), lovesize.getHeight())
		graphics.setColor(1, 1, 1) -- Fade effect on
		Gamestate.update(dt)
		love.graphics.setColor(1, 1, 1) -- Fade effect off
		graphics.screenBase(love.graphics.getWidth(), love.graphics.getHeight())
		love.graphics.setFont(font)
	end
	if useDiscordRPC then
		if nextPresenceUpdate < love.timer.getTime() then
			discordRPC.updatePresence(presence)
			nextPresenceUpdate = love.timer.getTime() + 2.0
		end
		discordRPC.runCallbacks()
	end

	Timer.update(dt)
end

function love.draw()
	love.graphics.setFont(font)
	if status.getNoResize() then
		graphics.setColor(1, 1, 1) -- Fade effect on
		Gamestate.draw()
		love.graphics.setColor(1, 1, 1) -- Fade effect off
		love.graphics.setFont(font)

		if status.getLoading() then
			love.graphics.print("Loading...", graphics.getWidth() - 175, graphics.getHeight() - 50)
		end
		volumeControl()
	else
		graphics.screenBase(lovesize.getWidth(), lovesize.getHeight())
		lovesize.begin()
			graphics.setColor(1, 1, 1) -- Fade effect on
			Gamestate.draw()
			love.graphics.setColor(1, 1, 1) -- Fade effect off
			love.graphics.setFont(font)

			if status.getLoading() then
				love.graphics.print("Loading...", lovesize.getWidth() - 175, lovesize.getHeight() - 50)
			end
			volumeControl()
		lovesize.finish()
	end
	graphics.screenBase(love.graphics.getWidth(), love.graphics.getHeight())

	-- Debug output
	if settings.showDebug then
		if not pixel then -- Make debug text readable in pixel week
			if not inWhite then
				love.graphics.print(status.getDebugStr(settings.showDebug), 5, 5, nil, 0.5, 0.5)
			else
				love.graphics.setColor(0,0,0)
				love.graphics.print(status.getDebugStr(settings.showDebug), 5, 5, nil, 0.5, 0.5)
				love.graphics.setColor(1,1,1)
			end
		else
			love.graphics.print(status.getDebugStr(settings.showDebug), 5, 5, nil, 1.8, 1.8)
		end
	end

end
function love.quit()
	if useDiscordRPC then
		discordRPC.shutdown()
	end
end
