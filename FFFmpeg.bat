@echo off
title FFmpeg简易

:menu
cls
echo 请选择功能:
echo 1. 音视频合并
echo 2. 字幕合并
echo 3. 字幕合并(nvenc)
echo 4. 音频提取(copy)
echo 5. 音频提取
echo 6. 视频裁剪(copy)
echo 7. 视频裁剪
echo 8. 调整大小
echo 9. 退出

set /p choice=请输入选项:
if "%choice%"=="1" goto func1
if "%choice%"=="2" goto func2
if "%choice%"=="3" goto func3
if "%choice%"=="4" goto func4
if "%choice%"=="5" goto func5
if "%choice%"=="6" goto func6
if "%choice%"=="7" goto func7
if "%choice%"=="8" goto func8
if "%choice%"=="9" goto :eof

:func1
echo 您选择了音视频合并。
REM 在这里编写功能一的具体操作
set /p audio=请将【音频】文件拖拽到此处，按下回车确认:
set /p video=请将【视频】文件拖拽到此处，按下回车确认:
set /p output=请输入输出文件名(请写扩展名,默认为音视频合并.mp4):
if "%output%"=="" set output=音视频合并.mp4
ffmpeg.exe -i %audio% -i %video% -c:v copy -c:a aac -strict experimental %output%
echo.
echo 合并结束！
echo 文件已经输出到本地的 %output% 文件。
pause
goto menu

:func2
echo 您选择了字幕合并
set /p "subtitle=请将【字幕】文件拖拽到此处，按下回车确认: "
set /p "video=请将【视频】文件拖拽到此处，按下回车确认: "
REM 提取视频文件名（不含扩展名）
for %%i in ("%video%") do set "video_name=%%~ni"
set /p "output=请输入输出文件名(请写扩展名,默认为视频名_字幕合并.mkv): "
if "%output%"=="" set "output=%video_name%_字幕合并.mkv"
set /p "FS=请输入字体大小(默认12): "
if "%FS%"=="" set FS=12 
for %%i in ("%subtitle%") do set "subtitle_name=%%~nxi"
echo %subtitle_name%
ffmpeg -i "%video%" -lavfi "subtitles="%subtitle_name%":force_style='FontName=Tahoma,FontSize=%FS%,PrimaryColour=&H00FFFC'" "%output%"
echo 合并结束！
echo 文件已经输出到本地的 %output% 文件。
pause
goto menu

:func3
echo 您选择了字幕合并(nvenc)
set /p "subtitle=请将【字幕】文件拖拽到此处，按下回车确认: "
set /p "video=请将【视频】文件拖拽到此处，按下回车确认: "
REM 提取视频文件名（不含扩展名）
for %%i in ("%video%") do set "video_name=%%~ni"
set /p "output=请输入输出文件名(请写扩展名,默认为视频名_字幕合并.mkv): "
if "%output%"=="" set "output=%video_name%_字幕合并.mkv"
set /p "FS=请输入字体大小(默认12): "
if "%FS%"=="" set FS=12 
set /p "ML=码率(默认6000): "
if "%ML%"=="" set ML=6000
for %%i in ("%subtitle%") do set "subtitle_name=%%~nxi"
echo %subtitle_name%
ffmpeg -i "%video%" -c:v h264_nvenc -b:v %ML%k -lavfi "subtitles="%subtitle_name%":force_style='FontName=Tahoma,FontSize=%FS%,PrimaryColour=&H00FFFC'" "%output%"
echo 合并结束！
echo 文件已经输出到本地的 %output% 文件。
pause
goto menu


:func4
echo 您选择了音频提取(copy)
REM 在这里编写功能二的具体操作
set /p video=请将【视频】文件拖拽到此处，按下回车确认:
set /p output=请输入输出文件名(请写扩展名,默认为音频提取(copy).aac):
if "%output%"=="" set output=音频提取(copy).aac
ffmpeg -i %video% -vn -c:a copy %output%
echo.
echo 提取结束！
echo 文件已经输出到本地的 %output% 文件。
pause
goto menu

:func5
echo 您选择了音频提取
REM 在这里编写功能二的具体操作
set /p video=请将【视频】文件拖拽到此处，按下回车确认:
set /p output=请输入输出文件名(请写扩展名,默认为音频提取.aac):
if "%output%"=="" set output=音频提取.aac
ffmpeg -i %video% -vn %output%
echo.
echo 提取结束！
echo 文件已经输出到本地的 %output% 文件。
pause
goto menu

:func6
echo 您选择了视频裁剪(copy)
REM 在这里编写功能二的具体操作
set /p video=请将【视频】文件拖拽到此处，按下回车确认:
set /p sst=请输入开始时间(00:00:00.000),按下回车确认:
set /p tt=请输入持续时间(00:00:00.000)，按下回车确认:
set /p output=请输入输出文件名(请写扩展名,默认为视频裁剪(copy).mp4):
if "%output%"=="" set output=视频裁剪(copy).mp4
ffmpeg -ss %sst% -i %video% -t %tt% -vcodec copy %output%
echo.
echo 裁剪结束！
echo 文件已经输出到本地的 %output% 文件。
pause
goto menu

:func7
echo 您选择了视频裁剪
REM 在这里编写功能二的具体操作
set /p video=请将【视频】文件拖拽到此处，按下回车确认:
set /p sst=请输入开始时间(00:00:00.000),按下回车确认:
set /p tt=请输入持续时间(00:00:00.000)，按下回车确认:
set /p output=请输入输出文件名(请写扩展名,默认为视频裁剪.mp4):
if "%output%"=="" set output=视频裁剪.mp4
ffmpeg -ss %sst% -i %video% -t %tt% %output%
echo.
echo 裁剪结束！
echo 文件已经输出到本地的 %output% 文件。
pause
goto menu

:func8
echo 您选择了调整大小
REM 在这里编写功能二的具体操作
set /p video=请将【视频】文件拖拽到此处，按下回车确认:
set /p scale=请输入裁剪尺寸:
set /p output=请输入输出文件名(请写扩展名,默认为调整大小.mp4):
if "%output%"=="" set output=调整大小.mp4
ffmpeg -i %video% -vf scale=%scale% %output%
echo.
echo 调整结束！
echo 文件已经输出到本地的 %output% 文件。
pause
goto menu