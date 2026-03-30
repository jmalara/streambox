# Streambox Setup Guide

Complete setup guide for the **Ugoos AM9 Pro** running Kodi with The Crew (Real Debrid) and Mad Titan Sports.

Tested with: Ugoos AM9 Pro (S905X5-J), Android 14 AOSP, Kodi 21.x Omega, LG C5 OLED.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Install Kodi](#install-kodi)
3. [Sign Up for Real Debrid](#sign-up-for-real-debrid)
4. [Enable Unknown Sources](#enable-unknown-sources)
5. [Add Repository Sources](#add-repository-sources)
6. [Install Repositories from Zip Files](#install-repositories-from-zip-files)
7. [Install Addons](#install-addons)
8. [Authorize Real Debrid in The Crew](#authorize-real-debrid-in-the-crew)
9. [Kodi Player Settings](#kodi-player-settings)
10. [Ugoos Display Settings](#ugoos-display-settings)
11. [Ugoos Audio Settings](#ugoos-audio-settings)
12. [Advanced: Buffer and Network Optimization](#advanced-buffer-and-network-optimization)
13. [Advanced: Prioritize Real Debrid Links](#advanced-prioritize-real-debrid-links)
14. [Advanced: System Tweaks via ADB](#advanced-system-tweaks-via-adb)
15. [Audio Sync Troubleshooting](#audio-sync-troubleshooting)
16. [Automated Setup with Claude](#automated-setup-with-claude)

---

## Prerequisites

- Ugoos AM9 Pro (or compatible Android TV box)
- HDMI cable connected to your TV
- Internet connection (ethernet recommended for 4K streaming)
- A phone or laptop for Real Debrid authorization

---

## Install Kodi

The Play Store version of Kodi is the phone/tablet build. You want the proper ARM64 APK instead.

1. On the Ugoos, open the built-in browser (or install **Downloader** from the Play Store)
2. Navigate to: `kodi.tv/download/android`
3. Under the **Recommended** tab, download the **ARMV8A (64BIT)** APK — this matches the S905X5 chip
4. If Android blocks the install, allow "Unknown Sources" for your browser when prompted
5. Install and open Kodi

> **Note:** Do NOT download the ARMV7A (32-bit) build. The AM9 Pro is a 64-bit device and the 32-bit build will run in compatibility mode with worse performance.

---

## Sign Up for Real Debrid

Real Debrid is a premium link aggregator that transforms the streaming experience. Without it, you're relying on free links that are often low quality, slow, and unreliable. With it, you get fast 4K/1080p streams with minimal buffering.

1. On your phone or laptop, go to [real-debrid.com](https://real-debrid.com)
2. Click **Sign Up** and create an account with your email
3. Verify your email address
4. Go to **Premium Offers** and purchase a plan:
   - **180 days (~$16)** is the best value
   - 30 days (~$4) if you want to try it first
5. Payment options include credit card, Amazon Pay, and various other methods
6. Keep your account credentials handy — you'll need them for authorization later

> **Why Real Debrid?** Free streaming links are scraped from public hosting sites and are typically 720p, buffered, and unreliable. Real Debrid caches popular torrents on fast servers and provides direct download links. The result is consistent 4K HDR streams that start instantly. It's $3/month and the single biggest upgrade you can make.

---

## Enable Unknown Sources

This allows Kodi to install third-party addons.

1. Open Kodi
2. Click the **gear icon** (Settings) — top left of the home screen
3. Go to **System**
4. On the left sidebar, click **Add-ons**
5. Toggle **Unknown Sources** to ON
6. A warning will pop up — click **Yes**

---

## Add Repository Sources

From the Kodi home screen:

1. Go to **Settings** (gear icon) → **File Manager**
2. Double-click **Add source**
3. Click `<None>`
4. Type the URL, click **OK**
5. Name the source, click **OK**
6. Repeat for each source below

| URL | Name |
|-----|------|
| `https://team-crew.github.io` | `crew` |
| `https://magnetic.website/repo` | `magnetic` |

> **Tip:** Add all sources at once while you're in File Manager to save time navigating back and forth.

---

## Install Repositories from Zip Files

1. Go back to the Kodi home screen
2. Click **Add-ons** (left sidebar)
3. Click the **open box icon** (top left — package installer)
4. Click **Install from zip file**
5. For each source, click the name and select the repository zip file:
   - **crew** → `repository.thecrew-x.x.x.zip`
   - **magnetic** → select the repository zip file
6. Wait for the **"Add-on installed"** notification after each one before proceeding to the next

---

## Install Addons

Still in the addon package manager:

1. Click **Install from repository**
2. Install each addon:
   - **The Crew Repo** → Video add-ons → **The Crew** → Install (accept all dependencies)
   - **Magnetic Repo** → Video add-ons → **Mad Titan Sports** → Install
3. Wait for the "installed" notification after each

### Accessing Your Addons

- **The Crew:** Kodi home → Add-ons → Video add-ons → The Crew
- **Mad Titan Sports:** Kodi home → Add-ons → Video add-ons → Mad Titan Sports

---

## Authorize Real Debrid in The Crew

The Crew uses a dependency called **ResolveURL** to handle Real Debrid links. You authorize Real Debrid through ResolveURL.

### Method 1: Through The Crew (easiest)

1. Open The Crew
2. Go to **Tools**
3. Select **RESOLVEURL: Settings**
4. Go to the **Universal Resolvers 2** tab
5. Scroll down to the **Real-Debrid** section
6. Click **(Re)Authorize My Account**
7. A code will appear on screen
8. On your phone, go to [real-debrid.com/device](https://real-debrid.com/device)
9. Enter the code and click **Allow**
10. Wait for the "authorized" confirmation in Kodi

### Method 2: Through Kodi addon settings

If you can't find the Tools menu in The Crew:

1. Go to **Add-ons** → click the **open box icon**
2. Click **My add-ons** → **All**
3. Find **ResolveURL** (may be under Program add-ons or Dependencies)
4. Open its **Settings** → **Universal Resolvers 2** tab
5. Scroll to Real-Debrid → **(Re)Authorize My Account**
6. Follow the same authorization flow above

Once authorized, The Crew will show Real Debrid links (labeled `[RD]`) alongside free links. RD links are significantly better quality and faster.

---

## Kodi Player Settings

These settings optimize playback quality.

1. Kodi → **Settings** (gear icon) → **Player**
2. Change the settings level to **Expert** (click the gear icon in the bottom left until it says Expert)

### Video Settings

3. Go to **Videos** section
4. Set **Adjust display refresh rate** → **On start / stop**
   - This matches your TV's refresh rate to the content (24fps for movies, 60fps for sports) and eliminates judder
5. Set **Default select action** → **Play** (skips the info dialog)

### Whitelist Resolutions

6. Still in Player → Videos, find **Whitelist**
7. Add these resolutions:
   - 3840x2160 @ 23.976Hz, 24Hz, 50Hz, 60Hz
   - 1920x1080 @ 23.976Hz, 24Hz, 60Hz

---

## Ugoos Display Settings

Go to **Ugoos Settings** → **Display**:

- **Resolution** → 4K 60Hz (base resolution; auto-framerate switches per content)
- **Color Mode** → **YCbCr 4:2:2 12-bit** (best balance of color depth and chroma for HDR/Dolby Vision content)
- **HDR** → Enable
- **Dolby Vision** → Enable (if your TV supports it)
- **Automatic Frame Rate** → Enable

### Why YCbCr 4:2:2 12-bit?

The AM9 Pro can only do YCbCr 4:4:4 at 8-bit due to HDMI bandwidth limits on the S905X5. 4:2:2 at 12-bit gives you the full bit depth needed for HDR10 and Dolby Vision. The chroma subsampling difference between 4:4:4 and 4:2:2 is invisible on video content — it only matters for text rendering.

### TV-Side Settings (LG OLED example)

- **HDMI Deep Colour** → ON for the Ugoos HDMI port (required for HDR/DV)
- **Match Content** → Enable (Dynamic Tone Mapping + Frame Rate)

---

## Ugoos Audio Settings

### Direct to TV (no soundbar/AVR)

No changes needed. Kodi defaults to 5.1 AudioTrack (RAW) which the TV downmixes to its speakers automatically.

### Through an AV Receiver via ARC/eARC

If your receiver is connected to the TV's ARC/eARC port:

**On the TV:**
1. Sound → Sound Out → **HDMI (eARC)**
2. Sound → Advanced Settings → eARC Support → **Auto**
3. Sound → Advanced Settings → Digital Sound Output → **Pass Through**

**In Kodi (Expert mode):**
1. Settings → System → Audio
2. Number of channels → **7.1** (or match your receiver)
3. If **Allow passthrough** appears, enable it and turn on all supported codecs

> **Note:** The Ugoos AM9 Pro uses AudioTrack (RAW) as its audio output device. Passthrough is often handled at the Android/Ugoos system level rather than in Kodi's settings. If you don't see passthrough toggles in Kodi, check your TV's audio output settings are set to Pass Through.

> **Note on ARC vs eARC:** Standard ARC only supports lossy Dolby Digital and DTS. For lossless audio (TrueHD, DTS-HD MA, lossless Atmos), you need eARC. If your receiver doesn't support eARC, consider connecting the Ugoos directly to the receiver's HDMI input instead.

---

## Advanced: Buffer and Network Optimization

Kodi's default buffer is small and can cause audio drift and buffering on longer streams. This configuration increases the buffer and improves network handling.

### Option A: Using ADB (recommended if you have scrcpy/adb set up)

Connect to the Ugoos via ADB and find the Kodi userdata path:

```bash
adb root
adb shell "find / -name 'guisettings.xml' 2>/dev/null | head -1"
```

This returns the active userdata path. Use that path to create the advancedsettings.xml. For example:

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

Restart Kodi after creating the file.

> **Note:** The Kodi userdata path varies by device and Android version. Common paths include:
> - `/data/media/0/Android/data/org.xbmc.kodi/files/.kodi/userdata/`
> - `/sdcard/Android/data/org.xbmc.kodi/files/.kodi/userdata/`
>
> Android 14 restricts direct file access to `Android/data/` — you'll likely need `adb root` to write to this location. File managers like Total Commander will be blocked by Android's storage scoping.

### Option B: Using the Easy Advanced Settings addon (no ADB required)

1. In Kodi → Add-ons → open box icon → Install from repository
2. Go to **Kodi Add-on repository** (the official one)
3. **Program add-ons** → **Easy Advanced Settings** → Install
4. Open it → Cache settings:
   - **Buffer mode** → Internet streams
   - **Memory size** → 150 MB
   - **Read factor** → 20
5. Save and restart Kodi

### What these settings do

| Setting | Value | Purpose |
|---------|-------|---------|
| `buffermode=1` | Buffer internet streams | Forces Kodi to buffer all streams into RAM instead of playing real-time |
| `memorysize=157286400` | 150 MB | Large buffer (default is ~20MB). The AM9 Pro has plenty of RAM |
| `readfactor=20` | 20x read-ahead | Aggressively fills the buffer ahead of playback. Prevents audio/video desync caused by connection hiccups |
| `curlclienttimeout=30` | 30 seconds | Longer timeout before giving up on a source (default is 10s) |
| `curlretries=3` | 3 retries | Auto-retry failed connections |
| `disableipv6=true` | Disable IPv6 | Avoids DNS delays on networks without proper IPv6 support |
| `algorithmdirtyregions=3` | Dirty regions | Reduces GPU load on the Kodi UI by only re-rendering changed regions |

A pre-built `advancedsettings.xml` is included in the `configs/` directory of this repo.

---

## Advanced: Prioritize Real Debrid Links

By default, Real Debrid and all other resolvers have the same priority (100) in ResolveURL. Setting RD to a lower number makes its links resolve first.

### Option A: Through ResolveURL settings in Kodi

1. Find ResolveURL in My add-ons → All or Dependencies
2. Open Settings → Universal Resolvers 2
3. Find Real-Debrid → set **Priority** to **90**

### Option B: Via ADB

```bash
adb shell "sed -i 's/RealDebridResolver_priority\">100/RealDebridResolver_priority\">90/' /data/media/0/Android/data/org.xbmc.kodi/files/.kodi/userdata/addon_data/script.module.resolveurl/settings.xml"
```

> **Note:** Adjust the path if your Kodi userdata is in a different location.

---

## Advanced: System Tweaks via ADB

These are optional quality-of-life improvements you can apply via ADB from your Mac/PC. **ADB is not required for the core setup** — everything above can be done with just the Ugoos remote. ADB is only needed for the advanced tweaks in this section.

### Setting up ADB

1. On the Ugoos: Settings → About → tap **Build Number** 7 times to enable Developer Options
2. Settings → Developer Options → enable **USB Debugging** (for USB) or **Wireless Debugging** (for WiFi)
3. On your Mac: `brew install scrcpy` (includes adb)
4. Connect via USB: `adb devices`
5. Or connect via WiFi: `adb connect <ugoos-ip>:5555`

### Reduce UI Animations

Makes the Ugoos interface feel snappier:

```bash
adb shell "settings put global window_animation_scale 0.5"
adb shell "settings put global transition_animation_scale 0.5"
adb shell "settings put global animator_duration_scale 0.5"
```

### Keep WiFi Alive During Sleep

Prevents streams from dropping if the screen dims:

```bash
adb shell "settings put global wifi_sleep_policy 2"
```

---

## Audio Sync Troubleshooting

Audio delay is a common issue with streaming addons. Here's how to diagnose and fix it.

### Delay is constant from the start

This is usually a processing delay in the TV or receiver.

- **In Kodi:** Settings → Player → Videos (Expert mode) → **Audio offset** — adjust in milliseconds. Positive delays audio, negative advances it.
- **On the TV:** Check for an AV Sync Adjustment setting (LG: Settings → Sound → Advanced → AV Sync Adjustment)
- **Disable audio processing:** Turn off AI Sound, Virtual Surround, or any audio effects on the TV — these add latency

### Delay gets worse over time (progressive drift)

This is a buffering issue. The video decoder stalls waiting for data while audio keeps playing.

- **Apply the buffer settings** from the [Advanced: Buffer and Network Optimization](#advanced-buffer-and-network-optimization) section — this is the primary fix
- **Use Real Debrid links** instead of free links — RD servers are fast enough to keep the buffer full
- **Use ethernet** instead of WiFi for more consistent bandwidth

### Quick fix during playback

While a video is playing:

1. Press the **menu/settings button** on the remote
2. Look for **Audio settings** or **Audio offset**
3. Adjust until it syncs

This only applies to the current video — it doesn't persist.

### Audio format issues (crackling, dropouts, no sound)

- Check that your TV's audio output is set correctly (Pass Through if using a receiver, PCM if using TV speakers)
- In Kodi: try changing Audio output device to a different option and testing
- Ensure HDMI Deep Colour is ON on the TV for the Ugoos port

---

## Automated Setup with Claude

This repo includes a `CLAUDE.md` file that enables [Claude Code](https://docs.anthropic.com/en/docs/claude-code) to assist with setup via ADB. If you have Claude Code installed and your Ugoos connected via ADB:

```bash
cd streambox
claude
```

Claude can:
- Detect your Ugoos via ADB and check its current state
- Create and deploy the advancedsettings.xml buffer config
- Set Real Debrid priority in ResolveURL
- Apply system animation and WiFi tweaks
- Verify all settings are correctly applied

See [CLAUDE.md](./CLAUDE.md) for details.

---

## Files in This Repo

```
streambox/
├── README.md                  # This guide
├── CLAUDE.md                  # Instructions for Claude Code agent
├── .claude/
│   └── agent.md               # Agent behavior instructions
├── configs/
│   └── advancedsettings.xml   # Kodi buffer/network config
└── scripts/
    └── setup-adb.sh           # ADB setup script
```

---

## Firmware Updates

Check for Ugoos firmware updates regularly: **Ugoos Settings → OTA Update**. Version 2.0.6+ includes critical fixes for system crashes and Dolby Vision/HDR color issues. This is the single most impactful thing you can do if you're experiencing crashes.

---

## Network Recommendations

- **Ethernet is strongly recommended** for 4K streaming. The AM9 Pro has a 1 Gigabit ethernet port.
- 4K Real Debrid streams need consistent 25-50 Mbps. WiFi can handle this but is more susceptible to interference and buffering.
- If you must use WiFi, connect to the **5GHz band** (not 2.4GHz).

---

## Quick Reference

| What | Where |
|------|-------|
| The Crew | Add-ons → Video add-ons → The Crew |
| Mad Titan Sports | Add-ons → Video add-ons → Mad Titan Sports |
| Real Debrid auth | The Crew → Tools → RESOLVEURL: Settings → Universal Resolvers 2 → Real-Debrid |
| Display refresh rate | Settings → Player → Videos → Adjust display refresh rate → On start/stop |
| Audio settings | Settings → System → Audio (Expert mode) |
| Kodi userdata path | Use: `adb shell "find / -name 'guisettings.xml' 2>/dev/null"` |
| Ugoos firmware | Ugoos Settings → OTA Update |
