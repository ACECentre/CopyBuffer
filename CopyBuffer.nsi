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

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\CopyBuffer\*.*"

  ; Remove directories used
  RMDir "$SMPROGRAMS\CopyBuffer"
  RMDir "$INSTDIR"

SectionEnd
