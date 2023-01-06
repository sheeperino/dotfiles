function Initialize()
	dofile(SKIN:GetVariable('@')..'Scripts\\Taskbar_Common_Script.lua')
	GetEssentialVariables()
	Active_IconIndex = -1
	MouseOver_IconIndex = -1
end

function Update()
	UpdateNow()
end

--This function is used for drawing subprocess tracking shape. 
--TotalRunning is total number of subprocess of 1 process.
--CurrentDrawingIndex is taskbar index of process that currently drawing.
--CurrentActiveWindow: Return true if currently drawing process is active. Return false if currently drawing process is not active process. 
--shapeCount is start at 2
-- If theme doesn't need it, leave it blank, do not remove it.
function DrawSubProcessShape(TotalRunning,CurrentDrawingIndex,CurrentActiveWindow)
	if CurrentActiveWindow then
		Active_IconIndex = CurrentDrawingIndex

		local iconColor = ''
		if CurrentDrawingIndex == MouseOver_IconIndex then
			iconColor = '#Icon_MouseOver_TintColor#'
		else
			iconColor = '#Color_Scheme3#'
		end

		SKIN:Bang('!SetOption '..CurrentDrawingIndex..' ImageTint "'..iconColor..'"')
	else
		local iconColor = ''
		if CurrentDrawingIndex == MouseOver_IconIndex then
			iconColor = '#Icon_MouseOver_TintColor#'
		else
			iconColor = '#Icon_MouseLeave_TintColor#'
		end

		SKIN:Bang('!SetOption '..CurrentDrawingIndex..' ImageTint "'..iconColor..'"')
	end
end

--DrawProcessBackground function used for drawing background under all application.
--TotalProcess: total number of processes.
--If theme doesn't need it, leave it blank, do not remove it.
function DrawProcessBackground(TotalProcess)
end

--DrawIconHighlight function used for drawing attribute of icon when mouse is hovering on.
--iconIndex: taskbar index of process mouse currently over.
--If theme doesn't need it, leave it blank, do not remove it.
function DrawIconHighlight(iconIndex)
	MouseOver_IconIndex = iconIndex
--When mouse over icon, Lighten it up, draw background shape for that icon
	SKIN:Bang('[!SetOption '..iconIndex..' ImageTint "#Icon_MouseOver_TintColor#"]'
			..'[!UpdateMeter '..iconIndex..']'
			..'[!SetOption TaskbarShape Shape2 "Rectangle '..(iconIndex*(IconGap*2+IconSize))..',#Tile_Space#,'..(IconGap*2+IconSize)..',(#Bar_Height#-#Tile_Space#*2) |Extend MouseOverHighlight"]'
			..'[!UpdateMeter TaskbarShape]'
			..'[!Redraw]')
end

--ProcessMouseLeave function used for drawing attribute of icon when mouse leaves.
--iconIndex: taskbar index of process that mouse just leaves.
--If theme doesn't need it, leave it blank, do not remove it.
function ProcessMouseLeave(iconIndex)
	MouseOver_IconIndex = -1
	SKIN:Bang('[!CommandMeasure AdditionalSkinActionTimer "Execute 1"]'
			..'[!SetOption '..iconIndex..' ImageTint "#Icon_MouseLeave_TintColor#"]'
			..'[!UpdateMeter '..iconIndex..']'
			..'[!SetOption TaskbarShape Shape2 "Rectangle 0,0,0,0"]'
			..'[!UpdateMeter TaskbarShape]'
			..'[!Redraw]')
end