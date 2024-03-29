[Variables]
Tray_X=1601

[Metadata]
Name=Greenlean\\Tray
Author=reddit.com/u/khanhas
Description=Click to show tray

[TrayShape]
Meter=Shape
X=(#Bar_OffsetX#+#Tray_X#)
Y=#Bar_OffsetY#
Shape=Rectangle 0,#Tile_Space#,([TrayButton:W]+#Bar_Height#/4),(#Bar_Height#-2*#Tile_Space#) | StrokeWidth 0 | Extend FillColor
FillColor=Fill Color 00000001
MouseOverAction=[!SetOption TrayShape FillColor "Fill Color #Color_Scheme3#"][!UpdateMeter TrayShape][!Redraw]
MouseLeaveAction=[!SetOption TrayShape FillColor "Fill Color 00000001"][!UpdateMeter TrayShape][!Redraw]
DynamicVariables=1

[TrayXPos]
Measure=Calc
Formula=#CURRENTCONFIGX#+[TrayButton:X]+[TrayButton:W]/2
DynamicVariables=1

[TrayIconDirection]
Measure=String
String=
IfCondition=SubSkinDirectionCalc = 1
IfTrueAction=[!SetOption TrayIconDirection String ""]
IfFalseAction=[!SetOption TrayIconDirection String ""]
DynamicVariables=1 

[TrayButton]
Meter=String
MeasureName=TrayIconDirection
FontFace=Material Icons
FontSize=(#Font_Size#*16/13)
FontColor=#Color_Scheme2#
AntiAlias=1
StringAlign=CenterCenter
X=(#Bar_Height#/8+[TrayButton:W]/2)r
Y=(#Bar_OffsetY#+#Bar_Height#/2)
SolidColor=0,0,0,1
LeftMouseDownAction=["#@#ActivateTray.exe" "[TrayXPos]" "[SubSkinYPositionCalc]" "[SubSkinDirectionCalc]"]
DynamicVariables=1
