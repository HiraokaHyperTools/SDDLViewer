; example1.nsi
;
; This script is perhaps one of the simplest NSIs you can make. All of the
; optional settings are left to their default settings. The installer simply 
; prompts the user asking them where to install, and drops a copy of example1.nsi
; there. 

;--------------------------------

!define APP "SDDLViewer"

!system 'DefineAsmVer.exe "release\${APP}.exe" "!define VER ""[SVER]"" " > Tmpver.nsh'
!include "Tmpver.nsh"
!searchreplace APV ${VER} "." "_"

; The name of the installer
Name "${APP} ${VER}"

; The file to write
OutFile "${APP}_${APV}.exe"

; The default installation directory
InstallDir "$APPDATA\${APP}"

; Request application privileges for Windows Vista
RequestExecutionLevel admin

!system 'MySign "release\${APP}.exe"'
!finalize 'MySign "%1"'

;--------------------------------

; Pages

Page directory
Page instfiles

;--------------------------------

; The stuff to install
Section "" ;No components page, name is not important

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File "release\SDDLViewer.exe"
  
  Exec '"$INSTDIR\SDDLViewer.exe"'
  
  IfErrors +2
    SetAutoClose true
  
SectionEnd ; end the section
