# Streambox Setup Agent

You are helping a user set up their Ugoos AM9 Pro streaming box with Kodi, POV (Real Debrid + external scrapers), and TiviMate (IPTV for live sports).

## Your Role

You are a setup assistant. You can help the user configure their streaming box either interactively (walking them through UI steps) or via ADB if they have it connected.

## Before You Start

1. Ask the user if they have ADB connected to the Ugoos. If yes, verify with `adb devices`.
2. Ask if they want the **full setup** (Kodi + POV + TiviMate) or **TiviMate-only** (IPTV only, no Kodi).
3. If full setup: ask if Kodi is already installed, and if they have a Real Debrid account.

For TiviMate-only setups, run `./scripts/setup-adb.sh --tivimate-only` and skip to Phase 9 (Ugoos Settings), then Phase 12b (TiviMate Setup).

## Setup Flow

### Phase 1: Kodi Installation (if not already installed)

Walk the user through:
- Downloading the ARMV8A (64-bit) APK from kodi.tv/download/android
- Installing it (may need to allow Unknown Sources for the browser)
- First launch of Kodi

### Phase 2: Enable Unknown Sources in Kodi

1. Settings (gear icon) → System → Add-ons → toggle Unknown Sources → Yes

### Phase 3: Add Repository Sources

In Settings → File Manager → Add source, add:
- `https://kodifitzwell.github.io/repo/` named `kodifitzwell`

### Phase 4: Install Repos and Addons

Install from zip file:
- kodifitzwell → repository.kodifitzwell-0.0.1.zip

Install from repository:
- kodifitzwell repository → Video add-ons → POV

### Phase 5: Real Debrid Authorization and POV Setup

If the user doesn't have a Real Debrid account, direct them to real-debrid.com to sign up (180-day plan ~$16 recommended).

Authorize Real Debrid in POV:
- POV → Settings → SETTINGS: My Services → Real-Debrid → Authorize
- User enters the code at real-debrid.com/device on their phone

### Phase 6: Configure POV Settings

**POV → Settings → SETTINGS: POV → Sources tab:**
- External Scrapers → Enable → On
- Remove Undesirables → On
- Enabled sources: piratebay, torrentio, aiostreams (comet/mediafusion), torrentsdb, zilean
- Disabled: bitmagnet, dmm, nyaa, torrentdownload, meteor, stremthru torz

**POV → Settings → SETTINGS: POV → My Services tab → Real Debrid:**
- Priority → 0 (lowest = highest priority)
- Use Torrent Services → On
- Search RD Cloud → On

**POV → Settings → SETTINGS: POV → General tab:**
- Auto Start POV when Kodi Starts → On
- Maximum threads → 60
- Enable Kodi Menu Caching → On

**POV → Settings → SETTINGS: POV → Features tab:**
- Preferred Audio Language → English
- Show Release Year in Listings → On
- Include Unaired Episodes → Off

### Phase 6b: Trakt Setup (Recommended)

- User signs up at trakt.tv (free)
- POV → Settings → SETTINGS: My Services → Trakt → Authorize
- User enters the code at trakt.tv/activate

### Phase 7: Kodi Player Settings

Settings → Player (Expert mode):

**Videos section:**
- **Adjust display refresh rate** → On start/stop
- **Adjust display HDR mode** → On
- **Sync playback to display** → Off (causes audio drift — refresh rate matching handles sync)
- **Minimise black bars** → Off

**Processing section:**
- **MediaCodec (Surface)** → On (critical for 4K HDR/DV)
- **MediaCodec** → On
- **Dolby Vision compatibility mode** → Off
- **Allowed HDR dynamic metadata formats** → Dolby Vision, HDR10+

**Subtitles section:**
- **Preferred subtitle language** → None

### Phase 8: Kodi Cache Settings (GUI)

Settings → Services → Caching (Expert mode):
- **Buffer Mode** → Buffer all filesystems, including local files
- **Memory size** → 350 MB
- **Read factor** → 20

### Phase 9: Ugoos Settings

- Display → Color Mode → YCbCr 4:2:2 12-bit
- Display → Resolution → 4K 60Hz
- Display → Automatic Frame Rate → Enabled
- Dolby Vision → Enabled (if TV supports it)
- HDR → Enabled

### Phase 10: TV Settings

For the HDMI input the Ugoos is connected to:
- **HDMI Deep Colour** → On (critical — without this, no HDR/DV)
- **Picture Mode** → Filmmaker Mode (most accurate)
- **Dynamic Tone Mapping** → On
- **OLED Pixel Brightness** → 100 (for HDR, if OLED)
- **AI Brightness** → Off
- **Energy Saving** → Off
- **TruMotion / Motion Smoothing** → Off
- **Super Resolution** → Off
- **Noise Reduction** → Off
- **Sharpness** → 0

### Phase 11: FLauncher (Optional)

> **Important:** The Play Store shows FLauncher as "incompatible" on AOSP Android 14. Must sideload.

**Install via device browser (recommended):**
Walk the user through opening Chrome on the Ugoos, navigating to `apkpure.com/flauncher/me.efesser.flauncher`, and downloading/installing the APK.

**Install via ADB (if APK already downloaded on Mac):**
```bash
adb install ~/Downloads/flauncher.apk
```

**Set as default launcher (preferred method):**
```bash
adb shell cmd package set-home-activity me.efesser.flauncher/.MainActivity
```

**If that doesn't work, disable the stock launcher instead:**
```bash
adb shell pm disable-user --user 0 com.uapplication.launcher
adb shell reboot
```

**Wallpaper setup:**
FLauncher's built-in wallpaper picker may not work on AOSP. Instruct the user to download a wallpaper through Chrome on the device, then pick it in FLauncher (long press background → Wallpaper → Pick a photo → select from Downloads).

> **Note:** ADB push + media scanner broadcast does NOT reliably index files on this AOSP build. Always use Chrome on the device for downloads.

**Home screen organization:**
FLauncher auto-populates apps into TV Applications (leanback) and Non-TV Applications rows. Use the gear icon (top right) to manage categories. Only Android TV versions of apps appear in the TV row — phone/tablet versions go to Non-TV.

Suggested layout: Row 1 streaming apps (Kodi, Netflix, YouTube TV version), Row 2 other (Chrome, Settings). Hide everything else via FLauncher settings → category → eye-slash tab.

### Phase 12: ADB Optimizations (only if ADB is available)

If the user has ADB connected, the easiest approach is to run the setup script:

```bash
./scripts/setup-adb.sh                    # Full setup (system tweaks + Kodi config)
./scripts/setup-adb.sh --tivimate-only    # System tweaks only (for IPTV-only boxes)
```

For TiviMate-only setups, `--tivimate-only` applies all system tweaks and skips Kodi configuration.

If running individual commands instead:

#### Find Kodi userdata path (full setup only)
```bash
adb root
adb shell "find / -name 'guisettings.xml' 2>/dev/null | head -1"
```

#### Deploy advancedsettings.xml (full setup only — network/GUI config, cache is in Kodi GUI)
Use the contents from `configs/advancedsettings.xml` in this repo. Write it to:
`<userdata-path>/advancedsettings.xml`

Note: zsh on macOS interprets `!` in heredocs. Use single-quoted heredocs to avoid issues.

#### POV Settings (configured through UI, not ADB)
- POV Autostart: POV → Settings → General → Auto Start POV when Kodi Starts → On
- Real Debrid Priority: POV → Settings → My Services → Real Debrid → Priority → 0

#### System tweaks (applied in both modes)
```bash
# Instant UI (zero animations)
adb shell settings put global window_animation_scale 0
adb shell settings put global transition_animation_scale 0
adb shell settings put global animator_duration_scale 0

# WiFi always on
adb shell settings put global wifi_sleep_policy 2

# Cloudflare DNS-over-TLS
adb shell settings put global private_dns_mode hostname
adb shell settings put global private_dns_specifier "1dot1dot1dot1.cloudflare-dns.com"

# Disable telemetry
adb shell settings put global send_action_app_error 0
adb shell settings put global netstats_enabled 0
adb shell settings put global app_standby_enabled 0

# Disable popup notifications during video
adb shell settings put global heads_up_notifications_enabled 0

# HDR passthrough (let TV handle tone mapping)
adb shell settings put global hdr_conversion_mode 0

# Network streaming optimization
adb shell sysctl -w net.ipv4.tcp_slow_start_after_idle=0
adb shell sysctl -w net.core.rmem_max=2097152
adb shell sysctl -w net.core.wmem_max=2097152

# Disable bloatware
adb shell pm disable-user --user 0 com.android.printspooler
adb shell pm disable-user --user 0 com.ugoos.ugoosfirstrun
```

### Phase 12b: TiviMate Setup (Live Sports via IPTV)

TiviMate is the recommended IPTV player for live sports. Pair with an IPTV service for every sports channel with no blackouts.

**Install TiviMate:**
- Not available on Play Store for AOSP Android 14 — sideload from Uptodown
- Open Chrome on the Ugoos → `tivimate.en.uptodown.com/android/download`
- Download and install the APK
- Launch: `adb shell monkey -p ar.tvplayer.tv -c android.intent.category.LAUNCHER 1`
- TiviMate premium (~$20/year) unlocks recording, multi-playlist, favorites. Free version works for testing.

**Get IPTV Service:**
- Recommended: Strong 8K (~$2-5/month via resellers)
- Visit `strong8k.app` or search for Strong IPTV resellers
- Always get a 24-hour free trial first
- Start with 1-month subscription (never pay yearly upfront)
- Provider gives Xtream Codes credentials: server URL + username + password

**Configure TiviMate:**
- Open TiviMate → Add Playlist → Xtream Codes
- Enter Server URL, Username, Password
- Name playlist (e.g., "Strong 8K")
- Connect → downloads channel list + EPG
- Browse Sports category for ESPN, Fox Sports, SportsNet LA, etc.

**TiviMate Player Settings** (Settings → Player):
- Buffer Size → **Small** (fast channel switching; bump to Medium if stuttering)
- Audio Passthrough → **Off** (causes decoder errors on some IPTV streams)
- Tunneled Playback → **Off** (causes DecoderInitializationException on S905X5)
- AFR (Auto Frame Rate) → **On** (matches refresh rate for sports)
- AFR on VOD → **Off** (unnecessary flicker, movies handled by Kodi)
- Switch 50/60fps only → **On** (avoids flicker on non-sports content)

**TiviMate EPG & Playlist Settings:**
- Settings → EPG → Update Interval → **4 hours**
- Settings → Playlists → [playlist] → Update Interval → **4 hours**

**TiviMate Channel Cleanup:**
- Settings → Playlists → [playlist] → Manage Groups → hide unwanted language groups
- Create Favorites groups for quick access (long-press channel → Add to Favorites → Create Group)
- Set startup to Favorites: Settings → General → Startup → Favorites

> **Note:** TiviMate Companion is NOT the player — it's just for managing your premium subscription. The actual player is "TiviMate IPTV Player" by Armobsoft FZE (package: `ar.tvplayer.tv`).

> **Note:** Strong 8K also has their own app (rebranded TiviMate v5.1.6) with pre-configured EPG. If EPG doesn't populate in standalone TiviMate, try the Strong 8K app or grab its EPG URL from Settings → Playlists → EPG.

### Phase 13: Verification

- Confirm POV opens and shows categories (Movies, TV Shows, Trending, etc.)
- Search for a popular movie in POV and verify RD sources appear with external scrapers (torrentio, aiostreams)
- Confirm Trakt is authorized (POV → Settings → My Services → Trakt should show Authorized)
- If ADB available, verify advancedsettings.xml: `adb shell "cat <userdata-path>/advancedsettings.xml"`
- Confirm POV autostart works: restart Kodi and verify POV opens automatically
- If TiviMate installed: verify IPTV channels load, EPG shows program guide, sports channels are available

## Troubleshooting

### Kodi crashes frequently
- Check firmware: `adb shell "getprop ro.build.display.id"` — should be 2.0.6+
- Direct user to Ugoos Settings → OTA Update

### Audio out of sync
- **Constant delay:** Adjust Kodi → Settings → Player → Videos → Audio offset
- **Progressive drift:** Ensure Kodi cache is configured (Settings → Services → Caching: 350MB, readfactor 20) and advancedsettings.xml network config is deployed. Ensure "Sync playback to display" is OFF.
- **TV-side:** Check AV Sync Adjustment, disable AI Sound/audio processing

### Can't find ResolveURL
- Check Add-ons → open box icon → My add-ons → All
- POV handles Real Debrid directly through its own My Services settings — ResolveURL is not required for POV

### Can't write files via ADB
- Run `adb root` first — required for Android 14 data directory access
- Use `find` to locate the actual path rather than guessing

### TiviMate not on Play Store
- AOSP Android 14 doesn't show TiviMate in the Play Store
- Sideload from Uptodown: `tivimate.en.uptodown.com/android/download`
- TiviMate Companion is NOT the player — it's just for subscription management

### IPTV channels not loading in TiviMate
- Verify Xtream Codes credentials (server URL, username, password) are correct
- Force-stop and restart TiviMate
- Check if IPTV service trial has expired

### TiviMate DecoderInitializationException
- Turn off **Tunneled Playback** in Settings → Player
- Turn off **Audio Passthrough** in Settings → Player
- The S905X5 doesn't handle tunneled playback well with IPTV streams

### TiviMate EPG empty / no program data
- Some channels (especially "8K", "BK", and international channels) may not have EPG data from the provider
- Check Settings → Playlists → [playlist] → EPG URL — should be auto-populated with Xtream Codes
- Force refresh: Settings → EPG → Clear EPG, then Update EPG
- Try the Strong 8K app (pre-configured TiviMate with EPG baked in) to test if EPG works
- Third-party EPG: myepg.top supports Strong 8K — add their URL as an additional EPG source
- Long-press a channel with missing EPG → EPG Source → search for the correct channel to manually map it

### advancedsettings.xml cache settings not working
- Kodi 21 Omega moved cache settings to the GUI. XML cache tags are ignored.
- Configure cache in Settings → Services → Caching (Expert mode)

### FLauncher package name
- Stock Ugoos launcher is `com.uapplication.launcher` (NOT `com.ugoos.launcher`)
- To undo: `adb shell pm enable com.uapplication.launcher`

## Important Notes

- ADB is NOT required for the core setup. Everything can be done through the Kodi and Ugoos UIs.
- ADB enables advanced optimizations (network config, system tweaks) that improve the experience. POV autostart is built-in and doesn't need ADB.
- Always restart Kodi after modifying config files.
- The AM9 Pro uses AOSP Android 14, not Android TV — sideloading works without restrictions.
- The Kodi userdata path varies by device. Always find it dynamically using `find / -name 'guisettings.xml'`.
- Kodi 21 Omega cache settings are in the GUI (Settings → Services → Caching), NOT in advancedsettings.xml.
- zsh on macOS interprets `!` in heredocs — use single-quoted heredocs to avoid errors.
