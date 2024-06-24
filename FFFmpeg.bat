@echo off
title FFmpeg����

:menu
cls
echo ��ѡ����:
echo 1. ����Ƶ�ϲ�
echo 2. ��Ļ�ϲ�
echo 3. ��Ļ�ϲ�(nvenc)
echo 4. ��Ƶ��ȡ(copy)
echo 5. ��Ƶ��ȡ
echo 6. ��Ƶ�ü�(copy)
echo 7. ��Ƶ�ü�
echo 8. ������С
echo 9. �˳�

set /p choice=������ѡ��:
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
echo ��ѡ��������Ƶ�ϲ���
REM �������д����һ�ľ������
set /p audio=�뽫����Ƶ���ļ���ק���˴������»س�ȷ��:
set /p video=�뽫����Ƶ���ļ���ק���˴������»س�ȷ��:
set /p output=����������ļ���(��д��չ��,Ĭ��Ϊ����Ƶ�ϲ�.mp4):
if "%output%"=="" set output=����Ƶ�ϲ�.mp4
ffmpeg.exe -i %audio% -i %video% -c:v copy -c:a aac -strict experimental %output%
echo.
echo �ϲ�������
echo �ļ��Ѿ���������ص� %output% �ļ���
pause
goto menu

:func2
echo ��ѡ������Ļ�ϲ�
set /p "subtitle=�뽫����Ļ���ļ���ק���˴������»س�ȷ��: "
set /p "video=�뽫����Ƶ���ļ���ק���˴������»س�ȷ��: "
REM ��ȡ��Ƶ�ļ�����������չ����
for %%i in ("%video%") do set "video_name=%%~ni"
set /p "output=����������ļ���(��д��չ��,Ĭ��Ϊ��Ƶ��_��Ļ�ϲ�.mkv): "
if "%output%"=="" set "output=%video_name%_��Ļ�ϲ�.mkv"
set /p "FS=�����������С(Ĭ��12): "
if "%FS%"=="" set FS=12 
for %%i in ("%subtitle%") do set "subtitle_name=%%~nxi"
echo %subtitle_name%
ffmpeg -i "%video%" -lavfi "subtitles="%subtitle_name%":force_style='FontName=Tahoma,FontSize=%FS%,PrimaryColour=&H00FFFC'" "%output%"
echo �ϲ�������
echo �ļ��Ѿ���������ص� %output% �ļ���
pause
goto menu

:func3
echo ��ѡ������Ļ�ϲ�(nvenc)
set /p "subtitle=�뽫����Ļ���ļ���ק���˴������»س�ȷ��: "
set /p "video=�뽫����Ƶ���ļ���ק���˴������»س�ȷ��: "
REM ��ȡ��Ƶ�ļ�����������չ����
for %%i in ("%video%") do set "video_name=%%~ni"
set /p "output=����������ļ���(��д��չ��,Ĭ��Ϊ��Ƶ��_��Ļ�ϲ�.mkv): "
if "%output%"=="" set "output=%video_name%_��Ļ�ϲ�.mkv"
set /p "FS=�����������С(Ĭ��12): "
if "%FS%"=="" set FS=12 
set /p "ML=����(Ĭ��6000): "
if "%ML%"=="" set ML=6000
for %%i in ("%subtitle%") do set "subtitle_name=%%~nxi"
echo %subtitle_name%
ffmpeg -i "%video%" -c:v h264_nvenc -b:v %ML%k -lavfi "subtitles="%subtitle_name%":force_style='FontName=Tahoma,FontSize=%FS%,PrimaryColour=&H00FFFC'" "%output%"
echo �ϲ�������
echo �ļ��Ѿ���������ص� %output% �ļ���
pause
goto menu


:func4
echo ��ѡ������Ƶ��ȡ(copy)
REM �������д���ܶ��ľ������
set /p video=�뽫����Ƶ���ļ���ק���˴������»س�ȷ��:
set /p output=����������ļ���(��д��չ��,Ĭ��Ϊ��Ƶ��ȡ(copy).aac):
if "%output%"=="" set output=��Ƶ��ȡ(copy).aac
ffmpeg -i %video% -vn -c:a copy %output%
echo.
echo ��ȡ������
echo �ļ��Ѿ���������ص� %output% �ļ���
pause
goto menu

:func5
echo ��ѡ������Ƶ��ȡ
REM �������д���ܶ��ľ������
set /p video=�뽫����Ƶ���ļ���ק���˴������»س�ȷ��:
set /p output=����������ļ���(��д��չ��,Ĭ��Ϊ��Ƶ��ȡ.aac):
if "%output%"=="" set output=��Ƶ��ȡ.aac
ffmpeg -i %video% -vn %output%
echo.
echo ��ȡ������
echo �ļ��Ѿ���������ص� %output% �ļ���
pause
goto menu

:func6
echo ��ѡ������Ƶ�ü�(copy)
REM �������д���ܶ��ľ������
set /p video=�뽫����Ƶ���ļ���ק���˴������»س�ȷ��:
set /p sst=�����뿪ʼʱ��(00:00:00.000),���»س�ȷ��:
set /p tt=���������ʱ��(00:00:00.000)�����»س�ȷ��:
set /p output=����������ļ���(��д��չ��,Ĭ��Ϊ��Ƶ�ü�(copy).mp4):
if "%output%"=="" set output=��Ƶ�ü�(copy).mp4
ffmpeg -ss %sst% -i %video% -t %tt% -vcodec copy %output%
echo.
echo �ü�������
echo �ļ��Ѿ���������ص� %output% �ļ���
pause
goto menu

:func7
echo ��ѡ������Ƶ�ü�
REM �������д���ܶ��ľ������
set /p video=�뽫����Ƶ���ļ���ק���˴������»س�ȷ��:
set /p sst=�����뿪ʼʱ��(00:00:00.000),���»س�ȷ��:
set /p tt=���������ʱ��(00:00:00.000)�����»س�ȷ��:
set /p output=����������ļ���(��д��չ��,Ĭ��Ϊ��Ƶ�ü�.mp4):
if "%output%"=="" set output=��Ƶ�ü�.mp4
ffmpeg -ss %sst% -i %video% -t %tt% %output%
echo.
echo �ü�������
echo �ļ��Ѿ���������ص� %output% �ļ���
pause
goto menu

:func8
echo ��ѡ���˵�����С
REM �������д���ܶ��ľ������
set /p video=�뽫����Ƶ���ļ���ק���˴������»س�ȷ��:
set /p scale=������ü��ߴ�:
set /p output=����������ļ���(��д��չ��,Ĭ��Ϊ������С.mp4):
if "%output%"=="" set output=������С.mp4
ffmpeg -i %video% -vf scale=%scale% %output%
echo.
echo ����������
echo �ļ��Ѿ���������ص� %output% �ļ���
pause
goto menu