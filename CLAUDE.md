# Streambox — Claude Code Project Instructions

This repo contains setup instructions and configuration files for a Ugoos AM9 Pro streaming box running Kodi with POV (Real Debrid) and Mad Titan Sports addons.

## Project Context

- **Device:** Ugoos AM9 Pro (Amlogic S905X5-J, Android 14 AOSP, 4GB RAM, 64GB storage)
- **Media Player:** Kodi 21.x Omega (ARMV8A 64-bit)
- **Primary Addons:** POV (movies/TV via Real Debrid + external scrapers), Mad Titan Sports (live sports)
- **Real Debrid:** Premium link aggregator — authorized directly in POV's My Services settings
- **Trakt:** Watch history and progress tracking — authorized in POV's My Services settings
- **Target Display:** LG C5 OLED (Dolby Vision, HDR10, eARC)
- **Launcher:** FLauncher (package: `me.efesser.flauncher`, replaces stock Ugoos launcher `com.uapplication.launcher`)
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
5. **POV autostart** is built-in (Settings → General → Auto Start POV when Kodi Starts)
6. **Set Real Debrid priority** in POV's My Services settings (priority 0)
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

### POV Autostart

POV has a built-in autostart feature. No custom service addon needed.

Enable in: POV → Settings → SETTINGS: POV → General → **Auto Start POV when Kodi Starts** → On

### POV Real Debrid Settings

Configured directly in POV (not ResolveURL):

POV → Settings → SETTINGS: POV → My Services → Real Debrid:
- **Priority** → 0 (lowest = highest priority)
- **Use Torrent Services** → On
- **Search RD Cloud** → On
- **Enable** → On

### POV External Scrapers

POV → Settings → SETTINGS: POV → Sources:
- **External Scrapers → Enable** → On
- **Remove Undesirables** → On
- Enabled sources: piratebay, torrentio, aiostreams (comet/mediafusion), torrentsdb, zilean
- Disabled: bitmagnet, dmm, nyaa, torrentdownload, meteor, stremthru torz

## Addon Repository Sources

| Addon | Repo URL | Repo Name |
|-------|----------|-----------|
| POV | `https://kodifitzwell.github.io/repo/` | `kodifitzwell` |
| Mad Titan Sports | `https://magnetic.website/repo` | `magnetic` |

## POV Optimal Settings

Configured through POV → Settings → SETTINGS: POV:

**Sources tab:**
- External Scrapers → Enable → On
- Remove Undesirables → On
- Enabled sources: piratebay, torrentio, aiostreams, torrentsdb, zilean

**My Services tab:**
- Real Debrid → Priority 0, Use Torrent Services On, Search RD Cloud On
- Trakt → Authorized

**General tab:**
- Auto Start POV when Kodi Starts → On
- Maximum threads → 60
- Enable Kodi Menu Caching → On

**Features tab:**
- Preferred Audio Language → English
- Show Release Year in Listings → On
- Include Unaired Episodes → Off

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
- FLauncher as default launcher (com.uapplication.launcher disabled, FLauncher sideloaded via APKPure — Play Store shows incompatible on AOSP)
- POV autostart enabled (built-in setting, no custom addon needed)

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
- **FLauncher package name:** Stock Ugoos launcher is `com.uapplication.launcher` (NOT `com.ugoos.launcher`). FLauncher package is `me.efesser.flauncher`.
- **FLauncher Play Store incompatible:** Play Store shows "Your device isn't compatible" on AOSP Android 14. Sideload via device browser from `apkpure.com/flauncher/me.efesser.flauncher` instead.
- **FLauncher wallpapers:** Built-in wallpaper picker may not work on AOSP. Download images through Chrome on the device, then pick from FLauncher's wallpaper settings.
- **FLauncher app visibility:** Only apps with Android TV leanback intent appear in the TV Applications row. Phone/tablet app versions (e.g., `com.google.android.youtube`) only show in Non-TV Applications. Install Android TV versions of apps for them to appear in the TV row.
- **ADB media scanner unreliable on AOSP:** Pushing images via ADB and running `MEDIA_SCANNER_SCAN_FILE` broadcast doesn't reliably index files on this AOSP build. Download files through Chrome on the device instead.
