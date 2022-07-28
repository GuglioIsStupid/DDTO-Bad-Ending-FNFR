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

local curOS = love.system.getOS()

-- This usually doesn't need to be messed with
local settingsStr = (curOS == "NX" and [[ 
; Friday Night Funkin' Rewritten Settings (Switch)

[Keybinds]
; Set custom keybinds
; Look at https://love2d.org/wiki/KeyConstant for available keys
left=a
down=s
up=w
right=d

; These variables are read by the game for internal purposes, don't edit these unless you want to risk losing your current settings!
[Data]
settingsVer=1-nx
]]) or (curOS ~= "Web" and [[
; Friday Night Funkin' Rewritten Settings

[Video]
; Screen/window width and height (you should change this to your device's screen resolution if you are using the "exclusive" fullscreen type)
; NOTE: These settings will be ignored if using the "desktop" fullscreen type
width=1280
height=720

; Fullscreen settings, if you don't want Vsync (60 FPS cap), set "fullscreenType" to "exclusive" and "vsync" to "0"
fullscreen=false
fullscreenType=desktop
vsync=1

[Keybinds]
; Set custom keybinds
; Look at https://love2d.org/wiki/KeyConstant for available keys
left=a
down=s
up=w
right=d

; These variables are read by the game for internal purposes, don't edit these unless you want to risk losing your current settings!
[Data]
settingsVer=1
]])

local settingsIni

local settings = {}

if curOS == "NX" then
	love.window.setMode(1920, 1080)

	-- TODO: Restore showMessageBox functionality using LÖVE Potion's implementation
	if love.filesystem.getInfo("settings.ini") then
		settingsIni = ini.load("settings.ini")

		if not settingsIni["Data"] or ini.readKey(settingsIni, "Data", "settingsVer") ~= "1-nx" then
			love.filesystem.write("settings.ini", settingsStr)
		end
	else
		love.filesystem.write("settings.ini", settingsStr)
	end

	settingsIni = ini.load("settings.ini")

	customBindLeft = ini.readKey(settingsIni, "Keybinds", "left")
	customBindDown = ini.readKey(settingsIni, "Keybinds", "down")
	customBindUp = ini.readKey(settingsIni, "Keybinds", "up")
	customBindRight = ini.readKey(settingsIni, "Keybinds", "right")

elseif curOS == "Web" then -- For love.js, we won't bother creating and reading a settings file that can't be edited, we'll just preset some settings
	love.window.setMode(1280, 720) -- Due to shared code, lovesize will be used even though the resolution will never change :/
	settings.hardwareCompression = false
	settings.downscroll = false
	settings.ghostTapping = false
	settings.showDebug = false
else
	if love.filesystem.getInfo("settings.ini") then
		settingsIni = ini.load("settings.ini")

		if not settingsIni["Data"] or ini.readKey(settingsIni, "Data", "settingsVer") ~= "1" then
			love.window.showMessageBox("Warning", "The current settings file is outdated, and will now be reset.")

			local success, message = love.filesystem.write("settings.ini", settingsStr)

			if success then
				love.window.showMessageBox("Success", "Settings file successfully created: \"" .. love.filesystem.getSaveDirectory() .. "/settings.ini\"")
			else
				love.window.showMessageBox("Error", message)
			end
		end
	else
		local success, message = love.filesystem.write("settings.ini", settingsStr)

		if success then
			love.window.showMessageBox("Success", "Settings file successfully created: \"" .. love.filesystem.getSaveDirectory() .. "/settings.ini\"")
		else
			love.window.showMessageBox("Error", message)
		end
	end

	settingsIni = ini.load("settings.ini")

	if ini.readKey(settingsIni, "Video", "fullscreen") == "true" then
		love.window.setMode(
			ini.readKey(settingsIni, "Video", "width"),
			ini.readKey(settingsIni, "Video", "height"),
			{
				fullscreen = true,
				fullscreentype = ini.readKey(settingsIni, "Video", "fullscreenType"),
				vsync = tonumber(ini.readKey(settingsIni, "Video", "vsync"))
			}
		)
	else
		love.window.setMode(
			ini.readKey(settingsIni, "Video", "width"),
			ini.readKey(settingsIni, "Video", "height"),
			{
				vsync = tonumber(ini.readKey(settingsIni, "Video", "vsync")),
				resizable = true
			}
		)
	end

	customBindLeft = ini.readKey(settingsIni, "Keybinds", "left")
	customBindDown = ini.readKey(settingsIni, "Keybinds", "down")
	customBindUp = ini.readKey(settingsIni, "Keybinds", "up")
	customBindRight = ini.readKey(settingsIni, "Keybinds", "right")

end

return settings
