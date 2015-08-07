; CopyBuffer.nsi
;
; This script is based on example1.nsi, but it remember the directory,
; has uninstall support and (optionally) installs start menu shortcuts.
;
; It will install CopyBuffer.nsi into a directory that the user selects,

;--------------------------------

; The name of the installer
Name "CopyBuffer"

; The file to write
OutFile "CopyBuffer.exe"

; The default installation directory
InstallDir $PROGRAMFILES\CopyBuffer

; Registry key to check for directory (so if you install again, it will
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\CopyBuffer" "Install_Dir"

; Request application privileges for Windows Vista
RequestExecutionLevel admin

;--------------------------------

; Pages

Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;--------------------------------


;--------------------------------

; The stuff to install
Section "CopyBuffer (required)"

  SectionIn RO

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  CreateDirectory "$DOCUMENTS\CopyBuffer\WatchFolder"
  FileOpen $0 "$DOCUMENTS\CopyBuffer\WatchFolder\CopyBuffer.txt" w
  FileClose $0

  InitPluginsDir
  NSISdl::download http://leelusoft.altervista.org/alterpages/files/W4F25Free.zip "$PLUGINSDIR\W4F25Free.zip"
  Pop $R0 ;Get the return value
  StrCmp $R0 "success" +3
    MessageBox MB_OK "Download failed: $R0"
    Quit

  nsisunz::UnzipToLog "$PLUGINSDIR\W4F25Free.zip" "$INSTDIR"
  Pop $R0
  StrCmp $R0 "success" +2
    DetailPrint "$R0" ;print error message to log

  ; Put file there
  File "CopyBuffer.nsi"
  File "Parts\*"
  ; Put W4F25 config file in place
  ; Now rewrite the settings file with links to the proper place
  ClearErrors
  FileOpen $0 "settings.cfg" "r"     ; open target file for reading
  GetTempFileName $R0                            ; get new temp file name
  FileOpen $1 $R0 "w"                            ; open temp file for writing
  loop:
     FileRead $0 $2                              ; read line from target file
     IfErrors done                               ; check if end of file reached
     StrCmp $2 "path=$\r$\n" 0 +2      ; compare line with search string with CR/LF
        StrCpy $2 "path=$DOCUMENTS\CopyBuffer\WatchFolder\$\r$\n"    ; change line
     StrCmp $2 "path=" 0 +2            ; compare line with search string without CR/LF (at the end of the file)
        StrCpy $2 "path=$DOCUMENTS\CopyBuffer\WatchFolder\"          ; change line
     FileWrite $1 $2                             ; write changed or unchanged line to temp file
     Goto loop
 
  done:
     FileClose $0                                ; close target file
     FileClose $1                                ; close temp file
     Delete "settings.cfg"                           ; delete target file
     CopyFiles /SILENT $R0 "$TEMP\W4F25\settings.cfg"            ; copy temp file to target file
     Delete $R0                                  ; delete temp file

  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\CopyBuffer "Install_Dir" "$INSTDIR"
  ; Write the Run commands
  ;WriteRegStr HKLM “Software\Microsoft\Windows\CurrentVersion\Run” “WatchFolder” “$INSTDIR\W4F25.exe”
  ;WriteRegStr HKCU “Software\Microsoft\Windows\CurrentVersion\Run” “WatchFolder” “$INSTDIR\W4F25.exe”
  CreateShortCut “$SMSTARTUP\W4F25.lnk” “$INSTDIR\W4F25.exe”

  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CopyBuffer" "DisplayName" "NSIS CopyBuffer"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CopyBuffer" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CopyBuffer" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CopyBuffer" "NoRepair" 1
  WriteUninstaller "uninstall.exe"

SectionEnd

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts"

  CreateDirectory "$SMPROGRAMS\CopyBuffer"
  CreateShortcut "$SMPROGRAMS\CopyBuffer\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  CreateShortcut "$SMPROGRAMS\CopyBuffer\CopyBuffer (ACE).lnk" "$INSTDIR\CopyBuffer.exe" "" "$INSTDIR\CopyBuffer.exe" 0
  CreateShortcut "$SMPROGRAMS\CopyBuffer\WatchFolder.lnk" "$INSTDIR\W4F25.exe" "" "$INSTDIR\W4F25.exe" 0

SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"

  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CopyBuffer"
  DeleteRegKey HKLM SOFTWARE\NSIS_CopyBuffer
  ;DeleteRegKey HKLM “Software\Microsoft\Windows\CurrentVersion\Run” “WatchFolder”
  ;DeleteRegKey HKCU “Software\Microsoft\Windows\CurrentVersion\Run” “WatchFolder”
  Delete “$SMSTARTUP\W4F25.lnk”

  ; Remove files and uninstaller
  Delete $INSTDIR\CopyBuffer.nsi
  Delete $INSTDIR\uninstall.exe
  Delete "$INSTDIR\*.pyd"
  Delete "$INSTDIR\*.zip"
  Delete "$INSTDIR\*.dll"
  Delete "$INSTDIR\*.exe"
  Delete "$INSTDIR\*.txt"
  Delete "$INSTDIR\*.pdf"

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\CopyBuffer\*.*"

  ; Remove directories used
  RMDir "$SMPROGRAMS\CopyBuffer"
  RMDir "$INSTDIR"

SectionEnd
