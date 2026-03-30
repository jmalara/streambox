# Streambox — Claude Code Project Instructions

This repo contains setup instructions and configuration files for a Ugoos AM9 Pro streaming box running Kodi with The Crew (Real Debrid) and Mad Titan Sports addons.

## Project Context

- **Device:** Ugoos AM9 Pro (Amlogic S905X5-J, Android 14 AOSP, 4GB RAM, 64GB storage)
- **Media Player:** Kodi 21.x Omega (ARMV8A 64-bit)
- **Primary Addons:** The Crew (movies/TV via Real Debrid), Mad Titan Sports (live sports)
- **Real Debrid:** Premium link aggregator — authorized via ResolveURL dependency
- **Target Display:** LG C5 OLED (Dolby Vision, HDR10, eARC)

## What This Repo Contains

- `README.md` — Full step-by-step setup guide for manual configuration
- `CLAUDE.md` — This file. Project context for Claude Code.
- `.claude/agent.md` — Agent instructions for automated ADB-based setup
- `configs/advancedsettings.xml` — Kodi buffer and network optimization config
- `scripts/setup-adb.sh` — Automated ADB setup script

## ADB Access

The Ugoos AM9 Pro supports ADB over USB and WiFi. When connected via ADB, Claude can:

1. **Detect the device:** `adb devices`
2. **Get root access:** `adb root` (Ugoos AOSP supports this)
3. **Find Kodi userdata path:** `adb shell "find / -name 'guisettings.xml' 2>/dev/null | head -1"`
   - Typical path: `/data/media/0/Android/data/org.xbmc.kodi/files/.kodi/userdata/`
4. **Deploy advancedsettings.xml** to the userdata directory
5. **Set Real Debrid priority** in ResolveURL settings
6. **Apply system tweaks** (animations, WiFi sleep policy)
7. **Check firmware version:** `adb shell "getprop ro.build.display.id"`

### Important ADB Notes

- Android 14 restricts `Android/data/` access — `adb root` is required to write to Kodi's userdata folder
- The `/sdcard/` path often maps to `/data/media/0/` or `/storage/emulated/0/` — they are the same filesystem
- Always verify the Kodi userdata path by searching for `guisettings.xml` rather than hardcoding a path
- Restart Kodi after modifying any config files for changes to take effect

## Key Configuration Files

### advancedsettings.xml

Located at: `<kodi-userdata>/advancedsettings.xml`

Controls buffering, network timeouts, and UI rendering. See `configs/advancedsettings.xml` for the recommended configuration.

### ResolveURL settings.xml

Located at: `<kodi-userdata>/addon_data/script.module.resolveurl/settings.xml`

Contains Real Debrid authorization tokens and resolver priorities. The key setting to modify:
- `RealDebridResolver_priority` — set to `90` (lower = higher priority, default is `100`)

## Addon Repository Sources

| Addon | Repo URL | Repo Name |
|-------|----------|-----------|
| The Crew | `https://team-crew.github.io` | `crew` |
| Mad Titan Sports | `https://magnetic.website/repo` | `magnetic` |

## Ugoos Recommended Settings

- **Color Mode:** YCbCr 4:2:2 12-bit (best HDR/DV color depth within HDMI bandwidth)
- **Resolution:** 4K 60Hz
- **Automatic Frame Rate:** Enabled
- **Dolby Vision:** Enabled
- **HDR:** Enabled

## Kodi Recommended Settings

- **Adjust display refresh rate:** On start/stop
- **Audio output device:** AudioTrack (RAW), Android IEC packer
- **Unknown Sources:** Enabled (required for third-party addons)
- **Settings level:** Expert (for full access to all options)

## Common Issues

- **Kodi crashes:** Update Ugoos firmware to 2.0.6+ via OTA Update
- **Audio drift over time:** Apply advancedsettings.xml buffer config
- **No passthrough option in Kodi audio:** Normal with AudioTrack (RAW) on Android — passthrough is handled at system level
- **Can't write to Android/data via file manager:** Use ADB with root access instead
- **ResolveURL not visible in addon list:** Check under My add-ons → All, or Program add-ons, or Dependencies
