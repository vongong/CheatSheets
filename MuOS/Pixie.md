# Mustard OS
OS designed for retro handhelds. Document based on Pixie.
- [Homepage](https://muos.dev/)
- [Forum](https://community.muos.dev/)
- [Themes](https://github.com/MustardOS/theme)

## Install
Pull Image to muos homepage. Flash to sd card.
Note: Balena Etcher is NOT recommended due to repeated issues with bad flashes.

## 2 sd card setup
Move all roms, bios, etc to SD card2. Leave OS on SD card1.

### Move config to
- Select Configuration
- Select Storage
- Select Migrate to SD2

## Apps
Apps are installed from the Archive Manager. This app will look at the `ARCHIVE` folder on the root of the any sd card. Here you can place specially created archive manager `.mux*` files. If `ARCHIVE` folder doesn't exist on SD2, you can manually create it.

**Useful apps**
- Scrappy
- Bluetooth App
- App Downloader

## Artwork
See [muOS Artwork](https://muos.dev/installation/artwork)

### Folder Structure
SD1
└─ MUOS
    └── info
        └── catalogue
            ├── <System>
            │    ├── box
            │    │   └── romname.png
            │    ├── preview
            │    │   └── romname.png
            │    ├── splash
            │    │   └── romname.png
            │    └── text
            │        └── romname.txt
            ├── Folder

Systems match the catalogue= entry in MUOS/info/assign/<system>.ini

### Other Info
- Image Size Box 324x300
- [Skraper mixes and Artwork for the Tiny Best Set](https://github.com/antiKk/muOS-Artwork)
- [GarlicOS system Icons](https://github.com/Vidnez/retro-systems-icons-for-GarlicOS)

## Scrape
- [Screen Scraper](https://www.screenscraper.fr/)
- [Skraper App](https://www.skraper.net/)
- [tutorial](https://youtu.be/hf9zdMqKndI)
- [xml configs](https://github.com/antiKk/muOS-Artwork)

1. Install Skraper App
2. Validate Screen scraper account
3. Loading Resource can take a while
4. Select Generic Emulation
5. Select Roms Folder
6. For Roms, update correct <system> folder
7. For Media, Media Type User Provided mix
8. Use xml from AntiKk/muOS-Artwork/Skraper Mixes
9. remove manuals
10. For box, save to MUOS\info\catelogue\<system>\box 
11. For preview, save to MUOS\info\catelogue\<system>\preview 
12. Select Play

## Recommend Settings
- Sleep Function: Sleep 1m + shutdown
- Interface Options
  - Network: Visable
- Adv Settings
  - Button Swap?
  - RetroArch Network Wait: Enable for RetroAchievements
- Wifi Network
  - Enable: yes
  - Save Profile
- Web Services
  - Filebrowser: Enable for WebAccess (muos:muos)
  - 