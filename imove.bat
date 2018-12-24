@ECHO OFF
ECHO ----------------------------------------------
ECHO.                imove v1-beta
ECHO ----------------------------------------------
ECHO.
ECHO Windows batch file (for backwards compatibility) for moving user data between Windows systems.
ECHO.
ECHO *NOTICE: Please run this as an administrator from the profile you wish to manipulate. Otherwise, it may not work.
ECHO.
ECHO ----------------------------------------------
ECHO.
PAUSE
GOTO MAININPUT

:MAININPUT
	SET MODE=001
	SET XDIRS=NONE
	SET XFILES=NONE
	
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO * Currently logged-in profile: C:\Users\%USERNAME%\
	ECHO.
	ECHO Please enter a job name. (Avoid spaces, non-alphanumeric chars, etc.)
	ECHO.
	SET /p COPYJOB=">> %USERNAME%: "
	ECHO.
	ECHO Quick transfer or advanced? (quick/advanced)
	ECHO.
	SET /p USERINPUT=">> %USERNAME%: "
	IF %USERINPUT%==quick GOTO QINPUT00
	IF %USERINPUT%==advanced GOTO AINPUT0S
	IF %USERINPUT%==q GOTO QINPUT00
	IF %USERINPUT%==a GOTO AINPUT0S
	SET VALIDENTRIES=quick/advanced
	GOTO BADINPUT
	
:BADINPUT
	ECHO.
	ECHO ERROR: Invalid entry! (valid entries: %VALIDENTRIES%)
	IF %MODE%==001 GOTO MAININPUT
	IF %MODE%==Q00 GOTO QINPUT00
	IF %MODE%==A00 GOTO AINPUT00
	IF %MODE%==Q1S GOTO QINPUT1S
	IF %MODE%==Q1D GOTO QINPUT1D
	IF %MODE%==QSS GOTO QSSUMMARY
	IF %MODE%==QDS GOTO QDSUMMARY
	IF %MODE%==A3S GOTO AINPUT3S
	IF %MODE%==A5S GOTO AINPUT5S
	IF %MODE%==ASS GOTO ASSUMMARY
	
	
	ECHO FATAL ERROR: Unhandled input error, defaulting to startup!
	GOTO MAININPUT
	
:QINPUT00
	SET MODE=Q00
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO * Currently logged-in profile: C:\Users\%USERNAME%\
	ECHO * Operation mode: Quick transfer
	ECHO * Job: %COPYJOB%
	ECHO.
	ECHO Is this the source or destination machine? (source/destination/back)
	ECHO.
	SET /p USERINPUT=">> %USERNAME%: "
	IF %USERINPUT%==source GOTO QINPUT1S
	IF %USERINPUT%==destination GOTO QINPUT1D
	IF %USERINPUT%==s GOTO QINPUT1S
	IF %USERINPUT%==d GOTO QINPUT1D
	IF %USERINPUT%==back GOTO MAININPUT
	IF %USERINPUT%==b GOTO MAININPUT
	SET VALIDENTRIES=source/destination/back
	GOTO BADINPUT
	
:QINPUT1S
	SET MODE=Q1S
	SET PROFILE=%USERNAME%
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO * Currently logged-in profile: C:\Users\%USERNAME%\
	ECHO * Operation mode: Quick transfer
	ECHO * Job: %COPYJOB%
	ECHO * System-data relation: Source
	ECHO * Copying default user directories (Desktop, Documents, Music, Pictures, Videos) from \%USERNAME%\
	ECHO.
	ECHO Please select a destination.
	ECHO.
	SET /p USERINPUT=">> %USERNAME%: "
	IF %USERINPUT%==back GOTO QINPUT00
	IF %USERINPUT%==b GOTO QINPUT00
	SET DESTINATION=%USERINPUT%
	GOTO QSSUMMARY	
	
:QINPUT1D
	SET MODE=Q1D
	SET PROFILE=%USERNAME%
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO * Currently logged-in profile: C:\Users\%USERNAME%\
	ECHO * Operation mode: Quick transfer
	ECHO * Job: %COPYJOB%
	ECHO * System-data relation: Destination
	ECHO * Copying default user directories (Desktop, Documents, Music, Pictures, Videos) to \%USERNAME%\
	ECHO.
	ECHO Please select a the source. (Your /COPY_JOB_NAME/ location, including the /COPY_JOB_NAME directory)
	ECHO.
	SET /p USERINPUT=">> %USERNAME%: "
	IF %USERINPUT%==back GOTO QINPUT00
	IF %USERINPUT%==b GOTO QINPUT00
	SET SOURCE=%USERINPUT%
	GOTO QDSUMMARY	
	
:AINPUT0S
	SET MODE=A0S
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO * Currently logged-in profile: C:\Users\%USERNAME%\
	ECHO * Operation mode: Advanced
	ECHO * Job: %COPYJOB%
	ECHO.
	ECHO Please specify a target.
	ECHO.
	SET /p USERINPUT=">> %USERNAME%: "
	IF %USERINPUT%==back GOTO MAININFO
	IF %USERINPUT%==b GOTO MAININFO
	SET TARGET=%USERINPUT%
	GOTO AINPUT2S

:AINPUT2S
	SET MODE=A2S
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO * Currently logged-in profile: C:\Users\%USERNAME%\
	ECHO * Operation mode: Advanced
	ECHO * Job: %COPYJOB%
	ECHO * Target: %TARGET%
	ECHO.
	ECHO Please specify a destination.
	ECHO.
	SET /p USERINPUT=">> %USERNAME%: "
	IF %USERINPUT%==back GOTO QINPUT00
	IF %USERINPUT%==b GOTO QINPUT00
	SET DESTINATION=%USERINPUT%
	GOTO AINPUT3S
	
:AINPUT3S
	SET MODE=A3S
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO * Currently logged-in profile: C:\Users\%USERNAME%\
	ECHO * Operation mode: Advanced
	ECHO * Job: %COPYJOB%
	ECHO * Target: %TARGET%
	ECHO * Destination: %DESTINATION%
	ECHO.
	ECHO Exclude any directories? (yes/no/back)
	ECHO.
	SET /p USERINPUT=">> %USERNAME%: "
	IF %USERINPUT%==back GOTO AINPUT2S
	IF %USERINPUT%==b GOTO AINPUT2S
	IF %USERINPUT%==yes GOTO AINPUT4S
	IF %USERINPUT%==no GOTO AINPUT5S
	IF %USERINPUT%==y GOTO AINPUT4S
	IF %USERINPUT%==n GOTO AINPUT5S
	SET VALIDENTRIES=yes/no/back
	GOTO BADINPUT
	
:AINPUT4S
	SET MODE=A4S
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO * Enter directories to exclude, separated by a comma.
	ECHO.
	ECHO * Example: C:\Users\user\Desktop, C:\Users\user\Documents
	ECHO.
	ECHO Directories to exclude:
	ECHO.
	SET /p USERINPUT=">> %USERNAME%: "
	SET XDIRS=%USERINPUT%
	GOTO AINPUT5S
	
	
:AINPUT5S
	SET MODE=A5S
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO * Currently logged-in profile: C:\Users\%USERNAME%\
	ECHO * Operation mode: Advanced
	ECHO * Job: %COPYJOB%
	ECHO * Target: %TARGET%
	ECHO * Destination: %DESTINATION%
	ECHO.
	ECHO Exclude any files? (yes/no/back)
	ECHO.
	SET /p USERINPUT=">> %USERNAME%: "
	IF %USERINPUT%==back GOTO AINPUT3S
	IF %USERINPUT%==b GOTO AINPUT3S
	IF %USERINPUT%==yes GOTO AINPUT6S
	IF %USERINPUT%==no GOTO AINPUT7S
	IF %USERINPUT%==y GOTO AINPUT6S
	IF %USERINPUT%==n GOTO AINPUT7S
	SET VALIDENTRIES=yes/no/back
	GOTO BADINPUT
	
:AINPUT6S
	SET MODE=A6S
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO * Enter files to exclude, separated by a comma.
	ECHO.
	ECHO * Example: C:\Users\user\Desktop\this.docx, *.cab
	ECHO.
	ECHO Files to exclude:
	ECHO.
	SET /p USERINPUT=">> %USERNAME%: "
	SET XFILES=%USERINPUT%
	GOTO AINPUT7S
	
:AINPUT7S
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO Configuration complete!
	ECHO.
	PAUSE
	GOTO ASSUMMARY
	
	
:ASSUMMARY
	SET MODE=ASS
	ECHO.
	ECHO ----------------------------------------------
	ECHO Job summary:
	ECHO.
	ECHO * Job: %COPYJOB%
	ECHO.
	ECHO * Copying:
	ECHO -- %TARGET%
	ECHO.
	ECHO * To:
	ECHO -- %DESTINATION%
	ECHO.
	ECHO * Using sane system defaults.
	ECHO.
	ECHO * Excluded directories:
	ECHO -- %XDIRS%
	ECHO.
	ECHO * Excluded files:
	ECHO -- %XFILES%
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO Execute job? (yes/no)
	ECHO.
	SET /p USERINPUT=">> %USERNAME%: "
	IF %USERINPUT%==yes GOTO ARUNS
	IF %USERINPUT%==no GOTO AINPUT0S
	IF %USERINPUT%==y GOTO ARUNS
	IF %USERINPUT%==n GOTO AINPUT0S
	SET VALIDENTRIES=yes/no
	GOTO BADINPUT
	
:QSSUMMARY
	SET MODE=QSS
	ECHO.
	ECHO ----------------------------------------------
	ECHO Job summary:
	ECHO.
	ECHO * Job: %COPYJOB%
	ECHO.
	ECHO * Copying:
	ECHO -- C:\Users\%PROFILE%\Desktop
	ECHO -- C:\Users\%PROFILE%\Documents
	ECHO -- C:\Users\%PROFILE%\Pictures
	ECHO -- C:\Users\%PROFILE%\Music
	ECHO -- C:\Users\%PROFILE%\Videos
	ECHO.
	ECHO * To:
	ECHO -- %DESTINATION%\%COPYJOB%\
	ECHO.
	ECHO * Using sane system defaults.
	ECHO.
	ECHO * Excluded directories: %XDIRS%
	ECHO.
	ECHO * Excluded files: %XFILES%
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO Execute job? (yes/no)
	ECHO.
	SET /p USERINPUT=">> %USERNAME%: "
	IF %USERINPUT%==yes GOTO QRUNS
	IF %USERINPUT%==no GOTO QINPUT1S
	IF %USERINPUT%==y GOTO QRUNS
	IF %USERINPUT%==n GOTO QINPUT1S
	SET VALIDENTRIES=yes/no
	GOTO BADINPUT
	
:QDSUMMARY
	SET MODE=QDS
	ECHO.
	ECHO ----------------------------------------------
	ECHO Job summary:
	ECHO.
	ECHO * Job: %COPYJOB%
	ECHO.
	ECHO * Copying:
	ECHO -- %SOURCE%\Desktop
	ECHO -- %SOURCE%\Documents
	ECHO -- %SOURCE%\Music
	ECHO -- %SOURCE%\Pictures
	ECHO -- %SOURCE%\Videos
	ECHO.
	ECHO * To:
	ECHO -- C:\Users\%PROFILE%\Desktop
	ECHO -- C:\Users\%PROFILE%\Documents
	ECHO -- C:\Users\%PROFILE%\Music
	ECHO -- C:\Users\%PROFILE%\Pictures
	ECHO -- C:\Users\%PROFILE%\Videos
	ECHO.
	ECHO * Using sane system defaults.
	ECHO.
	ECHO * Excluded directories: %XDIRS%
	ECHO.
	ECHO * Excluded files: %XFILES%
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO Execute job? (yes/no)
	ECHO.
	SET /p USERINPUT=">> %USERNAME%: "
	IF %USERINPUT%==yes GOTO QRUND
	IF %USERINPUT%==no GOTO QINPUT1D
	IF %USERINPUT%==y GOTO QRUND
	IF %USERINPUT%==n GOTO QINPUT1D
	SET VALIDENTRIES=yes/no
	GOTO BADINPUT
	
:QRUNS
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO Starting export process...
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO.>"%DESTINATION%\%COPYJOB%\log.txt"
	robocopy C:\Users\%PROFILE%\Desktop %DESTINATION%\%COPYJOB%\Desktop /E /COPYALL /R:6 /W:10 
	robocopy C:\Users\%PROFILE%\Documents %DESTINATION%\%COPYJOB%\Documents /E /COPYALL /R:6 /W:10 
	robocopy C:\Users\%PROFILE%\Pictures %DESTINATION%\%COPYJOB%\Pictures /E /COPYALL /R:6 /W:10 
	robocopy C:\Users\%PROFILE%\Music %DESTINATION%\%COPYJOB%\Music /E /COPYALL /R:6 /W:10 
	robocopy C:\Users\%PROFILE%\Videos %DESTINATION%\%COPYJOB%\Videos /E /COPYALL /R:6 /W:10 
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO Export job complete!
	ECHO.
	ECHO Please put imove.bat into the \%COPYJOB%\ folder, and transfer them to the system you will be populating.
	GOTO END
	
:QRUND
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO Starting import process...
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	robocopy %SOURCE%\Desktop C:\Users\%PROFILE%\Desktop /E /COPYALL /R:6 /W:10 
	robocopy %SOURCE%\Documents C:\Users\%PROFILE%\Documents /E /COPYALL /R:6 /W:10
	robocopy %SOURCE%\Pictures C:\Users\%PROFILE%\Pictures /E /COPYALL /R:6 /W:10 
	robocopy %SOURCE%\Music C:\Users\%PROFILE%\Music /E /COPYALL /R:6 /W:10  
	robocopy %SOURCE%\Videos C:\Users\%PROFILE%\Videos  /E /COPYALL /R:6 /W:10 
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO Import job complete!
	GOTO END
	
:ARUNS
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO Starting copy process...
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	IF %XDIRS%==NONE (
		SET "XDIRS_SWITCH="
		) ELSE (
		SET "XDIRS_SWITCH= /XD %XDIRS%"
		)
	IF %XFILES%==NONE (
		SET "XFILES_SWITCH="
		) ELSE (
		SET "XFILES_SWITCH= /XF %XFILES%"
		)
	ECHO --DEBUG: XFILES_SWITCH(%XFILES_SWITCH%)
	ECHO --DEBUG: XDIRS_SWITCH(%DIRS_SWITCH%)
	ECHO --DEBUG: DESTINATION(%DESTINATION%)
	ECHO --DEBUG: TARGET(%TARGET%)
	
	robocopy %TARGET% %DESTINATION%%XDIRS_SWITCH%%XFILES_SWITCH% /E /COPYALL /R:6 /W:10 
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO Copy job complete!
	GOTO END


:END
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	ECHO imove service complete! (exiting...)
	ECHO.
	ECHO ----------------------------------------------
	ECHO.
	PAUSE
	END
