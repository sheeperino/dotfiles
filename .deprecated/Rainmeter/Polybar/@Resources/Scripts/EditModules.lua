function Initialize()
	fileview = SKIN:GetMeasure('MeasureChild1')
	filecount = SKIN:GetMeasure('MeasureFileCount')
	adModList = SKIN:GetVariable('AddedModule')
	ad = 0
	addModuleFile = {}
	for modules in adModList:gmatch('[^,]+') do
		table.insert(addModuleFile,string.lower(modules))
		ad = ad + 1
	end
	adDone = true
	setCondition()
end

q=2
moduleFile ={}
function gatherModuleFile()
	local curFile = fileview:GetStringValue()
	if curFile ~= '' and curFile ~= '..' then
		table.insert(moduleFile,string.lower(curFile))
	end
	q = q+1
	if q <= filecount:GetValue() + 1 then
		SKIN:Bang('[!SetOption MeasureChild1 Index '..q..'][!CommandMeasure MeasureFolder "Update"]')
	else
		avDone = true
		setCondition()
	end
end

function setCondition()
	if avDone and adDone then
		for i=#moduleFile,1,-1 do
			for j=1,#addModuleFile do
				if moduleFile[i] == addModuleFile[j] then
					table.remove(moduleFile,i)
					break
				end
			end
		end
		
		avMP = math.ceil(#moduleFile/5)
		avChangePage(0)

		adMP = math.ceil(#addModuleFile/5)
		adChangePage(0)

		avDone, adDone = false,false
	end
end

choseModule=''
function chooseAvM(meter)
	choseModule = moduleFile[meter]
	readMeta(choseModule)
end

function AddModule()
	if choseModule == '' then 
		timing = 1
		print('Please Choose Module First') 
		return 
	end
	table.insert(addModuleFile,choseModule)
	SKIN:Bang('[!WriteKeyValue Variables AddedModule "'..table.concat(addModuleFile,',')..'" "#@#MainBarVariables.inc"]'
			..'[!WriteKeyValue Variables DefaultAddedModules "'..table.concat(addModuleFile,',')..'" "#ROOTCONFIGPATH#Themes\\#Theme#\\Config\\Config.inc"]'
			..'[!WriteKeyValue IncludedModule @Include'..(#addModuleFile + 2)..' "#*ROOTCONFIGPATH*#Themes\\#*Theme*#\\'..choseModule..'.inc" "#ROOTCONFIGPATH#Polybar.ini"]'
			..'[!Refresh][!Refresh "#rootconfig#"]')
end

avCurP = 1
function avChangePage(dir)
	if avCurP + dir <= avMP and avCurP + dir >= 1 then
		avCurP = avCurP + dir
		SKIN:Bang('[!SetOption AvPage Text "'..avCurP..'/'..avMP..'"][!SetOption ModuleListShape Shape7 "Rectangle 0,0,0,0"]')
		choseModule = ''
	else
		print('Page Not Available. Stop Pressing.')
		return
	end
	for i = 1+5*(avCurP-1),5+5*(avCurP-1) do
		if moduleFile[i] then
			SKIN:Bang('[!SetOption avM'..(i-5*(avCurP-1))..' Text "'..moduleFile[i]..'"]'
					..'[!SetOption avM'..(i-5*(avCurP-1))..' LeftMouseUpAction """[!CommandMeasure Script "chooseAvM('..i..')"][!SetOption ModuleListShape Shape7 "Rectangle 26.5,([#*currentsection*#:Y]-2),300,([#*currentsection*#:H]+2)|Extend ChooseModuleTrait"]"""]')
		else
			SKIN:Bang('[!SetOption avM'..(i-5*(avCurP-1))..' Text "--"]'
					..'[!SetOption avM'..(i-5*(avCurP-1))..' LeftMouseUpAction ""]')
		end
	end
end

choseAddedModule = ''
function chooseAdM(meter)
	choseAddedModule = meter
	readMeta(addModuleFile[choseAddedModule])
	SKIN:Bang('[!SetOption DummyMeasure OnUpdateAction """[!CommandMeasure Script "curr_module_pos=\'#*'..addModuleFile[choseAddedModule]..'_x*#\';editPosition()" "Polybar\\Setting"][!SetOption DummyMeasure OnUpdateAction ""]""" "#rootconfig#"][!Update #rootconfig#]')
end

adCurP = 1
function adChangePage(dir)
	if adCurP + dir <= adMP and adCurP + dir >= 1 then
		adCurP = adCurP + dir
		SKIN:Bang('[!SetOption AdPage Text "'..adCurP..'/'..adMP..'"][!SetOption AddedModuleListShape Shape7 "Rectangle 0,0,0,0"]')
		choseAddedModule = ''
	else
		print('Page Not Available. Stop Pressing.')
		return
	end
	local r = 1
	for i = 1 + 5*(adCurP-1),5 + 5*(adCurP-1) do
		if addModuleFile[i] then
			SKIN:Bang('[!SetOption adM'..(i-5*(adCurP-1))..' Text "'..addModuleFile[i]..'"]'
					..'[!SetOption adM'..(i-5*(adCurP-1))..' LeftMouseUpAction """[!CommandMeasure Script "chooseAdM('..i..')"][!SetOption AddedModuleListShape Shape7 "Rectangle 26.5,([#*currentsection*#:Y]-2),300,([#*currentsection*#:H]+2)|Extend ChooseModuleTrait"]"""]"""]')
		else
			SKIN:Bang('[!SetOption adM'..(i-5*(adCurP-1))..' Text ""]'
					..'[!SetOption adM'..(i-5*(adCurP-1))..' LeftMouseUpAction ""]')
		end
	end
end

function RemoveModule()
	if choseAddedModule == '' then
		timing2 = 1
		print('Please Choose Module First') 
		return 
	end
	for i = 3,#addModuleFile+2 do
		SKIN:Bang('[!WriteKeyValue IncludedModule @Include'..i..' "" "#ROOTCONFIGPATH#Polybar.ini"]')
	end
	table.remove(addModuleFile,choseAddedModule)
	SKIN:Bang('[!WriteKeyValue Variables AddedModule "'..table.concat(addModuleFile,',')..'" "#@#MainBarVariables.inc"]'
			..'[!WriteKeyValue Variables DefaultAddedModules "'..table.concat(addModuleFile,',')..'" "#ROOTCONFIGPATH#Themes\\#Theme#\\Config\\Config.inc"]')
	for k,v in pairs(addModuleFile) do
		SKIN:Bang('[!WriteKeyValue IncludedModule @Include'..(k+2)..' "#*ROOTCONFIGPATH*#Themes\\#*Theme*#\\'..v..'.inc" "#ROOTCONFIGPATH#Polybar.ini"]')
	end

	SKIN:Bang('[!Refresh][!Refresh "#rootconfig#"]')
end

function editPosition()
	local modulefile = addModuleFile[choseAddedModule]
	SKIN:Bang('[!SetOption Manually Text "Open ['..modulefile..'] module file"]'
			..'[!SetOption ManuallyShape LeftMouseUpAction "[#RootConfigPath#Themes\\#Theme#\\'..modulefile..'.inc]"]'
			..'[!ShowMeterGroup Manually]')
	curr_module_pos = tonumber(curr_module_pos) 
	if not curr_module_pos then 
		SKIN:Bang('[!SetOption ModulePosition Text """Failed to get ['..modulefile..'] position variable. Slide to generate correct one and use that new variable for your module\'s meters: #*Curr_Module_Pos*#"""]'
				..'[!SetVariable Curr_Module_Pos 0]'
				..'[!SetOption SliderCalc Formula 0]')
	else
		SKIN:Bang('[!SetOption ModulePosition Text "Slide to change ['..modulefile..'] position: #*Curr_Module_Pos*#"]'
				..'[!SetVariable Curr_Module_Pos '..curr_module_pos..']'
				..'[!SetOption SliderCalc Formula "'..curr_module_pos..'/#Bar_Width#*100"]')
	end
	SKIN:Bang('[!ShowMeter ModulePosition]'
			..'[!ShowMeter PositionSlider]'
			..'[!SetOption SliderCalc OnChangeAction """[!SetVariable Curr_Module_Pos (round([*SliderCalc*]/100*#Bar_Width#))][!SetVariable '..modulefile..'_x (round([*SliderCalc*]/100*#Bar_Width#)) "#rootconfig#"][!WriteKeyValue Variables '..modulefile..'_x (round([*SliderCalc*]/100*#Bar_Width#)) "#*RootConfigPath*#\\Themes\\#*Theme*#\\'..modulefile..'.inc"][!Update "#rootconfig#"]"""]'
			..'[!SetOption PositionSlider MouseScrollUpAction """[!SetVariable Curr_Module_Pos (#*Curr_Module_Pos*#+1)][!SetVariable '..modulefile..'_x (#*Curr_Module_Pos*#+1) "#rootconfig#"][!WriteKeyValue Variables '..modulefile..'_x (#*Curr_Module_Pos*#+1) "#*RootConfigPath*#\\Themes\\#*Theme*#\\'..modulefile..'.inc"][!Update "#rootconfig#"]"""]'
			..'[!SetOption PositionSlider MouseScrollDownAction """[!SetVariable Curr_Module_Pos (#*Curr_Module_Pos*#-1)][!SetVariable '..modulefile..'_x (#*Curr_Module_Pos*#-1) "#rootconfig#"][!WriteKeyValue Variables '..modulefile..'_x (#*Curr_Module_Pos*#-1) "#*RootConfigPath*#\\Themes\\#*Theme*#\\'..modulefile..'.inc"][!Update "#rootconfig#"]"""]')
end

timing4,timing,timing2=0,0,0

function Update()
	if timing4 > 0 and timing4 < 30 then
		timing4 = timing4 + 1*dir4
		local ballAnimate = outQuad(timing4, 0, 1, 30)*(dir4+1)/2 + inExpo(timing4, 0, 1, 30)*(1-dir4)/2
		SKIN:Bang('[!SetOption ManuallyShape Shape3 "Ellipse #MouseX#,#MouseY#,(([Manually:W]+40)*'..ballAnimate..')|Extend balltrait"]')
	end
	if timing > 0 and timing < 20 then
		timing = timing + 1
		local shaking = inOutElastic(timing, 1, 0, 20,3,6)
		SKIN:Bang('[!SetOption ModuleListShape Shaking "Offset '..(10-10*shaking)..',0"]')
	end
	if timing2 > 0 and timing2 < 20 then
		timing2 = timing2 + 1
		local shaking = inOutElastic(timing2, 1, 0, 20,3,6)
		SKIN:Bang('[!SetOption AddedModuleListShape Shaking "Offset '..(10-10*shaking)..',0"]')
	end
end

function outQuad(t, b, c, d)
	t = t / d
	return -c * t * (t - 2) + b
end
function inExpo(t, b, c, d)
	if t == 0 then
		return b
	else
		return c * math.pow(2, 10 * (t / d - 1)) + b - c * 0.001
	end
end

function inOutElastic(t, b, c, d, a, p)
  if t == 0 then return b end

  t = t / d * 2

  if t == 2 then return b + c end

  if not p then p = d * (0.3 * 1.5) end
  if not a then a = 0 end

  local s

  if not a or a < math.abs(c) then
    a = c
    s = p / 4
  else
    s = p / (2 * math.pi) * math.asin(c / a)
  end

  if t < 1 then
    t = t - 1
    return -0.5 * (a * math.pow(2, 10 * t) * math.sin((t * d - s) * (2 * math.pi) / p)) + b
  else
    t = t - 1
    return a * math.pow(2, -10 * t) * math.sin((t * d - s) * (2 * math.pi) / p ) * 0.5 + c + b
  end
end

function readMeta(modulefile)
	SKIN:Bang('[!SetOption ReadMeta_Name URL """file://'..SKIN:ReplaceVariables('#ROOTCONFIGPATH#Themes\\#Theme#\\'..modulefile..'.inc')..'"""][!CommandMeasure ReadMeta_Name "Update"]')
end