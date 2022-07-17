function GetEssentialVariables()
	IconSize = tonumber(SKIN:GetVariable('Icon_Size',26))
	IconGap = tonumber(SKIN:GetVariable('Icon_Gap',20))
	MaxProcess = tonumber(SKIN:GetVariable('Max_Tracking_Process',15))
	BarOffsetX = tonumber(SKIN:GetVariable('Bar_OffsetX',0))
	Anchor = SKIN:GetVariable('Taskbar_Anchor','left'):lower()
	fileview = SKIN:GetMeasure('TaskbarIconThemeFolder_Child')
	filecount = SKIN:GetMeasure('TaskbarIconThemeFileCount')
	Dragging = false
	SKIN:Bang('[!CommandMeasure GetActiveProcess "Run"]')
end

q=2
iconFile ={}
function gatherIconFile()
	local curFile = fileview:GetStringValue()
	if curFile ~= '' and curFile ~= '..' then
		table.insert(iconFile,string.lower(curFile))
	end
	q = q+1
	if q <= filecount:GetValue() + 1 then
		SKIN:Bang('[!SetOption TaskbarIconThemeFolder_Child Index '..q..'][!CommandMeasure TaskbarIconThemeFolder "Update"]')
	end
end

BSChar = {['_'] = '',['%(.*%)']='',['^%s']='',['%s$']=''}
lessBSChar =function (s)
			for k,v in pairs(BSChar) do
				s = string.gsub(s,k,v)
			end return string.lower(s) end
init = true
processDefinedPosition = {'empty'}
AnchorPoint = 0

function UpdateNow()
	if Dragging then clearShape() return end
	Taskbar_X =tonumber(SKIN:GetVariable('Taskbar_X'))
	order = 0
	processcount = tonumber(SKIN:GetVariable('processcount'))
	if not processcount then return end
	for i = 0,MaxProcess-1 do
		if SKIN:GetVariable('programscount'..i) ~='0' then 
			SKIN:Bang('!CommandMeasure ProgramOptions "SetVariable|ProgramHandle'..i..'|ChildHandle|'..i..'|0"')
		else
			SKIN:Bang('!SetVariable ProgramHandle'..i..' null')
		end
	end
	if init then 
		init = false
		--Create processDefinedPosition{} table so we can remove, add to re-position icon.
		for i = 0, processcount-1 do
			processDefinedPosition[i+1] = {['name'] = SKIN:GetVariable('programname'..i), ['handle'] = SKIN:GetVariable('programhandle'..i), ['index'] = i}
		end
	else 
		clearShape()

		--Tracking new process: If meet one, add it in processDefinedPosition{}
		for i =  0, processcount-1 do
			local name = SKIN:GetVariable('programname'..i)
			local handle = SKIN:GetVariable('programhandle'..i)
			for j = 1,#processDefinedPosition do
				if name == processDefinedPosition[j]['name'] and handle == processDefinedPosition[j]['handle'] then
					processDefinedPosition[j]['index'] = i
					new = false
					break
				else
					new = true
				end
			end
			if new then processDefinedPosition[#processDefinedPosition+1] = {['name'] = name, ['handle'] = handle, ['index'] = i} 
			
			end
		end

		--Tracking closed process: If isn't in program list anymore, remove it from our processDefinedPosition{}
		for i = 1,#processDefinedPosition do
			for j = 0, processcount-1 do
				local name = SKIN:GetVariable('programname'..j)
				local handle = SKIN:GetVariable('programhandle'..j)
				if name == processDefinedPosition[i]['name'] and handle == processDefinedPosition[i]['handle'] then
					nomore = false
					break
				else
					nomore = true
				end
			end
			if nomore then table.remove(processDefinedPosition,i) 
			end
		end
	end
	
	shapeCount = 2
	for i = 0,MaxProcess-1 do
		if processDefinedPosition[i+1] then 
			local ProgramName = processDefinedPosition[i+1]['name']
			--Calculate Icon position
			SKIN:Bang('[!SetOption '..i..' X (-#*AnchorPoint*#+'..(Taskbar_X + BarOffsetX + IconGap + (IconGap*2 + IconSize) * i)..')]'
					..'[!ShowMeter '..i..']')

			--Icon Theme Replace
			local tempName = lessBSChar(ProgramName)
			for k,v in pairs (iconFile) do
				if string.find(tempName,v) then
					SKIN:Bang('[!SetOption '..i..' ImageName "#CURRENTPATH#Themes\\#Theme#\\Icons\\'..v..'.png"]')
					break
				else
					SKIN:Bang('[!SetOption '..i..' ImageName "#@#Icons\\'..ProgramName..'.png"]')
				end
			end
			local tempIndex = processDefinedPosition[i+1]['index']
			running = tonumber(SKIN:GetVariable('programscount'..tempIndex))
			SKIN:Bang('[!SetOption '..i..' MiddleMouseUpAction "[!CommandMeasure ProgramOptions StartNew|'..tempIndex..'][!UpdateMeter '..i..']"]')

			if running == 0 then
				SKIN:Bang('[!SetOption '..i..' LeftMouseUpAction "[!CommandMeasure ProgramOptions StartNew|'..tempIndex..'][!UpdateMeter '..i..']"]'
						..'[!SetOption '..i..' MouseOverAction " "]'
						..'[!UpdateMeter '..i..']')
			else
				SKIN:Bang('[!SetOption '..i..' LeftMouseUpAction "[!CommandMeasure ProgramOptions ToFront|Main|'..tempIndex..']"]'
						..'[!SetOption '..i..' MouseOverAction """[!CommandMeasure AdditionalSkinActionTimer "Stop 1"][!CommandMeasure TaskbarScript "ProcessMouseOver('..tempIndex..','..i..')"]"""]'
						..'[!UpdateMeter '..i..']')
				ActiveWindow = string.gsub(SKIN:GetVariable('ActiveWindowProcess'),"....$","")
				local isWindowActive = false
				if ActiveWindow:lower() ~= '' then
					if string.find(ProgramName:lower(),ActiveWindow:lower()) then
						isWindowActive = true
					end
				end
				--Drawing subprocess tracking shape, depend on what theme, this function can be different and generate different style of shape.
				DrawSubProcessShape(running,i,isWindowActive)
			end
			order = order + 1
		else
			SKIN:Bang('[!HideMeter '..i..']')
		end
	end

	DrawProcessBackground(order)
	
	if Anchor == 'left' then 
		AnchorPoint = 0
	elseif Anchor == 'right' then 
		AnchorPoint = (IconGap*2 + IconSize)*order
	else 
		AnchorPoint = (IconGap*2 + IconSize)*order / 2 
	end
	SKIN:Bang('!SetVariable AnchorPoint '..AnchorPoint)

	if SKIN:GetVariable('NeedsUpdate') == '1' then
		SKIN:Bang('["#@#getIcons.exe" "#AdditionalDependencies#"][!SetVariable NeedsUpdate 0]')
	end
end

function clearShape()
	for i = 2,shapeCount do
		SKIN:Bang('!SetOption SubprocessTrackingShape Shape'..i..' "Ellipse 0,0,0"')
	end
end
taskbarIndex = -1 
function ProcessMouseOver(listIndex,index)
	taskbarIndex = index

	DrawIconHighlight(taskbarIndex)

	local writePosBang = '[!WriteKeyValue Variables Curr_X (['..taskbarIndex..':X]+#Icon_Size#/2+#CURRENTCONFIGX#) "#ROOTCONFIGPATH#Themes\\#Theme#\\Additional_Comps_And_Scripts\\MusicControl.ini"][!WriteKeyValue Variables Curr_Y "[SubSkinYPositionCalc]" "#ROOTCONFIGPATH#Themes\\#Theme#\\Additional_Comps_And_Scripts\\MusicControl.ini"][!WriteKeyValue Variables Dir "[SubSkinDirectionCalc]" "#ROOTCONFIGPATH#Themes\\#Theme#\\Additional_Comps_And_Scripts\\MusicControl.ini"][!DeactivateConfig "#ROOTCONFIG#\\Themes\\#Theme#\\Additional_Comps_And_Scripts"][!ActivateConfig "#ROOTCONFIG#\\Themes\\#Theme#\\Additional_Comps_And_Scripts" "MusicControl.ini"]'

	--Activate Media Control skin if meet one of supported player, else show subprocess list.
	local tempName = lessBSChar(processDefinedPosition[index+1]['name'])
	if string.find(tempName,'spotify') then
		SKIN:Bang('[!WriteKeyValue Variables MusicControl_Current_Player Spotify "#ROOTCONFIGPATH#Themes\\#Theme#\\Additional_Comps_And_Scripts\\MusicControl.ini"]'..writePosBang)

	elseif string.find(tempName,'google play') then
		SKIN:Bang('[!WriteKeyValue Variables MusicControl_Current_Player GPMDP "#ROOTCONFIGPATH#Themes\\#Theme#\\Additional_Comps_And_Scripts\\MusicControl.ini"]'..writePosBang)

	elseif string.find(tempName,'aimp') then
		SKIN:Bang('[!WriteKeyValue Variables MusicControl_Current_Player NowPlaying "#ROOTCONFIGPATH#Themes\\#Theme#\\Additional_Comps_And_Scripts\\MusicControl.ini"]'
				..'[!WriteKeyValue Variables MusicControl_NowPlaying_Player AIMP "#ROOTCONFIGPATH#Themes\\#Theme#\\Additional_Comps_And_Scripts\\MusicControl.ini"]'..writePosBang)

	elseif string.find(tempName,'foobar') or string.find(tempName,'jukebox') or string.find(tempName,'media center') or string.find(tempName,'musicbee') then
		SKIN:Bang('[!WriteKeyValue Variables MusicControl_Current_Player NowPlaying "#ROOTCONFIGPATH#Themes\\#Theme#\\Additional_Comps_And_Scripts\\MusicControl.ini"]'
				..'[!WriteKeyValue Variables MusicControl_NowPlaying_Player CAD "#ROOTCONFIGPATH#Themes\\#Theme#\\Additional_Comps_And_Scripts\\MusicControl.ini"]'..writePosBang)

	elseif string.find(tempName,'winamp') then
		SKIN:Bang('[!WriteKeyValue Variables MusicControl_Current_Player NowPlaying "#ROOTCONFIGPATH#Themes\\#Theme#\\Additional_Comps_And_Scripts\\MusicControl.ini"]'
				..'[!WriteKeyValue Variables MusicControl_NowPlaying_Player winamp "#ROOTCONFIGPATH#Themes\\#Theme#\\Additional_Comps_And_Scripts\\MusicControl.ini"]'..writePosBang)

	elseif string.find(tempName,'mediamonkey') then
		SKIN:Bang('[!WriteKeyValue Variables MusicControl_Current_Player NowPlaying "#ROOTCONFIGPATH#Themes\\#Theme#\\Additional_Comps_And_Scripts\\MusicControl.ini"]'
				..'[!WriteKeyValue Variables MusicControl_NowPlaying_Player MediaMonkey "#ROOTCONFIGPATH#Themes\\#Theme#\\Additional_Comps_And_Scripts\\MusicControl.ini"]'..writePosBang)

	elseif string.find(tempName,'wmplayer') then
		SKIN:Bang('[!WriteKeyValue Variables MusicControl_Current_Player NowPlaying "#ROOTCONFIGPATH#Themes\\#Theme#\\Additional_Comps_And_Scripts\\MusicControl.ini"]'
				..'[!WriteKeyValue Variables MusicControl_NowPlaying_Player wmp "#ROOTCONFIGPATH#Themes\\#Theme#\\Additional_Comps_And_Scripts\\MusicControl.ini"]'..writePosBang)	
	
	else
		ShowSubProcess(listIndex)
	end
end

function ShowSubProcess(index)

	SKIN:Bang('!DeactivateConfig "#ROOTCONFIG#\\Themes\\#Theme#\\Additional_Comps_And_Scripts"')

	local running = tonumber(SKIN:GetVariable('programscount'..index))
	if running == 0 then return end
	
	if Anchor == 'left' then
		listX = '(#CURRENTCONFIGX#+['..taskbarIndex..':X]-#Icon_Gap#)'
	elseif Anchor == 'right' then
		listX = '"""(#CURRENTCONFIGX#+['..taskbarIndex..':X]+#Icon_Size#+#Icon_Gap#-#*SubProcessList_Width*#)"""'
	else
		listX = '"""(#CURRENTCONFIGX#+['..taskbarIndex..':X]+#Icon_Size#/2-#*SubProcessList_Width*#/2)"""'
	end
	SKIN:Bang('[!WriteKeyValue Variables MaxSubprocessMeter '..(running-1)..' "#ROOTCONFIGPATH#\\Themes\\#Theme#\\Additional_Comps_And_Scripts\\Subprocess.ini"]'
			..'[!WriteKeyValue Variables Curr_X "'..listX..'" "#ROOTCONFIGPATH#\\Themes\\#Theme#\\Additional_Comps_And_Scripts\\Subprocess.ini"]'
			..'[!WriteKeyValue Variables Curr_Y "[SubSkinYPositionCalc]" "#ROOTCONFIGPATH#\\Themes\\#Theme#\\Additional_Comps_And_Scripts\\Subprocess.ini"]'
			..'[!WriteKeyValue Variables Dir "[SubSkinDirectionCalc]" "#ROOTCONFIGPATH#\\Themes\\#Theme#\\Additional_Comps_And_Scripts\\Subprocess.ini"]')

	for i = 0,running-1 do
		SKIN:Bang('[!WriteKeyValue Subprocess'..i..' Meter String "#ROOTCONFIGPATH#\\Themes\\#Theme#\\Additional_Comps_And_Scripts\\Subprocess.ini"]'
				..'[!WriteKeyValue SubDelete'..i..' Meter String "#ROOTCONFIGPATH#\\Themes\\#Theme#\\Additional_Comps_And_Scripts\\Subprocess.ini"]'
				..'[!WriteKeyValue Subprocess'..i..' MeterStyle SubProcessStyle "#ROOTCONFIGPATH#\\Themes\\#Theme#\\Additional_Comps_And_Scripts\\Subprocess.ini"]'
				..'[!WriteKeyValue SubDelete'..i..' MeterStyle SubDeleteStyle "#ROOTCONFIGPATH#\\Themes\\#Theme#\\Additional_Comps_And_Scripts\\Subprocess.ini"]')
	end

	SKIN:Bang('[!ActivateConfig "#ROOTCONFIG#\\Themes\\#Theme#\\Additional_Comps_And_Scripts" "Subprocess.ini"]')

	--Get subprocess name from ProgramOptions plugin then set it to meters in Subprocess skin
	for i = 0, running-1 do
		SKIN:Bang('!CommandMeasure ProgramOptions "SetVariable|WindowName|ChildWindowName|'..index..'|'..i..'"')
		SKIN:Bang('[!SetOption Subprocess'..i..' Text "'..SKIN:GetVariable('WindowName')..'" "#ROOTCONFIG#\\Themes\\#Theme#\\Additional_Comps_And_Scripts"]'
				..'[!SetOption Subprocess'..i..' LeftMouseUpAction """[!CommandMeasure ProgramOptions "ToFront|Child|'..index..'|'..i..'" "#ROOTCONFIG#"]""" "#ROOTCONFIG#\\Themes\\#Theme#\\Additional_Comps_And_Scripts"]'
				..'[!ShowMeter Subprocess'..i..' "#ROOTCONFIG#\\Themes\\#Theme#\\Additional_Comps_And_Scripts"]'
				..'[!ShowMeter SubDelete'..i..' "#ROOTCONFIG#\\Themes\\#Theme#\\Additional_Comps_And_Scripts"]')
		--Set function for Close button: If this process has only one subprocess is itself, closing it will deactivate Subprocess skin. 
		--Else tell ProgramOptions to Update and re-run this function for new subprocess list.
		if running == 1 then
			closeAction = '[!CommandMeasure ProgramOptions "Stop|Child|'..index..'|0" "#ROOTCONFIG#"][!DeactivateConfig]'
		else	
			closeAction = '[!CommandMeasure ProgramOptions "Stop|Child|'..index..'|'..i..'" "#ROOTCONFIG#"][!UpdateMeasure ProgramOptions "#ROOTCONFIG#"][!CommandMeasure TaskbarScript "ShowSubProcess('..index..')" "#ROOTCONFIG#"]'
		
		end
		SKIN:Bang('[!SetOption Subprocess'..i..' MiddleMouseUpAction """'..closeAction..'""" "#ROOTCONFIG#\\Themes\\#Theme#\\Additional_Comps_And_Scripts"]'
				..'[!SetOption SubDelete'..i..' LeftMouseUpAction """'..closeAction..'""" "#ROOTCONFIG#\\Themes\\#Theme#\\Additional_Comps_And_Scripts"]')
	end
	SKIN:Bang('[!Update "#ROOTCONFIG#\\Themes\\#Theme#\\Additional_Comps_And_Scripts"]')
end

copy = {}
function MovingIcon(dragPos,curPos)
	--dragPos is original index in taksbar of dragging Icon
	--curPos is index in taskbar of Icon currently on
	copy = {'empty'}

	--Clone our program table
	for i = 1,#processDefinedPosition do
		copy[i]=processDefinedPosition[i]
	end
	if #copy == 1 then return end

	--Replace its position. Our taskbar index starts at 0 but table in Lua index starts at 1 so we need to +1 everything
	local temp = copy[dragPos+1]
	table.remove(copy,dragPos+1)
	table.insert(copy,curPos+1,temp)

	--Redraw every icons
	for i = 0,#copy-1 do
		for k,v in pairs(processDefinedPosition) do
			if copy[i+1] == v then
				--Calculate index in taskbar
				order = k-1
				break
			end
		end
		SKIN:Bang('[!SetOption '..order..' X (-#*AnchorPoint*#+'..(Taskbar_X + BarOffsetX + IconGap + (IconGap*2 + IconSize) * i)..')]')
	end
	SKIN:Bang('[!UpdateMeterGroup Taskbar][!Redraw]')
end

--When user release the mouse, DoneMoving() will run. 
function DoneMoving()
	if not #copy or #copy == 1 then return end
	--Apply new icon position to our program table
	for i = 1,#copy do
		processDefinedPosition[i] = copy[i]
	end
	SKIN:Bang('[!SetOptionGroup Taskbar MouseOverAction """[!CommandMeasure TaskbarScript "ProcessMouseOver(#*CURRENTSECTION*#)"]"""]'
			..'[!SetOptionGroup Taskbar MouseLeaveAction """[!CommandMeasure TaskbarScript "ProcessMouseLeave(#*CURRENTSECTION*#)"]"""]')
end