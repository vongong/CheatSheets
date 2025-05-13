
## Unattended Installer

- [Generate autounattend.xml](https://schneegans.de/windows/unattend-generator/)
  - Bypass windows 11 req
  - Hide any Powershell Window
  - Do not use Compact OS
  - Partition
    - Let Windows Setup Wipe Partition
    - **Note!!!**: This will wipe drive 0, regardless where osDisk is located. Select Interactive if not sure. Best case, disconnect all other drive before running unattended.
    - GPT 300 MB
    - Recovery Partition to 1024 MB
  - Generic Product Key: Pro
  - User Account
    - Remove Admin and User
    - Add <User003> as Admin
    - Logon to first admin account
    - OR: Add a local "offline" account during setup 
  - Password do not expire
  - Default lock out policy
  - File Explorer - Hide Protected OS files
  - Always show file extensions
  - Use Classic Context Menu
  - Open File Explorer to "This PC"
  - Start Menu 
    - Search - Icon
    - Remove all icons
    - Disable Widget
    - Do not show Bing Results when searching
    - Windows 11 - Remove all pins
  - System Tweaks
    - Disable Fast Start up
    - Enable long paths
    - Disable app suggestions / Content Delivery Manager
    - Prevent device encryption
    - Hide Edge First Run experence
    - Disable Edge Startup Boost
  - Visual Effects: Default
  - Desktop Icons: Default
  - Wifi Setup: Skip Wifi Config
  - Express Setting: Disable all
  - Lock Key Setting
    - Caps Lock: off
    - Num Lock: on
    - Scroll Lock: off

## Create USB
- Create a Usb Installer
- Copy autounattend.xml to usb drive
- See sample autounattend.xml