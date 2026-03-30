# Streambox Setup Guide

Complete setup guide for the **Ugoos AM9 Pro** running Kodi with The Crew (Real Debrid) and Mad Titan Sports.

---

## What You'll End Up With

- **The Crew** — all-in-one addon for movies, TV shows, sports, and IPTV
- **Mad Titan Sports** — dedicated live sports addon (NFL, NBA, MLB, NHL, soccer, motorsports)
- **Real Debrid** — premium link service that gives you fast, reliable 4K/1080p streams (~$3/month)
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
| `https://team-crew.github.io` | `crew` |
| `https://magnetic.website/repo` | `magnetic` |

Add both sources while you're here to save time.

---

## Step 5: Install Repositories from Zip Files

1. Go back to the Kodi home screen
2. Click **Add-ons** (left sidebar)
3. Click the **open box icon** (top left — package installer)
4. Click **Install from zip file**
5. Click **crew** → select the `repository.thecrew` zip file → wait for "installed" notification
6. Click **Install from zip file** again
7. Click **magnetic** → select the repository zip file → wait for "installed" notification

---

## Step 6: Install Addons

Still in the addon package manager:

1. Click **Install from repository**
2. **The Crew Repo** → Video add-ons → **The Crew** → Install (accept all dependencies)
3. Wait for "installed" notification
4. Go back to **Install from repository**
5. **Magnetic Repo** → Video add-ons → **Mad Titan Sports** → Install
6. Wait for "installed" notification

Your addons are now at: Kodi home → Add-ons → Video add-ons

---

## Step 7: Authorize Real Debrid

The Crew uses a dependency called **ResolveURL** to handle Real Debrid. You authorize through it.

**Through The Crew:**

1. Open The Crew
2. Go to **Tools**
3. Select **RESOLVEURL: Settings**
4. Go to the **Universal Resolvers 2** tab
5. Scroll down to the **Real-Debrid** section
6. Click **(Re)Authorize My Account**
7. A code will appear on screen
8. On your phone, go to [real-debrid.com/device](https://real-debrid.com/device)
9. Enter the code and click **Allow**
10. Wait for the "authorized" confirmation

**If you can't find the Tools menu:**

1. Go to **Add-ons** → click the **open box icon**
2. Click **My add-ons** → **All**
3. Find **ResolveURL** (may be under Program add-ons or Dependencies)
4. Open its **Settings** → **Universal Resolvers 2** tab
5. Scroll to Real-Debrid → **(Re)Authorize My Account**
6. Same authorization flow — enter the code at real-debrid.com/device

Once authorized, The Crew will show Real Debrid links (labeled `[RD]`) alongside free links.

---

## Step 8: Kodi Player Settings

1. Kodi → **Settings** (gear icon) → **Player**
2. Change the settings level to **Expert** (click the gear icon in the bottom left until it says Expert)
3. Go to **Videos** section
4. Set **Adjust display refresh rate** → **On start / stop**

This matches your TV's refresh rate to the content (24fps for movies, 60fps for sports) and eliminates judder.

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

### Deploy Buffer and Network Config

First, find where Kodi stores its data:

```bash
adb root
adb shell "find / -name 'guisettings.xml' 2>/dev/null | head -1"
```

Use the path it returns (typically `/data/media/0/Android/data/org.xbmc.kodi/files/.kodi/userdata/`). Then create the config file:

```bash
adb shell "cat > /data/media/0/Android/data/org.xbmc.kodi/files/.kodi/userdata/advancedsettings.xml << 'EOF'
<advancedsettings>
  <cache>
    <buffermode>1</buffermode>
    <memorysize>157286400</memorysize>
    <readfactor>20</readfactor>
  </cache>
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
EOF"
```

This gives Kodi a 150MB buffer (default is ~20MB), aggressive read-ahead to prevent audio drift, longer timeouts for slow sources, and auto-retry on failed connections.

A pre-built copy of this file is in `configs/advancedsettings.xml`.

### Prioritize Real Debrid Links

Sets Real Debrid to resolve before free sources:

```bash
adb shell "sed -i 's/RealDebridResolver_priority\">100/RealDebridResolver_priority\">90/' /data/media/0/Android/data/org.xbmc.kodi/files/.kodi/userdata/addon_data/script.module.resolveurl/settings.xml"
```

### Reduce UI Animations

Makes the interface feel snappier:

```bash
adb shell "settings put global window_animation_scale 0.5"
adb shell "settings put global transition_animation_scale 0.5"
adb shell "settings put global animator_duration_scale 0.5"
```

### Keep WiFi Alive During Sleep

Prevents streams from dropping:

```bash
adb shell "settings put global wifi_sleep_policy 2"
```

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

Best for: streaming via addons (The Crew, Mad Titan Sports), Real Debrid integration, and full customization. Kodi is the hub that ties everything together — addons scrape sources, Real Debrid resolves the links, and Kodi plays them. It handles 4K HDR, Dolby Vision, and surround audio. The downside is it takes some setup (which is what this guide is for).

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

Use **Kodi** as your main streaming hub (The Crew + Mad Titan Sports + Real Debrid). Add **SmartTube** for YouTube. Add **TiviMate** if you have an IPTV subscription. That covers everything.

---

## Quick Reference

| What | Where |
|------|-------|
| The Crew | Add-ons → Video add-ons → The Crew |
| Mad Titan Sports | Add-ons → Video add-ons → Mad Titan Sports |
| Real Debrid auth | The Crew → Tools → RESOLVEURL: Settings → Universal Resolvers 2 → Real-Debrid |
| Display refresh rate | Settings → Player → Videos → On start/stop |
| Ugoos display | Ugoos Settings → Display → YCbCr 4:2:2 12-bit |
| Firmware update | Ugoos Settings → OTA Update |
