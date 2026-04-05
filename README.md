# Streambox Setup Guide

Complete setup guide for the **Ugoos AM9 Pro** running TiviMate with Strong 8K IPTV and EPGenius curated playlists for live sports and TV.

---

## What You'll End Up With

- **TiviMate** — gold standard IPTV player with EPG, favorites, catch-up, and recording
- **Strong 8K** — IPTV service with 30K+ channels including every sports network (~$2-5/month via resellers)
- **EPGenius** — community-curated playlists with clean channel names, logos, categories, and EPG mapping
- **No blackouts** — regional sports networks (SportsNet LA, YES Network, etc.) work without MLB/NFL blackout restrictions
- **Optimized system** — instant UI, Cloudflare DNS, HDR passthrough, network tuning via ADB

Everything below can be done with just the Ugoos remote. ADB (connecting the box to a computer) is optional and only needed for the system optimization section.

---

## Step 1: Initial Setup

1. Power on the Ugoos AM9 Pro and connect to WiFi
2. Check for firmware updates: **Settings → About → OTA Update** — get to version **2.0.6+** (fixes crashes and DV/HDR issues)
3. While the box updates, sign up for your IPTV service (Step 2) on your phone or laptop

---

## Step 2: Get an IPTV Service (Strong 8K)

You need an IPTV service that provides Xtream Codes credentials (server URL + username + password).

1. Visit `strong8k.app` or search for Strong IPTV resellers
2. **Always get a 24-hour free trial first** — test during a live game before paying
3. Start with a **1-month subscription** (never pay yearly upfront with IPTV — services can disappear)
4. They'll email you Xtream Codes credentials: server URL, username, and password

Other well-reviewed IPTV services include Falcon TV (~$14/month, known for stable sports) and Xtreme HD IPTV ($12-15/month, 20K+ channels).

> **Pricing:** Strong 8K runs ~$2-5/month through resellers, $10-15/month direct.

> **Quality:** Live sports channels are typically 720p-1080p at the source (ESPN broadcasts at 720p, Fox Sports at 1080p). The "8K/4K" branding applies to some VOD content, not live sports. Still looks great on an OLED.

---

## Step 3: Install TiviMate

TiviMate is not available on the Play Store for AOSP Android 14. Sideload it via Uptodown:

1. Open **Chrome** on the Ugoos
2. Go to `tivimate.en.uptodown.com/android/download`
3. Download the APK and install it
4. If Android blocks the install, allow "Unknown Sources" for Chrome when prompted

> **Package:** `ar.tvplayer.tv` — TiviMate Premium (~$20/year or ~$34 lifetime) unlocks recording, multi-playlist, favorites management, and auto EPG updates. The free version works for testing.

> **Note:** TiviMate Companion is a separate app for managing your premium subscription — it is NOT the player.

### Alternative: Strong 8K App

Strong 8K has their own app (a rebranded TiviMate v5.1.6) with pre-configured EPG. Download from the Strong 8K website. Upside: EPG works out of the box. Downside: pinned to older TiviMate version and only works with Strong 8K.

---

## Step 4: Configure TiviMate with Strong 8K

1. Open TiviMate → it will prompt you to **Add Playlist**
2. Select **Xtream Codes**
3. Enter the **Server URL**, **Username**, and **Password** from Strong 8K
4. Name the playlist (e.g., "Strong 8K")
5. Hit **Connect** — it will download the channel list and EPG
6. Browse channels by category → find **Sports** → look for ESPN, Fox Sports, SportsNet LA, etc.

### Player Settings

In TiviMate → Settings → Player:

- **Buffer Size** → **Small** (fast channel switching with minimal delay. Bump to Medium if you see stuttering)
- **Audio Passthrough** → **On** (sends audio directly to your receiver/TV for best quality. Turn off if you get decoder errors.)
- **Tunneled Playback** → **Off** (causes DecoderInitializationException on the AM9 Pro. Leave this off.)
- **AFR (Auto Frame Rate)** → **On** (matches TV refresh rate to the stream — important for 60fps sports)
- **AFR on VOD** → **Off** (causes unnecessary screen flicker)
- **Switch 50/60fps only** → **On** (only switches refresh rate for sports broadcasts, avoids flicker on everything else)
- **Video Decoder** → **Hardware** (should be default — verify)

### EPG & Playlist Settings

- Settings → EPG → **Update Interval** → **4 hours**
- Settings → Playlists → [Strong 8K] → **Update Interval** → **4 hours**
- Settings → EPG → **Past Days to Keep** → **1** (saves memory)
- Settings → EPG → **Logos** → **Prefer logos from EPG**

### Clean Up Channel Groups

> **Tip:** Don't spend too much time organizing channels and favorites here — EPGenius (Step 5) gives you much better channel organization and EPG out of the box. Set up EPGenius first, then come back and fine-tune from those cleaner channel lists.

Strong 8K has 30K+ channels in 40+ languages. Hide what you don't need:

1. Settings → Playlists → [Strong 8K] → **Manage Groups**
2. **Long-press** on any group you don't want → the toggle turns gray and it disappears
3. Keep only the groups you care about (USA, Sports, PPV, Movies, etc.)

### Set Up Favorites

TiviMate doesn't support favoriting entire channel groups, but you can create custom Favorites groups:

1. On the main EPG/guide screen, **long-press OK** on any channel
2. Select **Add to Favorites** → **Create Group**
3. Name it whatever you want — "Sports", "Movies", "News", etc.
4. Add channels from any provider group into your custom groups
5. Set **Settings → General → Startup → Favorites** so TiviMate opens to your curated list

### Understanding Channel Labels

IPTV providers label channels with quality/priority tiers:

- **VIP** — premium stream, highest priority server resources, most stable during peak hours
- **8K** — higher bitrate/upscaled stream (not actual 8K resolution), better quality than standard
- **BK** — backup stream from a different server. Use as fallback if the primary is down.
- Prefer: **VIP > 8K > standard > BK**

---

## Step 5: EPGenius Curated Playlist (Recommended)

EPGenius provides community-curated playlists with clean channel names, proper logos, organized categories, and better EPG mapping than raw IPTV provider feeds. Your guide/EPG will be significantly better with EPGenius. A major advantage is that you get the same curated channel list across all your devices — add the same EPGenius playlist to TiviMate on your Ugoos, Chillio on your Mac, and MYTVOnline+ on your iPhone and they'll all have identical channel organization.

### Set Up EPGenius

1. Go to `epgenius.org` on your Mac or phone (not the Ugoos)
2. Sort/filter by your IPTV service (e.g., Strong 8K)
3. Click **Preview Playlist** to see what channels/categories each list includes
4. **Recommended: GanjaRelease | Strong 8K** — the #1 playlist on EPGenius with TV Guide coverage for USA, UK, AU, and Canada, and 100% EPG coverage for sports and live TV
5. Click **Google Drive** to set it up — sign into your Google account when prompted
6. When prompted, select **Xtream Codes** and enter your server URL, username, and password (recommended over M3U for better compatibility and fewer credential issues)
7. EPGenius saves a curated playlist to your Google Drive that auto-updates

### Add EPGenius to TiviMate

1. In TiviMate → **Add Playlist** → **M3U Playlist**
2. Paste the Google Drive M3U URL that EPGenius generated
3. Name it (e.g., "EPGenius")
4. Let it download channels

### Register on Discord (Required)

Your EPGenius playlist will stop working if you don't register it:

1. Join the EPGenius Discord (link on their website)
2. Complete verification in the welcome/rules channel
3. Go to the `🤖〢bot-commands` channel
4. Click **Register Playlist** → paste your playlist URL when prompted
5. Use `/dns` to verify your server DNS resolves correctly (avoid Cloudflare resolution)

### EPGenius Credentials Tool

If you need to update your IPTV credentials later (e.g., new server URL, password change):

1. Go to `epgenius.org` → **Edit Credentials**
2. Update your DNS (server URL), username, and/or password
3. Click **Update Credentials**
4. In TiviMate → Settings → Playlists → [EPGenius] → **Update Playlist**

### Troubleshooting EPGenius

- **HttpDataSourceException on playback:** Update credentials via the EPGenius Edit Credentials tool, then refresh the playlist in TiviMate. If still failing, run `/dns` in the EPGenius Discord to check your server URL. Ask in Discord for an alternative DNS if needed.
- **Channels load but won't play:** Check that your Xtream Codes credentials match between your working Strong 8K playlist and the EPGenius playlist. Verify with the Edit Credentials tool.
- **EPG missing on some channels:** Some channels (especially "8K", "BK", and international variants) may not have EPG data mapped. Long-press the channel → EPG Source → search for the correct channel to manually map it.

### Support EPGenius

EPGenius is a community project maintained by volunteers. Consider donating and becoming a supporter via their Discord — supporters get faster playlist updates and priority help in the support channels.

### Using Both Playlists

EPGenius only covers live TV channels — it does not include movies or TV shows (VOD). Keep your original Strong 8K Xtream Codes playlist for movies, TV series, and any live channels not in the EPGenius list. TiviMate Premium supports multiple playlists, so use EPGenius as your daily driver for live TV and the raw Strong 8K playlist for VOD content.

If you get an **HttpDataSourceException** on EPGenius channels, update your credentials via the EPGenius Edit Credentials tool on their website, then refresh the playlist in TiviMate: Settings → Playlists → [EPGenius] → **Update Playlist**.

### What Doesn't Sync Across Devices

EPGenius gives you a consistent channel list everywhere, but any customizations you make inside your IPTV player — favorites, hidden groups, channel sorting, EPG source overrides — are local to that app and device. TiviMate on your Ugoos, Chillio on your Mac, and MYTVOnline+ on your iPhone each maintain their own settings independently. Nothing syncs between them. If you spend time organizing favorites on TiviMate, you'll need to redo that work on Chillio and MYTVOnline+ separately. Back up your TiviMate settings via **Settings → General → Backup & Restore** whenever you make large customizations so you don't lose that work.

---

## Step 6: Ugoos Display Settings

Go to **Ugoos Settings → Display**:

- **Resolution** → 4K 60Hz
- **Color Mode** → **YCbCr 4:2:2 12-bit**
- **HDR** → Enable
- **Dolby Vision** → Enable (if your TV supports it)
- **Automatic Frame Rate** → Enable

### Why YCbCr 4:2:2 12-bit?

The AM9 Pro can only do YCbCr 4:4:4 at 8-bit due to HDMI bandwidth limits on the S905X5. 4:2:2 at 12-bit gives you the full bit depth needed for HDR10 and Dolby Vision. The chroma difference between 4:4:4 and 4:2:2 is invisible on video content.

### On your TV

Make sure **HDMI Deep Colour** (or equivalent) is **ON** for the HDMI port the Ugoos is plugged into. Without this, the TV caps the signal at 8-bit and you lose HDR/DV.

---

## Step 7: TV Picture Settings (for Best HDR/Dolby Vision)

These settings apply to the HDMI input your Ugoos is plugged into.

**Critical settings:**

- **HDMI Deep Colour** (or HDMI Ultra HD Deep Color) → **On** — without this, the TV caps the signal at 8-bit and blocks all HDR/DV
- **Picture Mode** → **Filmmaker Mode** (most accurate) or **Cinema**
- **Dynamic Tone Mapping** → **On** — maps HDR metadata to your panel's actual peak brightness

**For OLED TVs — maximize HDR brightness:**

- **OLED Pixel Brightness** → **100** for HDR content
- **AI Brightness** → **Off** (prevents the panel from dimming based on room lighting)
- **Energy Saving** → **Off** (same issue — limits peak brightness)

**Disable all processing:**

- **TruMotion / Motion Smoothing** → **Off** (eliminates soap opera effect)
- **Super Resolution** → **Off**
- **Noise Reduction** → **Off**
- **MPEG Noise Reduction** → **Off**
- **Sharpness** → **0**

---

## Step 8: Firmware Update

Check for Ugoos firmware updates: **Ugoos Settings → OTA Update**. Version **2.0.6+** includes critical fixes for system crashes and Dolby Vision/HDR color issues.

---

## Advanced: ADB System Optimization (Optional)

Everything above can be done with just the Ugoos remote. The steps below require connecting the Ugoos to a Mac or PC via ADB. **This is not required** but improves the experience.

### Setting Up ADB

1. On the Ugoos: Settings → About → tap **Build Number** 7 times to enable Developer Options
2. Settings → Developer Options → enable **Wireless Debugging** (no USB cable needed)
3. On your Mac: `brew install scrcpy` (includes adb)
4. Connect via WiFi: `adb connect <ugoos-ip>:5555`
5. Or connect via USB and run: `adb devices`

### Run the Setup Script

A script that applies all system optimizations is included in this repo:

```bash
./scripts/setup-adb.sh --tivimate-only    # System tweaks only (recommended)
./scripts/setup-adb.sh                     # Full setup (includes Kodi config if Kodi is installed)
./scripts/setup-adb.sh --dry-run           # Preview commands without executing
```

The script applies:
- Animations → 0 (instant UI)
- WiFi sleep policy → never
- Cloudflare DNS-over-TLS
- Telemetry disabled
- Heads-up notifications disabled
- HDR passthrough (let TV handle tone mapping)
- TCP streaming optimizations
- Bloatware disabled

### Individual ADB Commands

If you prefer to run commands individually:

**Disable UI Animations:**
```bash
adb shell settings put global window_animation_scale 0
adb shell settings put global transition_animation_scale 0
adb shell settings put global animator_duration_scale 0
```

**Keep WiFi Alive During Sleep:**
```bash
adb shell settings put global wifi_sleep_policy 2
```

**Set Cloudflare DNS (Faster + Private):**
```bash
adb shell settings put global private_dns_mode hostname
adb shell settings put global private_dns_specifier "1dot1dot1dot1.cloudflare-dns.com"
```

**Disable Telemetry and Notifications:**
```bash
adb shell settings put global send_action_app_error 0
adb shell settings put global netstats_enabled 0
adb shell settings put global heads_up_notifications_enabled 0
adb shell settings put global app_standby_enabled 0
```

**HDR Passthrough:**
```bash
adb shell settings put global hdr_conversion_mode 0
```

**Network Streaming Optimization:**
```bash
adb root
adb shell sysctl -w net.ipv4.tcp_slow_start_after_idle=0
adb shell sysctl -w net.core.rmem_max=2097152
adb shell sysctl -w net.core.wmem_max=2097152
```

> **Note:** The sysctl tweaks don't persist across reboots. Re-run them after a restart.

---

## Optional: Replace the Default Launcher with FLauncher

The stock Ugoos home screen is cluttered. **FLauncher** is a free, open-source launcher that gives you a clean grid of apps.

> **Important:** The Play Store shows FLauncher as "incompatible" on AOSP Android 14. Must sideload.

### Install FLauncher

Open **Chrome** on the Ugoos → go to `apkpure.com/flauncher/me.efesser.flauncher` → download and install.

Or via ADB:
```bash
adb install ~/Downloads/flauncher.apk
```

### Set FLauncher as Default

Use ADB to set FLauncher as the home activity:
```bash
adb shell cmd package set-home-activity me.efesser.flauncher/.MainActivity
```

To also prevent long-press Home from going to the stock launcher:
```bash
adb shell settings put secure assistant me.efesser.flauncher/.MainActivity
```

If `set-home-activity` doesn't work, disable the stock launcher instead:
```bash
adb shell pm disable-user --user 0 com.uapplication.launcher
adb shell reboot
```

To undo later: `adb shell pm enable com.uapplication.launcher`

### Set a Wallpaper

FLauncher's built-in wallpaper picker may not work on AOSP Android 14. Use Chrome on the device:

1. Open **Chrome** → go to `unsplash.com/s/photos/oled-dark` (true blacks for OLED)
2. Long press an image → **Download image**
3. Go to FLauncher home → **long press the background** → **Wallpaper** → **Pick a photo**
4. Select from Chrome's Downloads folder

> **Note:** Pushing images via ADB and running media scanner doesn't work reliably on this AOSP build. Always download through Chrome on the device.

### FLauncher Settings Workaround

The gear icon in FLauncher may not respond to clicks if the Ugoos remote is in IR mode. Pair the remote via **Bluetooth** (Settings → Remotes & Accessories → Pair new device) and it will work. If Bluetooth pairing isn't an option, use **scrcpy** from your Mac to click it with a mouse cursor:

```bash
scrcpy
```

---

## Mac: Watch IPTV with Chillio

Chillio is the best IPTV player for macOS (also works on Apple TV, iPhone, and iPad). It supports Xtream Codes, M3U playlists, and has a clean native interface.

### Install

1. Download **Chillio** from the Mac App Store — search "Chillio IPTV Smart Player" or go to `chillio.app`
2. Open the app

### Add Your Strong 8K Account

1. Go to **Settings → Accounts → Add Account**
2. Select **Xtream Codes**
3. Enter your **Server URL**, **Username**, and **Password** from Strong 8K
4. Name it (e.g., "Strong 8K")
5. Save — channels, VOD, and EPG will load automatically

You can also add your EPGenius M3U playlist: Add Account → **M3U** → paste your Google Drive URL.

> **Pricing:** Chillio is free with basic features. **Chillio Premium** (~$2.49/month or ~$100 lifetime) unlocks advanced customization, profiles, and premium features. The free version works fine for basic watching.

---

## iPhone / iPad: Watch IPTV with MYTVOnline+

MYTVOnline+ is a solid IPTV player for iOS with Xtream Codes support, EPG, picture-in-picture, favorites, and parental controls.

### Install

1. Download **MYTVOnline+ IPTV Player** from the App Store (by Formuler)
2. Open the app

### Add Your Strong 8K Account

1. Tap **Add Portal** or the **+** button
2. Select **Xtream Codes** as the login type
3. Give it a name (e.g., "Strong 8K")
4. Enter your **Server URL**, **Username**, and **Password**
5. Save — your channels and VOD library will load

> **Pricing:** MYTVOnline+ is free with a limited-time premium trial. Premium unlocks the full feature set (EPG, PiP, catch-up, etc.) via App Store subscription. Check the app for current pricing.

---

## Automated Setup with Claude Code

If you have [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed, you can have it walk you through the setup or run the ADB commands for you:

```bash
cd streambox
claude
```

Claude will detect your Ugoos via ADB and apply system tweaks. See `CLAUDE.md` for details.

---

## Network Tips

- **Ethernet is recommended** for the most stable streams. The AM9 Pro has a 1 Gigabit ethernet port.
- If you're on WiFi, use the **5GHz band** (not 2.4GHz).
- IPTV needs consistent 50+ Mbps for reliable HD sports streams.
- The AM9 Pro's WiFi 6 at 850+ Mbps is more than enough over WiFi.

---

## Common Issues

- **TiviMate not on Play Store:** AOSP Android 14 doesn't have it. Sideload from Uptodown: `tivimate.en.uptodown.com/android/download`
- **TiviMate Companion vs TiviMate:** Companion is only for managing your premium subscription. The actual player is "TiviMate IPTV Player" (`ar.tvplayer.tv`).
- **DecoderInitializationException:** Turn off **Tunneled Playback** in Settings → Player. If still happening, also try turning off **Audio Passthrough**.
- **EPG empty / no program data:** Clear EPG (Settings → EPG → Clear EPG) then Update EPG. Check playlist EPG URL is populated. Try the Strong 8K app for pre-configured EPG. Third-party EPG: `myepg.top` supports Strong 8K.
- **EPGenius HttpDataSourceException:** Update credentials via the EPGenius Edit Credentials tool on their website, then refresh the playlist in TiviMate. Run `/dns` in EPGenius Discord to verify your server URL.
- **IPTV channels not loading:** Verify Xtream Codes credentials are correct. Force-stop and restart TiviMate. Check if your IPTV trial has expired.
- **Live sports quality:** ESPN streams at 720p, Fox Sports at 1080p — this is the source broadcast quality, not an IPTV limitation. "8K/4K" branding refers to VOD content.
- **Channels slow to start:** Normal IPTV behavior. Buffer set to Small gives fastest channel switching.
- **FLauncher package name:** Stock Ugoos launcher is `com.uapplication.launcher` (NOT `com.ugoos.launcher`). FLauncher is `me.efesser.flauncher`.
- **FLauncher gear icon not responding:** The Ugoos remote is likely in IR mode. Pair it via Bluetooth (Settings → Remotes & Accessories → Pair new device) and it will respond to clicks. Alternatively, use scrcpy from your Mac to mouse-click it.
- **FLauncher Play Store incompatible:** Sideload from `apkpure.com/flauncher/me.efesser.flauncher`.
- **Long-press Home goes to stock launcher:** Run `adb shell settings put secure assistant me.efesser.flauncher/.MainActivity`

---

## Subscriptions & Costs

| Service | What It Is | Cost | Renewal |
|---------|-----------|------|---------|
| **TiviMate Premium** | IPTV player for Ugoos/Android — recording, multi-playlist, favorites | ~$20/year or ~$34 lifetime | In-app or via TiviMate Companion app |
| **Strong 8K** | IPTV service — 30K+ channels, sports, VOD | ~$2-5/month (reseller) | Contact your reseller to renew |
| **Chillio** | IPTV player for Mac/Apple TV | Free or ~$2.49/month premium (~$100 lifetime) | App Store subscription |
| **MYTVOnline+** | IPTV player for iPhone/iPad | Free with premium trial, then App Store sub | App Store subscription |
| **EPGenius** | Community-curated playlists with better EPG | $10 donation | Voluntary — donate via their website/Discord |

> **Total monthly cost:** Roughly $5-15/month depending on your Strong 8K reseller pricing, plus the annual TiviMate renewal.

---

## Quick Reference

| What | Where |
|------|-------|
| TiviMate | Sideload from Uptodown (`tivimate.en.uptodown.com/android/download`) |
| Strong 8K | `strong8k.app` — Xtream Codes credentials |
| EPGenius | `epgenius.org` — curated playlists with better EPG |
| IPTV setup | TiviMate → Add Playlist → Xtream Codes → enter credentials |
| EPGenius setup | TiviMate → Add Playlist → M3U Playlist → paste Google Drive URL |
| Player settings | Tunneled Playback OFF, Audio Passthrough ON, Buffer Small, AFR ON |
| EPG refresh | Settings → EPG → Update Interval → 4 hours |
| Channel cleanup | Settings → Playlists → Manage Groups → hide unwanted groups |
| Ugoos display | Settings → Display → YCbCr 4:2:2 12-bit, 4K 60Hz, AFR On |
| Ugoos HDR / DV | Settings → Display → HDR On, Dolby Vision On |
| TV HDMI Deep Colour | TV Settings → HDMI → Deep Colour → On |
| FLauncher | Sideload from APKPure, set default via `adb shell cmd package set-home-activity` |
| System tweaks | `./scripts/setup-adb.sh --tivimate-only` |
| Firmware update | Ugoos Settings → OTA Update (2.0.6+) |
