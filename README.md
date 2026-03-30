# Streambox Setup Guide

Complete setup guide for the **Ugoos AM9 Pro** running Kodi with POV (Real Debrid) and Mad Titan Sports.

---

## What You'll End Up With

- **POV** — fast, clean addon for movies and TV shows with external scrapers (Torrentio, MediaFusion) and Trakt integration
- **Mad Titan Sports** — dedicated live sports addon (NFL, NBA, MLB, NHL, soccer, motorsports)
- **Real Debrid** — premium link service that gives you fast, reliable 4K/1080p streams (~$3/month)
- **Trakt** — free service that tracks your watch history and progress across all addons and devices
- **Optimized buffering** — no audio drift or buffering on long streams

Everything below can be done with just the Ugoos remote. ADB (connecting the box to a computer) is optional and only needed for the advanced optimization section at the end.

---

## Step 1: Install Kodi

Do NOT use the Play Store version — it's the phone/tablet build. Grab the proper APK instead.

1. On the Ugoos, open the built-in browser (or install **Downloader** from the Play Store)
2. Navigate to: `kodi.tv/download/android`
3. Under the **Recommended** tab, download the **ARMV8A (64BIT)** APK
4. If Android blocks the install, allow "Unknown Sources" for your browser when prompted
5. Install and open Kodi

> **Important:** Download ARMV8A (64-bit), NOT ARMV7A (32-bit). The AM9 Pro is a 64-bit device.

---

## Step 2: Sign Up for Real Debrid

Do this on your phone or laptop while Kodi installs.

1. Go to [real-debrid.com](https://real-debrid.com)
2. Click **Sign Up** and create an account with your email
3. Verify your email address
4. Go to **Premium Offers** and purchase a plan:
   - **180 days (~$16)** is the best value
   - 30 days (~$4) if you want to try it first
5. Payment options include credit card, Amazon Pay, and others

> **Why Real Debrid?** Without it, you're relying on free links — typically 720p, slow, and unreliable. Real Debrid caches popular torrents on fast servers and gives you direct links. The result is consistent 4K HDR streams that start instantly. It's the single biggest upgrade you can make.

---

## Step 3: Enable Unknown Sources

This lets Kodi install third-party addons.

1. Open Kodi
2. Click the **gear icon** (Settings) — top left of the home screen
3. Go to **System**
4. On the left sidebar, click **Add-ons**
5. Toggle **Unknown Sources** to ON
6. A warning will pop up — click **Yes**

---

## Step 4: Add Repository Sources

1. Go to **Settings** (gear icon) → **File Manager**
2. Double-click **Add source**
3. Click `<None>`
4. Type the URL, click **OK**
5. Name the source, click **OK**
6. Repeat for the second source

| URL | Name |
|-----|------|
| `https://kodifitzwell.github.io/repo/` | `kodifitzwell` |
| `https://magnetic.website/repo` | `magnetic` |

Add both sources while you're here to save time.

---

## Step 5: Install Repositories from Zip Files

1. Go back to the Kodi home screen
2. Click **Add-ons** (left sidebar)
3. Click the **open box icon** (top left — package installer)
4. Click **Install from zip file**
5. Click **kodifitzwell** → select the `repository.kodifitzwell-0.0.1.zip` file → wait for "installed" notification
6. Click **Install from zip file** again
7. Click **magnetic** → select the repository zip file → wait for "installed" notification

---

## Step 6: Install Addons

Still in the addon package manager:

1. Click **Install from repository**
2. **kodifitzwell repository** → Video add-ons → **POV** → Install (accept all dependencies)
3. Wait for "installed" notification
4. Go back to **Install from repository**
5. **Magnetic Repo** → Video add-ons → **Mad Titan Sports** → Install
6. Wait for "installed" notification

Your addons are now at: Kodi home → Add-ons → Video add-ons

---

## Step 7: Authorize Real Debrid and Set Up POV

### Authorize Real Debrid in POV

1. Open POV → go to **Settings** (from the POV home screen)
2. Select **SETTINGS: My Services**
3. Tap **Real-Debrid** → **Authorize**
4. A code will appear on screen
5. On your phone, go to [real-debrid.com/device](https://real-debrid.com/device)
6. Enter the code and click **Allow**
7. Wait for the "authorized" confirmation

### Enable External Scrapers

This is what makes POV powerful — it pulls sources from Torrentio, MediaFusion, and other external scrapers in addition to its own built-in scrapers.

1. Go to **Settings** → **SETTINGS: POV** → **Sources** tab (left sidebar)
2. Under **External Scrapers**: toggle **Enable** → **On**
3. Toggle **Remove Undesirables** → **On**
4. Scroll down to the **Sources** list and enable:
   - **piratebay** → On
   - **torrentio** → On
   - **aiostreams (comet/mediafusion)** → On
   - **torrentsdb** → On
   - **zilean** → On
5. Leave bitmagnet, dmm, nyaa, torrentdownload, meteor, stremthru torz **Off**

### Configure Real Debrid Settings in POV

1. **SETTINGS: POV** → **My Services** tab (left sidebar)
2. Scroll to **Real Debrid** section:
   - **Enable** → On
   - **Use Torrent Services** → On
   - **Search RD Cloud** → On (surfaces previously cached content as instant sources)
   - **Priority** → **0** (lowest number = highest priority, RD resolves first)
   - **Premium Expires Notification** → **7** days

### Set Up Trakt (Recommended)

Trakt is a free service that tracks everything you watch. It syncs your watchlist, progress, and history across all devices.

1. Sign up at [trakt.tv](https://trakt.tv) (free)
2. In POV → **Settings** → **SETTINGS: My Services** → tap **Trakt** → **Authorize**
3. Enter the code at `trakt.tv/activate` on your phone

### POV General Settings

1. **SETTINGS: POV** → **General** tab:
   - **Auto Start POV when Kodi Starts** → **On** (opens POV automatically when Kodi launches)
   - **Enable Kodi Menu Caching** → On
   - **Maximum threads** → **60** (balances scrape speed with device performance)

2. **SETTINGS: POV** → **Features** tab:
   - **Preferred Audio Language** → **English**
   - **Show Release Year in Listings** → **On**
   - **Include Unaired Episodes** → **Off**
   - **Include Unaired Items in Watchlists** → **Off**

---

## Step 8: Kodi Player Settings

1. Kodi → **Settings** (gear icon) → **Player**
2. Change the settings level to **Expert** (click the gear icon in the bottom left until it says Expert)

**Videos section:**

3. **Adjust display refresh rate** → **On start / stop** — matches TV refresh rate to content (24fps movies, 60fps sports)
4. **Adjust display HDR mode** → **On** — switches display in/out of HDR based on content
5. **Sync playback to display** → **Off** — this causes audio drift over time. Refresh rate matching above handles sync correctly.
6. **Minimise black bars** → **Off** — cropping cuts off content

**Processing section (scroll down in Videos):**

7. **Allow hardware acceleration - MediaCodec (Surface)** → **On** — critical for 4K HDR/DV passthrough
8. **Allow hardware acceleration - MediaCodec** → **On** — fallback decoder
9. **Dolby Vision compatibility mode** → **Off** — your TV supports native DV, don't need compatibility mode
10. **Allowed HDR dynamic metadata formats** → **Dolby Vision, HDR10+**

**Subtitles section (left sidebar):**

11. **Preferred subtitle language** → **None** — disables subtitles by default. Turn them on per-video during playback if needed.

**Language section (left sidebar):**

12. **Preferred audio language** → **English** (or your preference)

---

## Step 9: Ugoos Display Settings

Go to **Ugoos Settings** → **Display**:

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

## Step 10: Firmware Update

Check for Ugoos firmware updates: **Ugoos Settings → OTA Update**. Version **2.0.6+** includes critical fixes for system crashes and Dolby Vision/HDR color issues. Do this if you're experiencing crashes.

---

## Kodi Playback Settings

These are covered in Step 8 above. The key settings for reference:

- **Adjust display refresh rate** → On start / stop
- **Adjust display HDR mode** → On
- **Sync playback to display** → **Off** (causes audio drift — refresh rate matching handles sync)
- **MediaCodec (Surface)** → On (critical for 4K HDR/DV)
- **MediaCodec** → On (fallback)
- **Dolby Vision compatibility mode** → Off (TV supports native DV)
- **Allowed HDR dynamic metadata formats** → Dolby Vision, HDR10+
- **Preferred subtitle language** → None

MediaCodec (Surface) is the critical one — it enables 4K output, HDR passthrough, and Dolby Vision. Without it, Kodi falls back to software decoding and you lose HDR entirely. The S905X5 hardware decodes HEVC, AV1, H.266, VP9, and H.264 at zero CPU cost through this setting.

---

## TV Picture Settings (for Best HDR/Dolby Vision)

These settings apply to the HDMI input your Ugoos is plugged into. Adjust them on your TV.

**Critical settings:**

- **HDMI Deep Colour** (or HDMI Ultra HD Deep Color) → **On** — without this, the TV caps the signal at 8-bit and blocks all HDR/DV
- **Picture Mode** → **Filmmaker Mode** (most accurate) or **Cinema**
- **Dynamic Tone Mapping** → **On** — maps HDR metadata to your panel's actual peak brightness

**For OLED TVs — maximize HDR brightness:**

- **OLED Pixel Brightness** → **100** for HDR content
- **AI Brightness** → **Off** (prevents the panel from dimming based on room lighting)
- **Energy Saving** → **Off** (same issue — limits peak brightness)

**Disable all processing:**

- **TruMotion / Motion Smoothing** → **Off** (eliminates soap opera effect on movies)
- **Super Resolution** → **Off**
- **Noise Reduction** → **Off**
- **MPEG Noise Reduction** → **Off**
- **Sharpness** → **0**

These processing features add latency and artifacts. Your content quality comes from the source file (Remux > WEB-DL > BRRip), not TV upscaling.

---

## Audio Sync Troubleshooting

### Delay is constant from the start

This is a processing delay in the TV or receiver.

- **In Kodi:** Settings → Player → Videos (Expert mode) → **Audio offset** — adjust in milliseconds
- **On the TV:** Look for an AV Sync Adjustment setting
- **Disable audio processing:** Turn off AI Sound, Virtual Surround, or any audio effects on the TV — these add latency

### Delay gets worse over time

This is a buffering issue. Apply the buffer optimization in the Advanced section below. Also: use Real Debrid links instead of free links, and use ethernet instead of WiFi.

### Quick fix during playback

While a video is playing, press the **menu/settings button** on the remote → **Audio settings** → adjust **Audio offset** until it syncs. This only applies to the current video.

---

## Advanced: ADB Optimization (Optional)

Everything above this point can be done with just the Ugoos remote. The steps below require connecting the Ugoos to a Mac or PC via ADB. **This is not required** but improves the experience.

### Setting Up ADB

1. On the Ugoos: Settings → About → tap **Build Number** 7 times to enable Developer Options
2. Settings → Developer Options → enable **USB Debugging**
3. On your Mac: `brew install scrcpy` (includes adb)
4. Connect via USB and run: `adb devices`
5. Or connect via WiFi: `adb connect <ugoos-ip>:5555`

### Configure Kodi Cache (In the Kodi GUI)

Kodi 21 Omega moved cache settings from advancedsettings.xml to the GUI. **The XML cache tags are ignored in Kodi 21+.** You must set these through the Kodi interface.

1. Go to **Settings** (gear icon) → **Services** → **Caching**
2. Set the settings level to **Expert** (click the gear in the bottom left)
3. Set these values:
   - **Buffer Mode** → **Buffer all filesystems, including local files** (the last option in the list)
   - **Memory size** → **350 MB** (Kodi uses 3x this in RAM, so ~1GB actual usage on a 4GB device)
   - **Read factor** → **20** (aggressive pre-buffering — fills the cache fast)

This is the single biggest fix for buffering and audio drift on long streams.

### Deploy Network and GUI Config

The network timeout and GUI rendering settings still work in advancedsettings.xml. Deploy them via ADB.

First, find where Kodi stores its data:

```bash
adb root
adb shell "find / -name 'guisettings.xml' 2>/dev/null | head -1"
```

Use the path it returns (typically `/data/media/0/Android/data/org.xbmc.kodi/files/.kodi/userdata/`). Then create the config file:

```bash
adb shell 'cat > /data/media/0/Android/data/org.xbmc.kodi/files/.kodi/userdata/advancedsettings.xml << EOF
<advancedsettings>
  <network>
    <curlclienttimeout>30</curlclienttimeout>
    <curllowspeedtime>30</curllowspeedtime>
    <curlretries>3</curlretries>
    <disableipv6>true</disableipv6>
  </network>
  <gui>
    <algorithmdirtyregions>3</algorithmdirtyregions>
  </gui>
</advancedsettings>
EOF'
```

This sets longer timeouts for slow sources, auto-retry on failed connections, disables IPv6 (avoids dual-stack delays), and optimizes GUI dirty region rendering.

A pre-built copy of this file is in `configs/advancedsettings.xml`.

### Prioritize Real Debrid Links

Sets Real Debrid to resolve before free sources:

```bash
adb shell "sed -i 's/RealDebridResolver_priority\">100/RealDebridResolver_priority\">90/' /data/media/0/Android/data/org.xbmc.kodi/files/.kodi/userdata/addon_data/script.module.resolveurl/settings.xml"
```

### Disable UI Animations

Makes every menu and app switch instant — zero delay:

```bash
adb shell settings put global window_animation_scale 0
adb shell settings put global transition_animation_scale 0
adb shell settings put global animator_duration_scale 0
```

### Keep WiFi Alive During Sleep

Prevents streams from dropping:

```bash
adb shell settings put global wifi_sleep_policy 2
```

### Set Cloudflare DNS (Faster + Private)

Uses DNS-over-TLS with Cloudflare instead of your ISP's DNS. Faster lookups and no DNS logging:

```bash
adb shell settings put global private_dns_mode hostname
adb shell settings put global private_dns_specifier "1dot1dot1dot1.cloudflare-dns.com"
```

### Disable Telemetry and Notifications

Stops diagnostic data collection and prevents popup notifications from interrupting video playback:

```bash
adb shell settings put global send_action_app_error 0
adb shell settings put global netstats_enabled 0
adb shell settings put global heads_up_notifications_enabled 0
adb shell settings put global app_standby_enabled 0
```

### Prevent Android HDR Tone Mapping

Forces HDR content to pass through to your TV without Android processing it. Let your TV handle tone mapping — it does it better:

```bash
adb shell settings put global hdr_conversion_mode 0
```

### Network Streaming Optimization

Disables TCP slow start after idle connections and increases buffer sizes for smoother 4K streaming:

```bash
adb root
adb shell sysctl -w net.ipv4.tcp_slow_start_after_idle=0
adb shell sysctl -w net.core.rmem_max=2097152
adb shell sysctl -w net.core.wmem_max=2097152
```

> **Note:** These sysctl tweaks don't persist across reboots. Re-run them after a restart, or create a boot script at `/data/local/tmp/network_tweaks.sh` and run it manually.

### Auto-Open POV on Kodi Startup

POV has a built-in autostart feature — no custom service addon needed. Enable it in POV → Settings → SETTINGS: POV → General → **Auto Start POV when Kodi Starts** → On.

This is configured in Step 7 above. When Kodi launches, POV opens automatically to its home screen with your Trakt progress, watchlist, and trending content.

### Or Run It All at Once

A script that does everything above is included in this repo:

```bash
./scripts/setup-adb.sh
```

Restart Kodi after running any of the above.

---

## Automated Setup with Claude Code

If you have [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed, you can have it walk you through the setup or run the ADB commands for you:

```bash
cd streambox
claude
```

Claude will detect your Ugoos via ADB, deploy configs, set Real Debrid priority, and apply system tweaks. See `CLAUDE.md` for details.

---

## Network Tips

- **Ethernet is strongly recommended** for 4K streaming. The AM9 Pro has a 1 Gigabit ethernet port.
- If you're on WiFi, use the **5GHz band** (not 2.4GHz).
- 4K Real Debrid streams need consistent 25-50 Mbps.

---

## Choosing a Player on the Ugoos

The AM9 Pro runs Android 14 AOSP, so you can install any Android media player. Here's what works and what to use when.

### Kodi (recommended — what this guide uses)

Best for: streaming via addons (POV, Mad Titan Sports), Real Debrid integration, and full customization. Kodi is the hub that ties everything together — addons scrape sources, Real Debrid resolves the links, and Kodi plays them. It handles 4K HDR, Dolby Vision, and surround audio. The downside is it takes some setup (which is what this guide is for).

### Stremio

Best for: people who want something simpler than Kodi for movies and TV. Stremio has a cleaner, Netflix-like UI and supports Real Debrid through community addons (like Torrentio). Setup takes about 5 minutes vs an hour for Kodi. Install it from the Play Store or sideload the APK. The main limitation is live sports — Stremio has almost no sports coverage compared to Kodi's Mad Titan Sports. If you only watch movies and TV, Stremio is the easier path. If you want sports too, you need Kodi. You can run both on the AM9 Pro.

### TiviMate

Best for: IPTV. If you have an IPTV subscription with an M3U playlist, TiviMate is the gold standard for live TV on Android boxes. It has an EPG (electronic program guide), catch-up TV, and recording. Kodi can do IPTV too, but TiviMate's interface is purpose-built for it.

### SmartTube

Best for: YouTube without ads. The stock YouTube app on AOSP Android boxes is the mobile version and runs poorly. SmartTube is a free, ad-free YouTube client built for Android TV. Sideload it from `smarttubeapp.github.io`. Highly recommended.

### VLC

Best for: local file playback. If you have movies on a USB drive or NAS, VLC plays everything. Install from Play Store. For streaming via addons and Real Debrid, Kodi is better.

### MX Player

Best for: local file playback with hardware acceleration. Similar to VLC but some people prefer it for its codec handling on Amlogic chips. Install from Play Store.

### What we recommend

Use **Kodi** as your main streaming hub (POV + Mad Titan Sports + Real Debrid + Trakt). Add **SmartTube** for YouTube. Add **TiviMate** if you have an IPTV subscription. That covers everything.

---

## Bonus: Stream PC Games with Moonlight

If you have a gaming PC, you can stream your games to the Ugoos and play them on your TV. Moonlight is a free, open-source game streaming client that uses NVIDIA's GameStream protocol (or Sunshine, which works with any GPU).

### What you need

- **On your PC:** [Sunshine](https://github.com/LizardByte/Sunshine) installed and running (works with NVIDIA, AMD, and Intel GPUs). If you have an NVIDIA GPU, you can also use NVIDIA GeForce Experience's built-in GameStream, but Sunshine is recommended since NVIDIA deprecated GameStream.
- **On the Ugoos:** Moonlight app
- **Network:** Both devices on the same network. Ethernet on both ends is strongly recommended — WiFi adds latency. The AM9 Pro's gigabit ethernet is plenty for 4K 60fps streaming.
- **Controller:** A Bluetooth gamepad paired to the Ugoos (Xbox, PlayStation, or 8BitDo controllers all work)

### Setting up Sunshine on your PC

1. Download Sunshine from [github.com/LizardByte/Sunshine](https://github.com/LizardByte/Sunshine/releases)
2. Install and run it — it starts a web UI at `https://localhost:47990`
3. Set a username and password on first launch
4. Sunshine will auto-detect your installed games, or you can add them manually

### Installing Moonlight on the Ugoos

1. On the Ugoos, open the Play Store and search for **Moonlight Game Streaming**
2. Install it (or sideload the APK from [moonlight-stream.org](https://moonlight-stream.org))
3. Open Moonlight — it should auto-discover your PC on the local network
4. Click your PC → enter the PIN shown on the Ugoos into the Sunshine web UI on your PC
5. Once paired, you'll see your game library

### Recommended settings

- **Resolution:** 1080p or 4K depending on your GPU (4K needs a strong GPU like RTX 3070+)
- **Frame rate:** 60fps (or 120fps if your TV supports it)
- **Bitrate:** 40-80 Mbps for 4K, 20-40 Mbps for 1080p — higher is better if your network handles it
- **Codec:** H.265 (HEVC) — the AM9 Pro decodes this in hardware with no performance hit
- **HDR:** Enable if your PC and TV both support it — the Ugoos passes HDR through

### Tips

- Pair a Bluetooth controller to the Ugoos before launching Moonlight: Ugoos Settings → Bluetooth → pair your controller
- For the lowest latency, use ethernet on both the PC and the Ugoos — WiFi adds 10-30ms
- If you see stuttering, lower the bitrate or resolution
- Moonlight also supports mouse and keyboard input if you plug USB peripherals into the Ugoos
- The Ugoos remote won't work as a game controller — you need a proper gamepad

---

## Replacing Your Apple TV with the Ugoos

If you're switching from an Apple TV 4K, here's how to make the Ugoos feel like home.

### Replace the Default Launcher

The stock Ugoos home screen is cluttered. **FLauncher** is a free, open-source launcher that gives you a clean grid of apps — similar to Apple TV's layout.

> **Important:** The Play Store shows FLauncher as "incompatible" on AOSP Android 14 devices. You must sideload it via the device browser or ADB.

**Install via the device browser (easiest):**

1. Open **Chrome** on the Ugoos
2. Go to `apkpure.com/flauncher/me.efesser.flauncher`
3. Tap **Download APK** and install it
4. If Android blocks the install, allow "Unknown Sources" for Chrome when prompted

**Or install via ADB:**

```bash
# Download on your Mac
curl -L -o ~/Downloads/flauncher.apk "https://apkpure.com/flauncher/me.efesser.flauncher/download"
# If curl gets an HTML page instead of the APK, download manually from the APKPure site
adb install ~/Downloads/flauncher.apk
```

**Set FLauncher as default:**

1. Go to Ugoos **Settings → Apps → Default apps → Home app** → select **FLauncher**
2. If that menu doesn't exist on your firmware, use ADB instead:
   ```bash
   adb shell pm disable-user --user 0 com.uapplication.launcher
   ```
   Next time you press Home, Android will ask you to pick a launcher — select FLauncher.

To undo later: `adb shell pm enable com.uapplication.launcher`

### Set a Wallpaper

FLauncher's built-in wallpaper picker may not work on AOSP Android 14. The workaround is to download an image through Chrome on the device:

1. Open **Chrome** on the Ugoos and browse to any wallpaper site (e.g., `unsplash.com/s/photos/dark-abstract`)
2. Long press an image → **Download image**
3. Go back to FLauncher home screen → long press the background → **Wallpaper** → **Pick a photo**
4. Select the image from Chrome's Downloads folder

> **Note:** Pushing images via ADB and running media scanner doesn't work reliably on this AOSP build. Always download through Chrome on the device.

### Organize the Home Screen

FLauncher auto-populates apps into two rows: **TV Applications** (apps with Android TV leanback intent) and **Non-TV Applications** (everything else). To manage apps:

1. Tap the **gear icon** (top right) to open FLauncher settings
2. Select a category (TV Applications or Non-TV Applications)
3. Use the three tabs: TV icon (TV apps), Android icon (non-TV apps), eye-slash icon (hidden apps)
4. Tap the **[+]** button next to an app to add it to the home screen row
5. Long press any app tile on the home screen to move or remove it

> **Note:** Only apps with an Android TV "leanback" intent appear in the TV Applications row. Phone/tablet versions of apps (like regular YouTube) only appear in Non-TV Applications. Install the **Android TV version** of apps (e.g., YouTube for Android TV) for them to show in the TV row.

Suggested layout:

- **Row 1 (TV Apps):** Kodi, Netflix, YouTube (Android TV version), Disney+, HBO Max
- **Row 2 (Non-TV Apps):** Chrome, Settings
- **Hide everything else:** Clock, Files, Gallery, File Browser, Total Commander, etc.

The fewer apps visible, the easier it is for everyone.

### Remote Control

Good news: HDMI-CEC works out of the box on the Ugoos. Your TV remote (LG Magic Remote, Samsung OneRemote, Sony, etc.) controls the Ugoos — d-pad navigation, select, back, volume, power. No extra setup needed.

### What You Keep

- All major streaming apps (Netflix, Disney+, Hulu, HBO Max, YouTube, Spotify) — install from Play Store
- TV remote controls everything via CEC
- 4K HDR and Dolby Vision support
- Voice control via Google Assistant (if you set it up in Ugoos Settings)

### What You Lose

- **AirPlay** — no native AirPlay on Android. Install **AirScreen** from the Play Store as a workaround, but it's not as seamless as Apple TV
- **Apple TV+ app** — not available on Android. Cast from your phone or watch in a browser
- **Siri** — your TV remote's mic button won't do universal search the way Siri does on Apple TV
- **iCloud Photos / Apple ecosystem** — no integration with Apple services

### What You Gain

- POV with Real Debrid — free 4K movies and TV with Trakt integration
- Mad Titan Sports — free live sports
- Stremio — simpler Netflix-like interface for movies/TV (install alongside Kodi)
- SmartTube — ad-free YouTube
- Sideloading any Android app
- Full customization (launchers, skins, settings)

---

## Understanding Stream Quality

When browsing sources in POV, you'll see filenames with quality tags. Here's what they mean, from best to worst:

**REMUX** — full Blu-ray rip with no re-encoding. Lossless video and audio. 40-80GB for 4K, 20-40GB for 1080p. The best quality possible.

**WEB-DL** — pulled directly from a streaming service (Netflix, Amazon) without re-encoding. Slightly compressed vs Remux but visually near-identical. 10-20GB for 4K.

**BDRip / BRRip** — re-encoded from a Blu-ray. Smaller file size, slight quality loss. 2-8GB. Fine for casual watching.

**WEBRip** — screen-captured from a streaming service. Slightly worse than WEB-DL.

**HDRip / HDTV** — lower quality. Avoid if Real Debrid links are available.

**CAM / TS / TC** — filmed in a theater. Never watch these.

**Tags to look for:**

- **2160p** = 4K, **1080p** = Full HD
- **HDR10** or **DV** (Dolby Vision) = HDR content, looks great on OLED
- **Atmos** or **DTS-HD MA** or **TrueHD** = lossless surround audio
- **x265/HEVC** = efficient codec, smaller files at same quality vs x264
- **[RD]** = Real Debrid cached link, fast and reliable

When browsing results, bigger file size generally means better quality. A 60GB 4K Remux with Atmos will look and sound noticeably better than a 4GB 1080p BRRip.

---

## Quick Reference

| What | Where |
|------|-------|
| POV | Add-ons → Video add-ons → POV |
| Mad Titan Sports | Add-ons → Video add-ons → Mad Titan Sports |
| Real Debrid auth | POV → Settings → SETTINGS: My Services → Real-Debrid → Authorize |
| Display refresh rate | Settings → Player → Videos → On start/stop |
| Hardware acceleration | Settings → Player → Videos → MediaCodec (Surface) → On |
| Ugoos display | Ugoos Settings → Display → YCbCr 4:2:2 12-bit |
| Ugoos HDR / DV | Ugoos Settings → Display → HDR On, Dolby Vision On |
| TV HDMI Deep Colour | TV Settings → HDMI → Deep Colour → On |
| FLauncher | Sideload APK from APKPure (Play Store incompatible on AOSP) |
| Firmware update | Ugoos Settings → OTA Update |
