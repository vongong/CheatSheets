# Retroarch

## Links
- [YT Shader Guide](https://www.youtube.com/watch?v=srlJmZc3Ho4)
- [YT Shader Guide 2]( https://youtu.be/-J0TU42Ixn8?si=9w27ASwq1L0X1aH3)
- [Guide: Shaders & Overlays](https://retrogamecorps.com/2024/09/01/guide-shaders-and-overlays-on-retro-handhelds/)

## games aspect ratio
- 10:9
  - Games: GB GBC GameGear
- 3:2 
  - Games: GBA
- 4:3
  - Games: NDS A7800 N64 Sega32X DC PS1
- 10:7
  - Games: Genesis NeoGeo
- 5:6
  - Games: A2600
- 16:15
  - Games: NES
- 8:7
  - Games: SNES

## Retroarch setting 
- In Game, goto Retroarch quick menu
- Back out to settings | video

## Retro Arch save
- quick menu | overrides
- save content directory overrides

## RGC Overlay Pack
- see `Guide: Shaders & Overlays` for files. Located in my perferred setup
- download & unzip
- copy folders to sd card
  - can copy anywhere; just need to navigate to it.
- muos suggestion
  - `RGC overlays` to sd1\MUOS\retroarch\overlays
  - `RGC shaders` to sd1\MUOS\retroarch\shaders
  - `RGC palettes\palette` to sd1\MUOS\bios

## integer Scaling
- Integer Scale: On
- Aspect Ratio: Custom (stretch screen)
- Custom Aspect Ratio Width: 3x
- Custom Aspect Ratio Hight: 3x

## Scaling x for Position
- Integer Scale: Off
- Aspect Ratio: Custom
- Custom Aspect Ratio x position: <check overlay>
- Custom Aspect Ratio x position: <check overlay>

## jeltron overlay
- set overlay
  - quick menu | on-screen overlay
  - overlay preset: select preset
  - overlay opacity: 1.0
- colorization
  - quick menu | core options
  - gb colorization: Internal
  - internal palette: pixelshift - pack 1
  - pixelshift - pack 1: pixelshift 03
- colorization alt
  - quick menu | core options
  - gb colorization: Internal
  - internal palette: special 1

## non integer Scaling
- scaling
  - Integer Scale: Off
  - Aspect Ratio: Core Provided
- shader (sharp shimmerless)
  - load preset
  - nav to RGC shader folder
  - select gls folder
  - select sharp-shimmerless.glslp
  - save preset
  - save content directory preset
- overlay
  - select perfect_GB-dng.cfg