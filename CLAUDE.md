# Streambox — Claude Code Project Instructions

This repo contains setup instructions and configuration files for a Ugoos AM9 Pro streaming box running TiviMate with Strong 8K IPTV and EPGenius curated playlists.

## Project Context

- **Device:** Ugoos AM9 Pro (Amlogic S905X5-J, Android 14 AOSP, 4GB RAM, 64GB storage)
- **IPTV Player:** TiviMate (ar.tvplayer.tv) — gold standard IPTV player for Android
- **IPTV Service:** Strong 8K (~$2-5/month via resellers, Xtream Codes credentials)
- **Curated Playlists:** EPGenius (epgenius.org) — community-curated channel lists with better EPG mapping
- **Target Display:** LG C5 OLED (Dolby Vision, HDR10, eARC)
- **Launcher:** FLauncher (package: `me.efesser.flauncher`, replaces stock Ugoos launcher `com.uapplication.launcher`)
- **Audio Receiver:** Onkyo RZ900 (ARC only, no eARC)

## What This Repo Contains

- `README.md` — Full step-by-step setup guide for TiviMate + Strong 8K + EPGenius
- `CLAUDE.md` — This file. Project context for Claude Code.
- `.claude/agent.md` — Agent instructions for automated ADB-based setup
- `scripts/setup-adb.sh` — Automated ADB setup script

## ADB Access

The Ugoos AM9 Pro supports ADB over USB and WiFi. When connected via ADB, Claude can:

1. **Detect the device:** `adb devices`
2. **Get root access:** `adb root` (Ugoos AOSP supports this)
3. **Apply system tweaks:** `./scripts/setup-adb.sh --tivimate-only`
4. **Swap launcher:** `adb shell cmd package set-home-activity me.efesser.flauncher/.MainActivity`
5. **Fix long-press Home:** `adb shell settings put secure assistant me.efesser.flauncher/.MainActivity`
6. **Disable stock launcher (fallback):** `adb shell pm disable-user --user 0 com.uapplication.launcher`
7. **Launch TiviMate:** `adb shell monkey -p ar.tvplayer.tv -c android.intent.category.LAUNCHER 1`
8. **Check firmware version:** `adb shell "getprop ro.build.display.id"`

### Important ADB Notes

- zsh on macOS interprets `!` in heredocs — use single-quoted heredocs (`'EOF'`) or escape with `\!`
- The `/sdcard/` path often maps to `/data/media/0/` or `/storage/emulated/0/` — they are the same filesystem

## TiviMate Setup

- **Package:** `ar.tvplayer.tv`
- **APK:** Sideload from Uptodown (`tivimate.en.uptodown.com/android/download`) — not available on Play Store for AOSP
- **Premium:** ~$20/year — unlocks recording, multi-playlist, favorites management
- **IPTV Service:** Strong 8K recommended (~$2-5/month via resellers, trial available)
- **Alternative App:** Strong 8K has their own app (rebranded TiviMate v5.1.6) with pre-configured EPG

### TiviMate Configuration

1. Open TiviMate → Add Playlist → Xtream Codes
2. Enter Server URL, Username, Password from IPTV provider
3. Name the playlist (e.g., "Strong 8K")
4. Connect → downloads channel list + EPG automatically
5. Browse Sports category for ESPN, Fox Sports, SportsNet LA, etc.

### TiviMate Player Settings

- **Buffer Size** → Small (fast channel switching; bump to Medium if stuttering)
- **Audio Passthrough** → On (sends audio directly to receiver/TV for best quality; turn off if decoder errors)
- **Tunneled Playback** → Off (causes DecoderInitializationException on S905X5 with IPTV streams)
- **AFR (Auto Frame Rate)** → On
- **AFR on VOD** → Off (unnecessary flicker)
- **Switch 50/60fps only** → On (only switches for sports broadcasts, avoids flicker on other content)
- **Video Decoder** → Hardware

### TiviMate EPG & Playlist Settings

- EPG Update Interval → 4 hours
- Playlist Update Interval → 4 hours
- Past EPG Days to Keep → 1
- Logos → Prefer logos from EPG

### Channel Labels

- **VIP** — premium/highest priority stream, most stable during peak hours
- **8K** — higher bitrate stream (not actual 8K resolution)
- **BK** — backup stream from different server, use as fallback
- Prefer: VIP > 8K > standard > BK

## EPGenius Curated Playlists

EPGenius provides community-curated M3U playlists with clean channel names, proper logos, organized categories, and better EPG mapping than raw IPTV provider feeds.

### Setup

1. Go to `epgenius.org`, filter by IPTV provider (Strong 8K)
2. Preview playlist → click Google Drive to set up
3. Enter Xtream Codes credentials when prompted
4. EPGenius saves curated M3U to Google Drive (auto-updates)
5. In TiviMate: Add Playlist → M3U Playlist → paste Google Drive URL
6. Register playlist in EPGenius Discord (`🤖〢bot-commands` channel) — required to keep it active

### Credentials Edit Tool

Update credentials at `epgenius.org` → Edit Credentials → Update DNS/username/password → Update Credentials → refresh playlist in TiviMate

### Troubleshooting EPGenius

- **HttpDataSourceException:** Update credentials via EPGenius Edit Credentials tool, refresh playlist. Run `/dns` in Discord to verify server URL.
- **Channels load but won't play:** Credentials mismatch — verify with Edit Credentials tool
- **EPG missing on some channels:** Long-press channel → EPG Source → manually map

### IPTV Quality Notes

- Live sports channels: 720p-1080p at source (ESPN = 720p, Fox Sports = 1080p)
- "8K/4K" branding on IPTV services applies to VOD content, not live sports
- Needs 50+ Mbps bandwidth (AM9 Pro's WiFi 6 at 850+ Mbps is more than enough)

## Ugoos Recommended Settings

- **Color Mode:** YCbCr 4:2:2 12-bit (best HDR/DV color depth within HDMI bandwidth)
- **Resolution:** 4K 60Hz
- **Automatic Frame Rate:** Enabled
- **Dolby Vision:** Enabled
- **HDR:** Enabled

## ADB System Tweaks

Applied via `scripts/setup-adb.sh`:

```bash
./scripts/setup-adb.sh --tivimate-only    # System tweaks only (recommended)
./scripts/setup-adb.sh                     # Full setup (includes Kodi config if Kodi installed)
./scripts/setup-adb.sh --dry-run
```

System tweaks applied:
- Animations → 0 (instant UI)
- WiFi sleep policy → never
- Cloudflare DNS-over-TLS (`1dot1dot1dot1.cloudflare-dns.com`)
- Telemetry disabled (send_action_app_error, netstats, app_standby)
- Heads-up notifications disabled
- HDR conversion mode → 0 (passthrough to TV)
- TCP slow start after idle disabled
- TCP buffer sizes increased (rmem_max/wmem_max → 2MB)
- Bloatware disabled (printspooler, ugoosfirstrun)

Not handled by script (manual UI setup):
- FLauncher sideload + launcher swap (optional — stock launcher works fine)
- TiviMate player settings (tunneled playback off, audio passthrough off, buffer small, AFR on)
- EPGenius playlist setup

## FLauncher

- **Package:** `me.efesser.flauncher`
- **Install:** Sideload from `apkpure.com/flauncher/me.efesser.flauncher` (Play Store incompatible on AOSP)
- **Set default:** `adb shell cmd package set-home-activity me.efesser.flauncher/.MainActivity`
- **Fix long-press Home:** `adb shell settings put secure assistant me.efesser.flauncher/.MainActivity`
- **Disable stock launcher (fallback):** `adb shell pm disable-user --user 0 com.uapplication.launcher`
- **Gear icon workaround:** Pair the Ugoos remote via Bluetooth (IR mode doesn't register clicks). Alternatively, use scrcpy from Mac to mouse-click.
- **Wallpapers:** Download through Chrome on device (ADB media scanner unreliable on AOSP)

## TV Picture Settings (LG C5 OLED)

- HDMI Deep Colour → On
- Picture Mode → Filmmaker Mode
- Dynamic Tone Mapping → On
- OLED Pixel Brightness → 100 (for HDR)
- AI Brightness → Off
- Energy Saving → Off
- TruMotion → Off
- Super Resolution / Noise Reduction / Sharpness → Off/0

## Subscriptions & Costs

| Service | Cost | Notes |
|---------|------|-------|
| TiviMate Premium | ~$20/year or ~$34 lifetime | IPTV player for Ugoos/Android. Renew in-app or via Companion app |
| Strong 8K | ~$2-5/month (reseller) | IPTV service. Renew through reseller |
| Chillio | Free or ~$2.49/month (~$100 lifetime) | IPTV player for Mac/Apple TV. App Store subscription |
| MYTVOnline+ | Free with premium trial, then App Store sub | IPTV player for iPhone/iPad. App Store subscription |
| EPGenius | $10 donation | Community-curated playlists (live TV only). Voluntary donation |

## Common Issues

- **TiviMate not on Play Store:** AOSP Android 14 doesn't have it. Sideload from Uptodown.
- **TiviMate Companion vs TiviMate:** Companion is for subscription management only. Player is `ar.tvplayer.tv`.
- **DecoderInitializationException:** Turn off Tunneled Playback in Settings → Player. If still happening, also try turning off Audio Passthrough.
- **EPG empty/no program data:** Clear EPG then Update EPG. Try Strong 8K app for pre-configured EPG. Third-party: `myepg.top`.
- **EPGenius HttpDataSourceException:** Update credentials via Edit Credentials tool on epgenius.org, refresh playlist. Run `/dns` in Discord.
- **IPTV channels not loading:** Verify Xtream Codes credentials. Force-stop and restart TiviMate.
- **Live sports quality:** ESPN = 720p, Fox Sports = 1080p (source limitation, not IPTV).
- **FLauncher gear icon not responding:** Pair the Ugoos remote via Bluetooth (IR mode doesn't register clicks). Or use scrcpy to mouse-click it.
- **FLauncher long-press Home goes to stock launcher:** `adb shell settings put secure assistant me.efesser.flauncher/.MainActivity`
- **FLauncher wallpapers:** Download through Chrome on device, pick from FLauncher wallpaper settings.
- **ADB media scanner unreliable:** Download files through Chrome on the device instead of ADB push.
