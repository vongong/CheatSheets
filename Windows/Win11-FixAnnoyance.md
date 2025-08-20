# Win 11 Annoyance Fix

## Setting | Personalization | Taskbar
- Disable Widget, Chat
 
## Setting | Personalization | Start
- More Pin
- Disable 'Show Recently Added Apps'
- Disable 'Show most used'
- Disable 'Show recently opened items'
- Disable 'Show recommendations'

## Setting | Personalization | Lock Screen
- Disable fun facts

## Setting | System | Notification | Additional Settings
- Disable Show Windows Welcome Experience
- Disable Get tips and suggestions

## Setting | Apps | Adv Settings
- Share Across device: Off | My device Only

## Setting | Apps | Default Apps
- Set for Chrome

## Setting | Apps | Start Up
- Disable stuff like Cortona, 

## Setting | Apps | Offline Maps
- Disable Maps

## Setting | Time & Lang | Typing
- Disable Show text Suggestions
- Disable Multilingual text suggestions

## Setting | Gaming 
- Disable Gaming Bar and Gaming Mode

## Setting | Privacy & Security | General
- Disable personal ads, improve start and search, suggested content

## Setting | Privacy & Security | Diag & Feedback
- Disable Diag Data. Or all

## Setting | Privacy & Security | Inking & typing
- Disable Custom dictionary

## Setting | Privacy & Security | Activity History
- Disable Activity History

## Setting | Privacy & Security | Search permission
- SafeSearch: Off
- Cloud content search: Off
- History: Off
- Search Highlight: Off

## Regedit - disable cloud search
Path: HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search
DWORD Key: AllowSearchToUseLocation; Value=0
DWORD Key: BingSearchEnabled; Value=0

## Disable Copilot
- For Pro, Group Policy Editor > User Configuration > Windows Components > Windows Copilot. Turn off Windows Copilot
- For Home, Regedit Path: HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows
  - Add WindowsCopilot
  - Add DWORD Key: TurnOffWindowsCopilot; Value: 1

## Get the Windows 10 context menu back
- Regedit Path: Computer\HKEY_CURRENT_USER\SOFTWARE\CLASSES\CLSID
- New Key: {86ca1aa0-34aa-4e8b-a509-50c905bae2a2} 
- In New Subpath add key:InprocServer32
  - By default, key has no value. Update value to {blank}
- Reboot PC

## Return of the Explorer ribbon (Not Working)
- Regedit Path: Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions
- Add Subkey: Blocked
- In Blocked, add String key: {e2bf9676-5f8f-435c-97eb-11607a5bedf7}
- Reboot PC

## Turn Off OneDrive Backup
- Click on Taskbar Icons OneDrive
- Select Gear Icon | Settings and Help
- Select Account 
- Unlink this PC

## Remove "Learn about this picture"
```ini
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}]

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel]
"{2cc5ca98-6485-489a-920e-b3e88a6ccce3}"=dword:00000001
```

## Prevent Windows Update install drivers
Sometime when windows automatically installs driver could cause issues with the system. This can be done via group policy (Pro) or system properties.

### System Properties
- Open System Properties (`sysdm.cpl`)
- Go To Hardware Tab
- Click on Device Installation Settings
- Select "No, let me choose what to do" and "Never Install drivers software from Windows Update"
- Save Changes

### Group Policy
- Open Group Policy (`gpedit.msc`)
- Go to Computer Configuration > Administrative Templates > Windows Components > Windows Update
- Enable "Do not include drivers with Windows Updates
- Restart your computer

## Registery Fixes

### Menu Delay
- Key: HKEY_CURRENT_USER\Control Panel\Desktop
  - Item: MenuShowDelay   
  - Value: 200

### Verbose Status
- Key: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
  - Item: VerboseStatus   
  - Value: 1

### Disable Web Search
- Key: HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer
  - Item: DisableSearchBoxSuggestions   
  - Value: 1

### Show Seconds in System Clock
- Key: HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
  - Item: ShowSecondsInSystemClock
  - Value: 1