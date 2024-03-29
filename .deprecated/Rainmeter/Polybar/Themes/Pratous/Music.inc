[Variables]
music_X =702
music_Width = 400
music_Current_Player=Spotify
music_NowPlaying_Player=Itunes

[Metadata]
Name=Paper\\Music
Author=reddit.com/u/khanhas
Description=Display song name and artist with next and previous control. Click at text to play/pause. Right click at text to activate Music Control to show track progress, player changer.

[MusicChooseMeasure]
Measure=String
String=#music_Current_Player#
DynamicVariables=1
IfMatch=(?i)webnowplaying
IfMatchAction=[!EnableMeasureGroup WebNowPlaying]
IfMatch2=(?i)spotify
IfMatchAction2=[!EnableMeasureGroup Spotify]
IfMatch3=(?i)nowplaying
IfMatchAction3=[!EnableMeasureGroup NowPlaying]
IfMatch4=(?i)gpmdp
IfMatchAction4=[!EnableMeasureGroup GPMDP]

;-------WEBNOWPLAYING-------
[WebNowPlayingTrack]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Title
Substitute="":"N/A"
OnChangeAction=[!UpdateMeter MusicTrackTitle][!Redraw]
Disabled=1
Group=WebNowPlaying

[WebNowPlayingArtist]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Artist
Substitute="":"N/A"
Disabled=1
Group=WebNowPlaying

[WebNowPlayingControl]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=State
Disabled=1
Group=WebNowPlaying

;-------SPOTIFY-------
[SpotifyTrack]
Measure=Plugin
Plugin=SpotifyPlugin.dll
Type=TrackName
Substitute="":"N/A"
OnChangeAction=[!UpdateMeter MusicTrackTitle][!Redraw]
Disabled=1
Group=Spotify

[SpotifyArtist]
Measure=Plugin
Plugin=SpotifyPlugin.dll
Type=ArtistName
Substitute="":"N/A"
Disabled=1
Group=Spotify

[SpotifyControl]
Measure=Plugin
Plugin=NowPlaying
PlayerName=Spotify
PlayerType=Artist
Disabled=1
Group=Spotify

;-------GPMDP-------------
[GPMDPTrack]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=Title
Substitute="":"N/A"
OnChangeAction=[!UpdateMeter MusicTrackTitle][!Redraw]
Disabled=1
Group=GPMDP

[GPMDPArtist]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=Artist
Substitute="":"N/A"
Disabled=1
Group=GPMDP

[GPMDPControl]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=State
Disabled=1
Group=GPMDP
;-------NOWPLAYING-------
[NowPlayingTrack]
Measure=Plugin
Plugin=NowPlaying
PlayerName=#music_NowPlaying_Player#
PlayerType=Title
Substitute="":"N/A"
OnChangeAction=[!UpdateMeter MusicTrackTitle][!Redraw]
Disabled=1
Group=NowPlaying

[NowPlayingArtist]
Measure=Plugin
Plugin=NowPlaying
PlayerName=#music_NowPlaying_Player#
PlayerType=Artist
Substitute="":"N/A"
Disabled=1
Group=NowPlaying

[NowPlayingControl]
Measure=Plugin
Plugin=NowPlaying
PlayerName=#music_NowPlaying_Player#
PlayerType=State
Disabled=1
Group=NowPlaying

[MusicPrevious]
Meter=String
Text=
FontFace=Material Icons
FontSize=(#Font_Size#*20/13)
FontColor=#Color_Scheme2#
AntiAlias=1
StringAlign=LeftCenter
X=(#Bar_OffsetX#+#music_X#)
Y=(#Bar_OffsetY#+#Bar_Height#/2+2)
LeftMouseUpAction=[!CommandMeasure #music_Current_Player#Control "Previous"]
DynamicVariables=1

[MusicTrackTitle]
Meter=String
MeasureName=#music_Current_Player#Track
MeasureName2=#music_Current_Player#Artist
Text=%1 - %2
FontFace=#Font_Face#
FontSize=#Font_Size#
AntiAlias=1
StringAlign=CenterCenter
FontColor=#Color_Scheme2#
ClipString=2
W=#music_Width#
ClipStringH=#Bar_Height#
X=(#music_Width#/2)R
Y=r
LeftMouseUpAction=[!CommandMeasure #music_Current_Player#Control "PlayPause"]
DynamicVariables=1
RightMouseUpAction=[!WriteKeyValue Variables MusicControl_Current_Player #music_Current_Player# "#ROOTCONFIGPATH#Themes\#Theme#\Additional_Comps_And_Scripts\MusicControl.ini"][!WriteKeyValue Variables MusicControl_NowPlaying_Player #music_NowPlaying_Player# "#ROOTCONFIGPATH#Themes\#Theme#\Additional_Comps_And_Scripts\MusicControl.ini"][!WriteKeyValue Variables Curr_X ([MusicTrackTitle:X]+#Music_Width#/2+#CURRENTCONFIGX#) "#ROOTCONFIGPATH#Themes\#Theme#\Additional_Comps_And_Scripts\MusicControl.ini"][!WriteKeyValue Variables Curr_Y [SubSkinYPositionCalc] "#ROOTCONFIGPATH#Themes\#Theme#\Additional_Comps_And_Scripts\MusicControl.ini"][!WriteKeyValue Variables Dir [SubSkinDirectionCalc] "#ROOTCONFIGPATH#\Themes\#Theme#\Additional_Comps_And_Scripts\MusicControl.ini"][!ActivateConfig "#ROOTCONFIG#\Themes\#Theme#\Additional_Comps_And_Scripts" "MusicControl.ini"]

[MusicNext]
Meter=String
MeterStyle=MusicPrevious
Text=
X=(#music_Width#/2)r
StringAlign=LeftCenter
LeftMouseUpAction=[!CommandMeasure #music_Current_Player#Control "Next"]
