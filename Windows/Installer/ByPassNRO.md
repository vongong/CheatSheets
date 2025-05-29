# By pass create windows account
Shift-F10 to Enter CMD Shell

## Call NRO Script
- Open cmd with `Shift + F10 `
- Type: `OOBE\BYPASSNRO`; your system will reboot
- Unplug network
- Select "I don't have internet"

## Create NRO Script
- Open cmd with Shift + F10
- Type commands (or create script and copy to usb)
```
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE /v BypassNRO /t REG_DWORD /d 1 /f
shutdown /r /t 0
```
- your system will reboot
- Unplug network
- Select "I don't have internet"

## Run Local User Setup
- Open cmd with `Shift + F10`
- Type: `start ms-cxh:localonly`
- After you create local user, should skip process