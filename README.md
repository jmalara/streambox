# Streambox Setup Guide

Simple setup guide for getting **TiviMate + Strong 8K + EPGenius** running on any Android TV box (designed and tested on **Ugoos AM9 Pro** and **Superbox**).

Hand this repo to a friend with [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed and they can walk through the whole thing in under 30 minutes.

---

## What You'll End Up With

- **TiviMate** — gold standard IPTV player with EPG, favorites, catch-up, and recording
- **Strong 8K** — IPTV service with 30K+ channels including every sports network
- **EPGenius** — community-curated playlists with clean channel names, logos, and EPG

---

## Easiest Path: Let Claude Code Walk You Through It

The whole setup is designed to be driven by [Claude Code](https://docs.anthropic.com/en/docs/claude-code) — it'll ask which box you have, skip the steps that don't apply, and help debug anything that goes wrong. Works for **Superbox** or **Ugoos**.

### One-step start (don't need to clone first)

Open a terminal anywhere on your computer and run:

```bash
claude
```

Then paste exactly this:

> *"Clone https://github.com/jmalara/streambox into a folder, then walk me through setting up TiviMate, Strong 8K, and EPGenius on my Superbox."*

Replace `Superbox` with `Ugoos` if that's what you have.

### What Claude does

1. Clones the repo into a folder
2. Reads project context (`CLAUDE.md` + `.claude/agent.md` + `README.md`)
3. Confirms which box you have and what you've already done
4. Walks you through **one step at a time**, waits for you to say "done" before moving on
5. Skips the parts that don't apply to your box
6. Debugs issues using the Common Issues table

### Already cloned the repo

```bash
cd streambox
claude
```

Then say: *"Walk me through setting up TiviMate, Strong 8K, and EPGenius on my Superbox."*

The rest of this README is the manual version of the same steps — Claude follows it. You can read it for context or just let Claude drive.

---

## TL;DR for Existing Users

Ask **Jeremy** for:
1. To be added to his TiviMate Companion account → TiviMate Premium for free
2. His Strong 8K reseller link / referral
3. To register your EPGenius playlist on Discord for you (once you have a Google Drive M3U URL from EPGenius — Step 5)

Then follow Steps 1-5 below (or let Claude Code drive — see above).

---

## Step 1: Power On Your Box and Update Firmware

1. Connect the box to your TV and to WiFi or ethernet (ethernet preferred for stable streams)
2. Check for firmware updates and install whatever's pending
   - **Ugoos:** Settings → About → OTA Update (target version 2.0.6+)
   - **Superbox:** Settings menu in the Superbox launcher → check for updates
3. While the box updates, sign up for an IPTV service (next step) on your phone or laptop

---

## Step 2: Get an IPTV Service (Strong 8K)

You need an IPTV service that gives you Xtream Codes credentials (server URL + username + password).

1. Go to [https://my8k.org](https://my8k.org) — Strong 8K's current site (formerly strong8k.app)
2. **Get the 24-hour free trial first** — test during a live game before paying
3. **Recommended subscription length: 6 months.** Best balance of price and risk. Avoid yearly upfront (services can disappear); monthly is meaningfully more expensive per month.
4. Strong 8K emails you Xtream Codes credentials: **server URL, username, password**

Pricing: ~$2-5/month via resellers, $10-15/month direct.

> **Quality note:** Live sports run at the source broadcast resolution (ESPN 720p, Fox Sports 1080p). The "8K/4K" branding in service names refers to VOD content, not live sports. Looks great on any modern TV.

---

## Step 3: Install TiviMate

TiviMate is not on the Play Store on most Android TV box firmware. Sideload it:

1. Open **Chrome** on the box (install Chrome from Play Store first if needed)
2. Go to `tivimate.en.uptodown.com/android/download`
3. Download the APK and install it (allow "Unknown Sources" for Chrome if prompted)

> ### Skip paying for TiviMate Premium — use Jeremy's account
>
> Jeremy has a TiviMate Companion paid account and can add your device. **Reach out to him before buying your own subscription.** Once added, your TiviMate gets all premium features (recording, multi-playlist, favorites management, auto EPG updates) at no cost.
>
> Otherwise: TiviMate Premium is ~$20/year or ~$34 lifetime via the in-app purchase.

> **Note:** TiviMate Companion is a separate app for managing premium subscriptions — it is NOT the player. The player is "TiviMate IPTV Player" (`ar.tvplayer.tv`).

---

## Step 4: Configure TiviMate with Strong 8K

1. Open TiviMate → **Add Playlist** → **Xtream Codes**
2. Enter the **Server URL**, **Username**, and **Password** Strong 8K emailed you
3. Name the playlist (e.g., "Strong 8K")
4. **Connect** → it downloads channels and EPG

### Recommended Player Settings

In TiviMate → **Settings → Player**:

- **Buffer Size** → **Small** (fast channel switching)
- **Audio Passthrough** → **On**
- **Tunneled Playback** → **Off** (causes decoder errors on most Android boxes)
- **AFR (Auto Frame Rate)** → **On** (matches TV refresh rate to stream — important for sports)
- **AFR on VOD** → **Off** (avoids screen flicker)
- **Switch 50/60fps only** → **On**
- **Video Decoder** → **Hardware**

### Recommended EPG Settings

In TiviMate → **Settings → EPG / Playlists**:

- **EPG Update Interval** → 4 hours
- **Playlist Update Interval** → 4 hours
- **Past Days to Keep** → 1
- **Logos** → Prefer logos from EPG

### Channel Labels

IPTV providers tag channels with quality tiers — prefer in this order:

- **VIP** — premium stream, most stable
- **8K** — higher bitrate (not real 8K)
- **standard**
- **BK** — backup, fallback only

---

## Step 5: Add EPGenius for Better Channel Organization

EPGenius is a community-curated *lens* on top of your Strong 8K subscription. You still pay Strong 8K for the actual streams — EPGenius doesn't replace anything. It just turns Strong 8K's raw 30,000-channel firehose into a clean, organized, well-labeled playlist.

### What EPGenius does for you

- **Cleans up channel names** — turns `US: ESPN HD ᴴᴰ ⁴ᴷ` into just `ESPN`. No more numbered duplicates, no spam, no random Unicode garbage.
- **Adds proper logos** for every channel — your TiviMate guide actually looks good.
- **Organizes channels into sensible categories** — Sports / News / Movies / Kids / Locals / etc. The raw Strong 8K list dumps everything into 40+ language and country groupings.
- **Maps EPG (program guide) data correctly** — significantly better coverage than the raw feed. Most US/UK/AU/CA sports and live TV channels get a full guide so you can see what's on next, what's airing later tonight, etc.
- **Auto-updates over time** — when Strong 8K swaps stream URLs, adds new channels, or fixes broken ones, EPGenius rebuilds the playlist automatically. Your TiviMate keeps loading from the same Google Drive URL forever, no manual maintenance.
- **Same playlist works across every device** — your TiviMate on the box, Chillio on Mac/iPad/iPhone all see the identical channel list and organization.

### What EPGenius does NOT do for you

- **No movies or TV shows (VOD)** — EPGenius is **live TV only**. For movies and series, keep the raw Strong 8K Xtream Codes playlist as a second playlist (you'll have both in TiviMate).
- **No international / non-English channels** — focused on USA, UK, Australia, Canada English-language live TV. If you watch foreign-language sports or news, the raw Strong 8K list still has them; EPGenius just won't curate them.
- **Doesn't sync your favorites or hidden groups** — EPGenius gives you the same channel *list* on every device, but favorites, hidden groups, and sort order are local to each app. Set up favorites once per device.
- **Doesn't replace Strong 8K** — you still need an active Strong 8K subscription. EPGenius reads your Strong 8K credentials and outputs a curated playlist; without Strong 8K, no streams.
- **Requires registration** — the playlist must be registered in their Discord or it gets deactivated. Jeremy can do this for you (see below).

### Set Up the EPGenius Playlist

Do this on your phone or laptop, not the box itself.

1. Go to [https://epgenius.org](https://epgenius.org)
2. Filter by **Strong 8K**
3. Pick **GanjaRelease | Strong 8K** — the recommended one. Best EPG coverage for USA/UK/AU/CA sports and live TV.
4. Click **Google Drive** to set up — this is the recommended option. Sign into Google when prompted.
5. When asked for credentials, pick **Xtream Codes** and enter your Strong 8K server URL, username, password
6. EPGenius writes the curated playlist to your Google Drive and gives you an M3U URL pointing at it. **Don't delete the file** — EPGenius auto-updates it (new channels, EPG fixes) and your TiviMate keeps loading from the same URL.

### Add It to TiviMate

1. In TiviMate → **Add Playlist** → **M3U Playlist**
2. Paste the Google Drive M3U URL EPGenius generated
3. Name it "EPGenius"
4. Let it download

### Register on Discord (Required)

EPGenius requires playlist registration on their Discord to keep it active.

> **Easy mode:** Jeremy is already set up on the EPGenius Discord and can register your playlist for you. Just send him your Google Drive M3U URL (the one EPGenius generated above) and he'll register it. You can skip the rest of this section.

If Jeremy isn't available, do it yourself:

1. Join the EPGenius Discord (link on their website)
2. Complete verification in the welcome channel
3. In `🤖〢bot-commands`, click **Register Playlist** → paste your URL when prompted

### Use Both Playlists

EPGenius is **live TV only** — no movies/VOD. Keep your raw Strong 8K Xtream Codes playlist for VOD. TiviMate Premium supports multiple playlists. Set EPGenius as your main daily-driver, fall back to Strong 8K for movies.

### Set TiviMate to Open to Favorites

After your channels are loaded:

1. Long-press OK on a channel you like → **Add to Favorites** → **Create Group** ("Sports", etc.)
2. Add channels to your custom groups
3. **Settings → General → Startup → Favorites** so TiviMate boots into your curated list

---

## Step 6: Watch on Your Mac, iPad, or iPhone (Optional)

**Chillio** is the best IPTV player for macOS, iPadOS, and iOS — same Strong 8K credentials, same EPGenius playlist, on every Apple device.

1. Install **Chillio IPTV Smart Player** from the Mac App Store / App Store
2. **Settings → Accounts → Add Account → Xtream Codes** → enter your Strong 8K credentials
3. Optionally also add the EPGenius M3U URL: Add Account → **M3U** → paste the Google Drive URL

Chillio is free with basic features; **Chillio Premium** (~$2.49/month or ~$100 lifetime) unlocks profiles and customization.

> Customizations (favorites, hidden groups, sort order) are local to each app on each device — they don't sync across TiviMate, Chillio, etc. The channel list itself stays consistent because EPGenius gives you the same curated playlist everywhere.

---

## Box-Specific Differences

Most of the steps above are identical on any Android TV box. Hardware-specific bits:

### Ugoos AM9 Pro

- **Display:** Settings → Display → set **Color Mode = YCbCr 4:2:2 12-bit**, **Resolution = 4K 60Hz**, enable **HDR**, **Dolby Vision**, **Automatic Frame Rate**
- **Firmware target:** version 2.0.6+ (fixes crashes and HDR/DV color issues)
- **Optional:** replace the cluttered stock launcher with FLauncher — sideload from `apkpure.com/flauncher/me.efesser.flauncher`. To set as default via ADB: `adb shell cmd package set-home-activity me.efesser.flauncher/.MainActivity`

### Superbox

- **Display:** Superbox handles HDR / Dolby Vision / refresh rate automatically through its own settings menu — generally no manual override needed
- **Firmware:** check for OTA updates from the Superbox launcher's settings menu — apply pending updates before installing apps
- **Launcher:** Superbox uses its own custom launcher — don't try to swap it
- **TiviMate install on Superbox:**
  1. Most Superbox models have **Play Store access** — try installing TiviMate from there first (search "TiviMate")
  2. If TiviMate isn't on Play Store for your firmware, sideload via the built-in **browser** or **File Manager** app:
     - Open the browser → go to `tivimate.en.uptodown.com/android/download` → download APK
     - When prompted, **allow installs from unknown sources** for the browser app (Settings → Apps → Browser → Install Unknown Apps → On)
     - Open the downloaded APK and install
- **Allow Unknown Sources on Superbox:** Settings → Security or Settings → Apps → Special Access → **Install Unknown Apps** → enable for the browser/file manager you used to download
- **ADB:** Superbox firmware is locked down — ADB system tweaks generally won't apply or revert on reboot. Skip the ADB tweaks above. The Claude Code walkthrough automatically skips ADB steps if you tell Claude you're on Superbox.
- **Storage:** Superbox internal storage is usually plenty for TiviMate + recordings. If recording lots of games, plug in a USB drive — TiviMate Recording supports external storage.
- **Remote:** Superbox remote works fully with TiviMate out of the box — no Bluetooth pairing or extra setup needed.

### TV Picture Settings (Any Box)

On the HDMI input your box is plugged into, on your TV:

- **HDMI Deep Colour** (or "HDMI Ultra HD Deep Color") → **On** — without this the TV caps the signal at 8-bit
- **Picture Mode** → Filmmaker Mode or Cinema (most accurate)
- **OLED Pixel Brightness** → 100 (OLED TVs only, for HDR)
- **Motion Smoothing / TruMotion** → **Off** (eliminates soap opera effect)
- **Sharpness** → 0
- **Noise Reduction** → Off

---

## Common Issues

| Issue | Fix |
|-------|-----|
| TiviMate not on Play Store | Sideload from `tivimate.en.uptodown.com/android/download` |
| Confused by TiviMate vs TiviMate Companion | Companion is for managing your subscription. The player is "TiviMate IPTV Player" (`ar.tvplayer.tv`) |
| `DecoderInitializationException` on playback | Settings → Player → turn **Tunneled Playback** OFF. If still failing, also turn **Audio Passthrough** OFF |
| EPG empty / no program data | Settings → EPG → **Clear EPG** then **Update EPG**. Make sure your playlist has an EPG URL |
| EPGenius `HttpDataSourceException` | epgenius.org → **Edit Credentials** → update DNS/username/password → refresh playlist in TiviMate |
| Channels load but won't play | Verify Xtream Codes credentials are correct — credentials may have expired or changed |
| Channels suddenly all stop working | Settings → Playlists → [your playlist] → **Update Playlist**. Server URL/port may have changed |
| Live sports look low-res | ESPN broadcasts at 720p, Fox Sports at 1080p — that's the source, not an IPTV limitation |

---

## Subscriptions & Costs

| Service | Cost | Notes |
|---------|------|-------|
| **TiviMate Premium** | **Free via Jeremy's account** (else ~$20/year or ~$34 lifetime) | Reach out to Jeremy first |
| **Strong 8K** | ~$2-5/month (reseller) | [https://my8k.org](https://my8k.org). Recommend 6-month sub |
| **Chillio** (Mac / iPad / iPhone) | Free or ~$2.49/month premium | Optional, only if you want IPTV on Apple devices |
| **EPGenius** | Donation-supported | Optional ~$10 donation via their Discord/website |

Roughly **$5/month total** for the IPTV service after Jeremy's TiviMate account covers the player.

---

## Network Tips

- **Ethernet** is the most stable for live sports. Both Ugoos AM9 Pro and Superbox have gigabit ethernet.
- If on WiFi, use the **5GHz** band, not 2.4GHz
- IPTV needs ~50 Mbps for reliable HD sports streams
- **VPN:** generally not needed. If your ISP throttles IPTV (streams buffer at peak hours but speed test is fine), a VPN to a nearby server fixes it. Surfshark or Mullvad are solid picks.

---

## Quick Reference

| What | Where |
|------|-------|
| Strong 8K signup | [https://my8k.org](https://my8k.org) — get Xtream Codes credentials |
| TiviMate APK | `tivimate.en.uptodown.com/android/download` |
| TiviMate Premium | Get added to Jeremy's TiviMate Companion account (free) |
| EPGenius playlists | [https://epgenius.org](https://epgenius.org) → filter by Strong 8K → GanjaRelease |
| Chillio (Mac/iPad/iPhone) | Mac App Store / App Store — "Chillio IPTV Smart Player" |
| TiviMate setup | Add Playlist → Xtream Codes → enter Strong 8K credentials |
| EPGenius setup | Add Playlist → M3U Playlist → paste Google Drive URL |
| Player settings | Tunneled Playback OFF, Audio Passthrough ON, Buffer Small, AFR ON |
