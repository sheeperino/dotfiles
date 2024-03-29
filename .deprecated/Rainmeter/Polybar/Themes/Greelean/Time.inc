[Variables]
Time_X=1587
;Left, Right or Center
Time_Anchor=Right

[Metadata]
Name=Greenlean\\Clock
Author=reddit.com/u/khanhas
Description=Clock with material icon.

[TimeAnchor]
Measure=String
String = #Time_Anchor#
IfMatch = Center|center|Middle|middle
IfMatchAction = [!SetOption TimeIcon X "(#Bar_OffsetX#+#*Time_X*#-([*TimeIcon:W*]+[*Time:W*]+5)/2)"][!SetOption Time X 5R]
IfMatch2 = Right|right
IfMatchAction2 = [!SetOption TimeIcon StringAlign RightCenter][!SetOption Time StringAlign RightCenter][!SetOption TimeIcon X "([*Time:X*]-5)"][!SetOption Time X "(#Bar_OffsetX#+#*Time_X*#)"]

[MeasureTime]
Measure=Time
Format=%I:%M

[TimeIcon]
Meter=String
Text=
FontFace=Material Icons
FontSize=(#Font_Size#*16/13)
FontColor=#Color_Scheme2#
AntiAlias=1
StringAlign=LeftCenter
X=(#Bar_OffsetX#+#Time_X#)
Y=(#Bar_OffsetY#+#Bar_Height#/2)
DynamicVariables=1

[Time]
Meter=String
MeasureName=MeasureTime
FontFace=#Font_Face#
FontSize=#Font_Size#
FontColor=#Color_Scheme2#
AntiAlias=1
StringAlign=LeftCenter
X=5R
Y=r
DynamicVariables=1
