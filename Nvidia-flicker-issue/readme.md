# Chrome Flicker Issue
With the installation of evga rtx 3060, chrome would flicker when netflix/hulu/prime/crunchRoll starts. Some sites would flicker when the site is loaded. Other sites would flicker when video is started. Just once or twice at the begining. Never in the middle of a video.

## Mpo
**Reddit Post:**
After updating to NVIDIA Game Ready Driver 461.09 or newer, some desktop apps may flicker or stutter when resizing the window on some PC configurations
NVIDIA is currently investigating end user reports that after updating to NVIDIA Game Ready Driver 461.09 or newer, Google Chrome may display flicker on some PC configurations.

**Workaround:**
Users who are experiencing this issue may download the registry file "mpo_disable.reg" from the Attachments section below and proceed to double-click on the file to add it to your system registry. This registry file will disable multiplane overlay. After adding the registry file, reboot your PC to complete the changes. If the flicker persists, you may restore multiplane overlay by downloading the file "mpo_restore.reg" and then proceed to double-click on the file to add it to your registry.

```reg
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm]
"OverlayTestMode"=dword:00000005

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm]
"OverlayTestMode"=-
```
- 12/27 - Not working. Removed Reg Key


## Web Browser Angles
Go to chrome flags. Search "angle". Try different options
- default: flicker
- OpenGL: flicker
- D3D9: flicker
- D3D11: flicker
- D3D11on12: flicker

## Disable Hardware Accellerated gpu
https://www.makeuseof.com/hardware-accelerated-gpu-scheduling-disable-windows/

default: 
  Hardware-accelerated GPU scheduling: ON

Hardware-accelerated GPU scheduling: Off

## Disable HDCP - Solution!!!
HDCP, which stands for High-bandwidth Digital Content Protection, is a security protocol designed to prevent the unauthorized copying of digital audio and video content. Netflix has HDCP enabled streaming. 

**Result:**
I switch to 9070xt. Still have the same issues. AMD has setting in driver. In Override | HDCP Support, Disabled setting and rebooted. **No flickering**

**Nvidia Disabling HDCP via Registry Modification:** 
- [YT-vid](https://www.youtube.com/watch?v=ocgGKR10zQo)
- Locate the Class GUID: Open Device Manager, find your NVIDIA graphics card, go to Properties, then Details, and find the "Class GUID" (it will be a long string of numbers and letters). 
- Open Registry Editor: Press the Windows key, type "regedit", and press Enter. 
- Navigate to the correct registry key: Go to HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{YOUR_CLASS_GUID}\0000, replacing {YOUR_CLASS_GUID} with the actual GUID you found earlier. 
- Create a new DWORD value: Right-click in the right pane, select New > DWORD (32-bit) Value, and name it "RMHdcpKeyglobZero".
- Set the value: Double-click the new value and set it to 0 (hexadecimal). 
- Restart your computer: Reboot your system for the changes to take effect. 
- Verify: You can verify that HDCP is disabled in the NVIDIA Control Panel under "View HDCP Status" or by checking if content requiring HDCP still works.

