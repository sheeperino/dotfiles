[Variables]
Taskbar_X=121
;Left, Middle or Right
Taskbar_Anchor=Left

Icon_Size = 16
Icon_Gap = 8
Icon_MouseOver_TintColor=ffffff
Icon_MouseLeave_TintColor=ffffffd0

Taskbar_MouseOver_Color = 00000000

AdaptiveBackground_Opacity = c6
AdaptiveBackground_RoundCornerAmount = 10
AdaptiveBackground_TopGap = 8
AdaptiveBackground_BottomGap = 60
Dot_DistanceToIcon = 5

Max_Tracking_Process = 10
AdditionalDependencies=#ROOTCONFIGPATH#Shortcuts|#ADDONSPATH#..\..\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar
;Anchor point is generated by script. Change Taskbar_Anchor instead.
AnchorPoint=0
ActiveWindowProcess=none

[Metadata]
Name=Paper\\Taskbar
Author=reddit.com/u/khanhas
Description=Fully functional taskbar: Tracking current active apps and pinned app, change apps position, subprocess list, music control.

[TaskbarScript]
Measure=Script
ScriptFile = #ROOTCONFIGPATH#Themes\#Theme#\Additional_Comps_And_Scripts\TaskbarScript.lua

;Get Theme Icons
[TaskbarIconThemeFileCount]
Measure=Plugin
Plugin=FolderInfo
Folder= "#ROOTCONFIGPATH#Themes\#Theme#\Icons"
InfoType=FileCount
UpdateDivider=-1

[TaskbarIconThemeFolder]
Measure=Plugin
Plugin=FileView
Path="#ROOTCONFIGPATH#Themes\#Theme#\Icons"
Count=([TaskbarIconThemeFileCount]+1)
HideExtensions=1
ShowFolder=0
FinishAction =[!CommandMeasure TaskbarScript gatherIconFile()][!UpdateMeasure TaskbarIconThemeFolder][!UpdateMeasure TaskbarIconThemeFolder_Child]
DynamicVariables=1

[TaskbarIconThemeFolder_Child]
Measure=Plugin
Plugin=FileView
Path=[TaskbarIconThemeFolder]
Type=FileName
Index=2

[GetActiveProcess]
Measure=PLugin
Plugin=RunCommand
Program=""#@#GetProcess.exe" "#PROGRAMPATH#Rainmeter.exe" "ActiveWindowProcess" "#RootConfig#""

[ProgramOptions]
Measure=Plugin
Plugin=ProgramOptions
Indexes=#Max_Tracking_Process#
AdditionalDependencies=#AdditionalDependencies#
WindowMirrorPath=#@#WindowMirror.exe

[TaskbarShape]
Meter=Shape
X=(#Bar_OffsetX#+#Taskbar_X#-#AnchorPoint#)
Y=#Bar_OffsetY#
Shape=Rectangle 0,0,0,0
Shape2=Rectangle 0,0,0,0
MouseOverHighlight = StrokeWidth 0 | Fill Color #Taskbar_MouseOver_Color#
AdaptiveBackground = StrokeWidth 0 | Fill Color #Color_Scheme1##AdaptiveBackground_Opacity#

[SubprocessTrackingShape]
Meter=Shape
X=(#Bar_OffsetX#+#Taskbar_X#-#AnchorPoint#)
Y=#Bar_OffsetY#
;Dummy shape. Subprocess tracking shape will be draw from Shape2.
Shape=Rectangle 0,0,0,0
;Change dots color here
DotColor = Fill Color #Color_Scheme3#
ActiveDotColor = Fill Color #Color_Scheme4#
[StyleIcon]
W=#Icon_Size#
PreserveAspectRatio=1
Y=(#Bar_Height#/2 - #Icon_Size#/2 + #Bar_OffsetY#)
DynamicVariables=1
ImageTint=#Icon_MouseLeave_TintColor#
MouseLeaveAction=[!CommandMeasure TaskbarScript "ProcessMouseLeave(#CURRENTSECTION#)"]
LeftMouseDownAction=[!SetVariable DraggingMeter #CURRENTSECTION#][!UpdateMeasure TaskbarMousePlugin][!UpdateMeasure MovingCondition][!CommandMeasure TaskbarMousePlugin "Start"][!SetOption MouseXDown Formula MouseXMove][!SetOption MouseXMove OnChangeAction "!UpdateMeasure MouseXDown"]
Antialias=1
Group=taskbar
[0]
Meter=Image
MeterStyle=StyleIcon
[1]
Meter=Image
MeterStyle=StyleIcon
[2]
Meter=Image
MeterStyle=StyleIcon
[3]
Meter=Image
MeterStyle=StyleIcon
[4]
Meter=Image
MeterStyle=StyleIcon
[5]
Meter=Image
MeterStyle=StyleIcon
[6]
Meter=Image
MeterStyle=StyleIcon
[7]
Meter=Image
MeterStyle=StyleIcon
[8]
Meter=Image
MeterStyle=StyleIcon
[9]
Meter=Image
MeterStyle=StyleIcon
[10]
Meter=Image
MeterStyle=StyleIcon
[11]
Meter=Image
MeterStyle=StyleIcon
[12]
Meter=Image
MeterStyle=StyleIcon
[13]
Meter=Image
MeterStyle=StyleIcon
[14]
Meter=Image
MeterStyle=StyleIcon
[15]
Meter=Image
MeterStyle=StyleIcon

[TaskbarMousePlugin]
Measure=Plugin
Plugin=Mouse
LeftMouseDragAction=[!CommandMeasure Taskbarscript "Dragging = true"][!SetOption MovingIconCalc Formula (clamp(floor(($MouseX$-#Taskbar_X#-#Bar_OffsetX#+#AnchorPoint#)/(#Icon_Gap#*2+#Icon_Size#)),0,#ProcessCount#-1))][!SetOption MouseXMove Formula $MouseX$][!UpdateMeasure MouseXMove][!UpdateMeasure MovingIconCalc][!SetOPtion MouseXMove OnChangeAction " "][!UpdateMeasure MouseXMove][!SetOption TaskbarShape Shape2 "Rectangle ([#draggingmeter#:X]-#Taskbar_X#-#Bar_OffsetX#+#AnchorPoint#-#Icon_Gap#),0,(#Icon_Gap#*2+#Icon_Size#),#Bar_Height# |Extend MouseOverHighlight"][!SetOption #draggingmeter# ImageTint ffffff][!UpdateMeter #draggingmeter#][!UpdateMeter TaskbarShape][!Redraw]
LeftMouseUpAction=[!CommandMeasure Taskbarscript "Dragging = false;DoneMoving()"][!CommandMeasure TaskbarMousePlugin "Stop"][!SetOption TaskbarShape Shape2 "Rectangle 0,0,0,0"][!SetOption #draggingmeter# ImageTint "#Icon_MouseLeave_TintColor#"][!UpdateMeter #draggingmeter#][!UpdateMeter TaskbarShape][!SetOption MouseXDown Formula 0][!SetOption MouseXMove Formula 0][!UpdateMeasure MouseXDown][!UpdateMeasure MouseXMove]
DynamicVariables=1
RequireDragging=1

[MouseXDown]
Measure=Calc
Formula=MouseXMove
UpdateDivider=-1
[MouseXMove]
Measure=Calc
Formula=0
[MovingCondition]
Measure=Calc
Formula=floor(abs(MouseXMove-MouseXDown)/10)
OnChangeAction=[!CommandMeasure Taskbarscript "clearShape()"][!SetOptionGroup taskbar LeftMouseUpAction " "][!SetOptionGroup taskbar MouseOverAction " "][!UpdateMeterGroup taskbar]
DynamicVariables=1

[MovingIconCalc]
Measure=Calc
Formula=0
OnChangeAction=[!CommandMeasure Taskbarscript "MovingIcon(#draggingmeter#,[MovingIconCalc])"]
DynamicVariables=1
