# Streambox — Claude Code Project Instructions

This repo contains setup instructions and configuration files for a Ugoos AM9 Pro streaming box running Kodi with The Crew (Real Debrid) and Mad Titan Sports addons.

## Project Context

- **Device:** Ugoos AM9 Pro (Amlogic S905X5-J, Android 14 AOSP, 4GB RAM, 64GB storage)
- **Media Player:** Kodi 21.x Omega (ARMV8A 64-bit)
- **Primary Addons:** The Crew (movies/TV via Real Debrid), Mad Titan Sports (live sports)
- **Real Debrid:** Premium link aggregator — authorized via ResolveURL dependency
- **Target Display:** LG C5 OLED (Dolby Vision, HDR10, eARC)
- **Launcher:** FLauncher (replaces stock Ugoos launcher, package: `com.uapplication.launcher`)
- **Audio Receiver:** Onkyo RZ900 (ARC only, no eARC)

## What This Repo Contains

- `README.md` — Full step-by-step setup guide for manual configuration
- `CLAUDE.md` — This file. Project context for Claude Code.
- `.claude/agent.md` — Agent instructions for automated ADB-based setup
- `configs/advancedsettings.xml` — Kodi network timeout and GUI optimization config
- `scripts/setup-adb.sh` — Automated ADB setup script

## ADB Access

The Ugoos AM9 Pro supports ADB over USB and WiFi. When connected via ADB, Claude can:

1. **Detect the device:** `adb devices`
2. **Get root access:** `adb root` (Ugoos AOSP supports this)
3. **Find Kodi userdata path:** `adb shell "find / -name 'guisettings.xml' 2>/dev/null | head -1"`
   - Typical path: `/data/media/0/Android/data/org.xbmc.kodi/files/.kodi/userdata/`
4. **Deploy advancedsettings.xml** to the userdata directory
5. **Deploy autoexec.py** to auto-open The Crew on Kodi startup
6. **Set Real Debrid priority** in ResolveURL settings
7. **Apply system tweaks** (animations, DNS, telemetry, HDR passthrough, network optimization)
8. **Swap launcher:** disable `com.uapplication.launcher`, set FLauncher as default
9. **Check firmware version:** `adb shell "getprop ro.build.display.id"`

### Important ADB Notes

- Android 14 restricts `Android/data/` access — `adb root` is required to write to Kodi's userdata folder
- The `/sdcard/` path often maps to `/data/media/0/` or `/storage/emulated/0/` — they are the same filesystem
- Always verify the Kodi userdata path by searching for `guisettings.xml` rather than hardcoding a path
- Restart Kodi after modifying any config files for changes to take effect
- zsh on macOS interprets `!` in heredocs — use single-quoted heredocs (`'EOF'`) or escape with `\!`

## Key Configuration Files

### advancedsettings.xml

Located at: `<kodi-userdata>/advancedsettings.xml`

Controls network timeouts and GUI rendering. **Cache settings are now in the Kodi GUI** (Settings → Services → Caching) since Kodi 21 Omega — the XML cache tags are ignored.

See `configs/advancedsettings.xml` for the recommended configuration.

### Kodi Cache Settings (GUI only — not in XML)

Configure in Kodi: Settings → Services → Caching (Expert mode):
- **Buffer Mode** → Buffer all filesystems, including local files
- **Memory size** → 350 MB
- **Read factor** → 20

### service.autostart.thecrew

Located at: `<kodi-addons>/service.autostart.thecrew/`

A custom Kodi service addon that auto-opens The Crew 2 seconds after Kodi starts. More reliable than autoexec.py on Android (autoexec.py has permission issues and may not execute).

Files:
- `addon.xml` — declares the service addon
- `service.py` — runs `RunAddon(plugin.video.thecrew)` immediately on startup

After deploying, must be enabled in Kodi → Add-ons → My add-ons → Services → AutoStart The Crew.

### ResolveURL settings.xml

Located at: `<kodi-userdata>/addon_data/script.module.resolveurl/settings.xml`

Contains Real Debrid authorization tokens and resolver priorities. Key settings:
- `RealDebridResolver_priority` — set to `90` (lower = higher priority, default is `100`)
- Torrent Support — enabled
- Cached torrents only — enabled

## Addon Repository Sources

| Addon | Repo URL | Repo Name |
|-------|----------|-----------|
| The Crew | `https://team-crew.github.io` | `crew` |
| Mad Titan Sports | `https://magnetic.website/repo` | `magnetic` |

## The Crew Optimal Settings

These are configured through the Kodi UI (The Crew → Tools):

- **Default action** → Dialog (shows source list for manual selection)
- **Max Quality** → 4K
- **Debrid Only** → On (hides free links)
- **Sort By Torrent/Premium** → On
- **Enable Torrent Scrapers** → On
- **Verify Torrents Cache** → On
- **Remove Uncached** → On
- **Minimum Seeders** → 3
- **HEVC** → On
- **Pre-emptive Termination** → On

## Kodi Player Settings

- **Adjust display refresh rate** → On start/stop
- **Adjust display HDR mode** → On
- **Sync playback to display** → Off (causes audio drift)
- **MediaCodec (Surface)** → On (critical for 4K HDR/DV)
- **MediaCodec** → On
- **Dolby Vision compatibility mode** → Off
- **Allowed HDR dynamic metadata formats** → Dolby Vision, HDR10+
- **Preferred subtitle language** → None

## Ugoos Recommended Settings

- **Color Mode:** YCbCr 4:2:2 12-bit (best HDR/DV color depth within HDMI bandwidth)
- **Resolution:** 4K 60Hz
- **Automatic Frame Rate:** Enabled
- **Dolby Vision:** Enabled
- **HDR:** Enabled

## ADB System Tweaks

Applied via `scripts/setup-adb.sh`:

- Animations → 0 (instant UI)
- WiFi sleep policy → never
- Cloudflare DNS-over-TLS (`1dot1dot1dot1.cloudflare-dns.com`)
- Telemetry disabled (send_action_app_error, netstats, app_standby)
- Heads-up notifications disabled
- HDR conversion mode → 0 (passthrough to TV)
- TCP slow start after idle disabled
- TCP buffer sizes increased (rmem_max/wmem_max → 2MB)
- Bloatware disabled (printspooler, ugoosfirstrun)
- FLauncher as default launcher (com.uapplication.launcher disabled)
- autoexec.py deployed (auto-opens The Crew)

## TV Picture Settings (LG C5 OLED)

- HDMI Deep Colour → On
- Picture Mode → Filmmaker Mode
- Dynamic Tone Mapping → On
- OLED Pixel Brightness → 100 (for HDR)
- AI Brightness → Off
- Energy Saving → Off
- TruMotion → Off
- Super Resolution / Noise Reduction / Sharpness → Off/0

## Common Issues

- **Kodi crashes:** Update Ugoos firmware to 2.0.6+ via OTA Update
- **Audio drift over time:** Configure Kodi cache (Settings → Services → Caching: 350MB, readfactor 20) and deploy advancedsettings.xml network config
- **No passthrough option in Kodi audio:** Normal with AudioTrack (RAW) on Android — passthrough is handled at system level
- **Can't write to Android/data via file manager:** Use ADB with root access instead
- **ResolveURL not visible in addon list:** Check under My add-ons → All, or Program add-ons, or Dependencies
- **Sync playback to display causes audio drift:** Turn it OFF — use Adjust display refresh rate instead
- **advancedsettings.xml cache settings ignored:** Kodi 21 Omega moved cache to GUI. Use Settings → Services → Caching.
- **FLauncher package name:** Stock Ugoos launcher is `com.uapplication.launcher` (NOT `com.ugoos.launcher`)
