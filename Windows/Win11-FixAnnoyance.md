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

