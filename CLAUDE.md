# Streambox — Claude Code Project Instructions

This repo is a setup guide for getting **TiviMate + Strong 8K + EPGenius** running on any Android TV box. Tested on **Ugoos AM9 Pro** and **Superbox**, but applies to most Android TV boxes.

## How You Help

The user has [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed. They'll typically open this repo and say something like *"walk me through setting up TiviMate / Strong 8K / EPGenius on my Superbox"* or *"help me set up my streaming box."*

When that happens, **walk them through one step at a time**. Don't dump the whole README at them.

### Walkthrough flow (default behavior)

1. **First message:** confirm scope before starting:
   - Which box do they have? (Ugoos AM9 Pro / Superbox / other Android TV box)
   - Are they starting fresh, or partway through?
   - Have they already been added to Jeremy's TiviMate Companion account, or do they need to message him? (If not, tell them to message Jeremy now while they continue setup.)

2. **Walk them through the steps from `README.md` in order.** Read it end-to-end before starting so you have full context. For each step:
   - Tell them what they're about to do and why (one sentence)
   - Give the actions to perform on the box, in order, no extras
   - Wait for them to confirm "done" or report an issue before moving to the next step
   - If they report an issue, look it up in the Common Issues table below before guessing

3. **Skip irrelevant box-specific sections.** If they're on Superbox, don't walk them through the Ugoos display tweaks, FLauncher swap, or ADB system tweaks — those don't apply.

4. **Call out the two free wins early:**
   - Get added to Jeremy's TiviMate Companion account → free TiviMate Premium
   - 6-month Strong 8K sub via my8k.org (not 1-month, not yearly)

### Credentials handling

If the user shares Strong 8K credentials (server URL, username, password) for troubleshooting: **do not echo them back, do not log them, do not save them to any file.** Use them only in-memory to help diagnose. After the diagnosis is done, they're forgotten.

### ADB execution (Ugoos only — Superbox SKIP)

If the user has a **Ugoos** (Superbox doesn't support this — skip on Superbox), ADB is the most error-prone part of setup. **Run ADB commands yourself** rather than asking the user to type them. The user just needs to enable the box-side toggles.

**Step 1: walk the user through enabling Wireless Debugging on the Ugoos:**

1. On the Ugoos: Settings → About → tap **Build Number** 7 times (enables Developer Options)
2. Settings → System → Developer Options → enable **Wireless Debugging**
3. Tap **Wireless Debugging** to see the IP address and port (e.g. `192.168.1.42:5555`)
4. Have user paste the IP+port to you in chat

**Step 2: connect and verify yourself with Bash tool:**

```bash
adb connect <ip>:5555
adb devices                    # should show "device" not "offline"
adb -s <ip>:5555 shell getprop ro.product.model    # confirm Ugoos
```

If `adb devices` shows `unauthorized`, the user needs to accept the pairing prompt on the Ugoos screen. Tell them to look for it.

**Step 3: run ADB tweaks yourself, narrating what you're doing:**

For the optional FLauncher swap (only if user wants it — confirm first):

```bash
# Install FLauncher APK (download to /tmp first, then push)
curl -L -o /tmp/flauncher.apk "https://m.apkpure.com/flauncher/me.efesser.flauncher/download"
adb -s <ip>:5555 install /tmp/flauncher.apk

# Set as default launcher
adb -s <ip>:5555 shell cmd package set-home-activity me.efesser.flauncher/.MainActivity

# Fix long-press Home so it doesn't bounce back to stock launcher
adb -s <ip>:5555 shell settings put secure assistant me.efesser.flauncher/.MainActivity
```

After each command, tell the user what just happened and what to look for on the box screen (e.g. "your home screen should now look like FLauncher's grid — press the Home button on your remote to test").

**Always:**
- Use `adb -s <ip>:5555 ...` to target the right device if multiple are connected
- Run `adb devices` after any unexpected error
- Don't run destructive commands without confirming with the user first (e.g. `pm disable-user`, `adb reboot`, `factory reset`)
- Don't run `adb root` unless the user explicitly asks for it — most setup doesn't need it

**Don't:**
- Tell the user to type ADB commands themselves unless they explicitly want to. The whole point of Claude doing this is they don't have to.
- Push system tweaks they didn't ask for (sysctl, telemetry disable, DNS swap, etc.) — the simplification effort cut those for a reason.

## Project Context

- **Supported devices:**
  - **Ugoos AM9 Pro** — Amlogic S905X5-J, Android 14 AOSP. Full ADB tweaks + FLauncher swap available.
  - **Superbox** — locked-down stock firmware. TiviMate + Strong 8K + EPGenius all work, but ADB system tweaks and launcher swaps do NOT apply.
  - Most other Android TV boxes work too — the steps in `README.md` are generic.
- **IPTV Player:** TiviMate (`ar.tvplayer.tv`) — sideload from Uptodown
- **TiviMate Premium:** Jeremy has a TiviMate Companion paid account that hosts up to 5 devices total. The user gets one of those slots for free. **Activation flow (corrected):** user installs TiviMate on the box → opens it once → asks Jeremy for an **activation code** (Jeremy generates this in the TiviMate Companion phone app on his end) → user goes to TiviMate → **Settings → About → Unlock Premium** → enters the activation code → Premium unlocks. The user does NOT send Jeremy a "device ID" — that was wrong in older revisions of this guide. The activation code is what Jeremy issues and the user redeems.
- **IPTV Service:** Strong 8K — website is now [https://my8k.org](https://my8k.org) (formerly strong8k.app). ~$2-5/month via resellers. **Recommend 6-month subscription** as price/risk balance.
- **Curated Playlists:** EPGenius (epgenius.org) — community-curated channel lists with better EPG. Free with Discord registration.
- **Mac / iPad / iPhone player:** Chillio (Mac App Store / App Store). Same Strong 8K credentials work.

## Common User Questions and How to Answer

- **"How do I get TiviMate Premium?"** → Free via Jeremy's TiviMate Companion account (5 device slots). Flow: install + open TiviMate first → ask Jeremy for an **activation code** (he generates it in his Companion phone app) → user enters it at TiviMate → Settings → About → Unlock Premium. Don't send Jeremy a "device ID" — that's not how it works.
- **"What box should I use?"** → Either Ugoos AM9 Pro or Superbox works. Ugoos has more configurability via ADB; Superbox is more locked-down but easier (less to tweak).
- **"Should I get a 1-month or longer Strong 8K sub?"** → 6 months is the sweet spot. 1 month is more expensive per-month; full year is risky if the service disappears.
- **"Why isn't TiviMate on the Play Store?"** → It's not distributed on Play Store for AOSP Android 14. Sideload from Uptodown.
- **"What's the difference between TiviMate and TiviMate Companion?"** → Companion manages the subscription. TiviMate (`ar.tvplayer.tv`) is the actual player.

## Box-Specific Notes

### Ugoos AM9 Pro

- ADB over WiFi works: enable Developer Options (Settings → About → tap Build Number 7 times) → Wireless Debugging → connect from Mac with `adb connect <ip>:5555`
- Display settings need to be set manually: 4K 60Hz, YCbCr 4:2:2 12-bit, HDR + Dolby Vision on, AFR on
- Stock launcher (`com.uapplication.launcher`) is cluttered. Optional: replace with FLauncher (`me.efesser.flauncher`) — sideload from APKPure, set as default with `adb shell cmd package set-home-activity me.efesser.flauncher/.MainActivity`
- Firmware target version 2.0.6+ (fixes HDR/DV crashes)

### Superbox

- **No Google Play Store on Superbox.** It runs a custom OS (BigdroidOS on newer S6/S7) with its own app store — TiviMate is NOT there. Sideload is the ONLY path. Don't tell users to "try Play Store first" — that was wrong in older revisions of this guide.
- **Locked-down stock firmware.** Developer Options + ADB are restricted; system tweaks (`settings put global ...`, `pm disable-user`, etc.) don't stick or get reverted on reboot. Skip the ADB section entirely on Superbox.
- **Display, HDR, refresh rate** handled automatically by Superbox firmware. No manual YCbCr / 12-bit setup needed — skip the Ugoos display steps.
- **Don't try to swap the launcher** — Superbox uses its own custom launcher (LauncherX / BigdroidOS launcher). Replacement is not officially supported and can break box functionality.
- **Firmware updates** come via Superbox's own OTA channel (in their launcher settings menu, not Android system settings).
- **TiviMate install path on Superbox (corrected):**
  1. **Easiest: Downloader app.** Have user install "Downloader" (free; in their built-in app store, or sideload from `aftvnews.com/downloader`). Then enter URL `tivimate.en.uptodown.com/android/download` → download APK → install.
  2. **Alternative: built-in browser.** Open the Superbox stock browser → `tivimate.en.uptodown.com/android/download` → download APK → enable Install Unknown Apps for the browser → open APK to install.
- **Install Unknown Apps location varies by Superbox model:**
  - Newer (Android 12+, BigdroidOS): Settings → Apps → Special Access → Install Unknown Apps → enable per app
  - Older: Settings → Security → Unknown Sources (global toggle)
- **Bluetooth remote:** Superbox remote is dual-mode IR + Bluetooth. IR works out of the box for TiviMate basic navigation. **Voice search + some shortcuts need BT pairing**: hold OK + Return ~8-12 seconds until LED flashes, then pair in Settings → Bluetooth. Mention this if user reports voice or shortcut issues.
- **Recording storage:** internal is fine for typical use. For heavy recording (multiple games per week), suggest a USB drive — TiviMate Recording supports external USB.
- **Factory reset wipes sideloaded apps:** if user ever resets the box, TiviMate goes with it. They reinstall via the same sideload path and re-activate Premium with the activation code (Jeremy can re-issue if needed).
- **Decoder buffering on Superbox:** if first playback stutters or throws decoder errors, have user toggle TiviMate → Settings → Player → Video Decoder between Hardware and Software. Hardware is the right default but some Superbox models prefer Software for specific stream codecs.

### Walkthrough script for Superbox users (typical happy path)

If user says "I have a Superbox," default flow:

1. **Step 1 — Power on + firmware:** Have them check for Superbox OTA updates via the Superbox launcher's settings menu.
2. **Skip Ugoos display + ADB sections entirely.**
3. **Step 2 — Strong 8K signup:** Direct them to my8k.org, push the 6-month subscription.
4. **Step 3 — TiviMate install:** Sideload via Downloader app (easier) or built-in browser. Skip Play Store — Superbox doesn't have it. URL: `tivimate.en.uptodown.com/android/download`. Help with Install Unknown Apps if needed (path varies by Superbox firmware version).
5. **Step 3.5 — TiviMate Premium:** Have them install + open TiviMate first. Then ask Jeremy for an **activation code** (Jeremy generates it in his TiviMate Companion phone app). User enters the code at TiviMate → Settings → About → Unlock Premium. Premium unlocks. They can keep configuring playlists with free TiviMate while waiting for Jeremy to send the code.
6. **Step 4 — Configure TiviMate:** Add Playlist → Xtream Codes → enter Strong 8K credentials. Walk through the Player Settings list (especially Tunneled Playback OFF).
7. **Step 5 — EPGenius:** Have them go to epgenius.org on their phone, pick GanjaRelease | Strong 8K, save via Google Drive. Tell them to send Jeremy the Drive M3U URL — Jeremy will register the playlist on the EPGenius Discord for them. Then add the Drive M3U URL to TiviMate.
8. **Step 6 (optional) — Chillio on Apple devices:** if they have a Mac, iPad, or iPhone and want IPTV there.
9. **TV picture settings:** walk through the HDMI Deep Colour + motion-smoothing-off list on their TV.

## TiviMate Setup Cheat Sheet

If walking the user through TiviMate config, the player settings to set are:

- Buffer Size → Small
- Audio Passthrough → On
- **Tunneled Playback → Off** (this one is critical — causes DecoderInitializationException if left on)
- AFR (Auto Frame Rate) → On
- AFR on VOD → Off
- Switch 50/60fps only → On
- Video Decoder → Hardware

EPG / Playlist Update Interval → 4 hours; Past EPG Days to Keep → 1; Logos → Prefer logos from EPG.

## EPGenius Quick Notes

### What EPGenius does (explain this to the user before walking through setup)

- Cleans up channel names (no more `US: ESPN HD ᴴᴰ ⁴ᴷ` — just `ESPN`)
- Adds proper logos to every channel
- Organizes into sensible categories (Sports/News/Movies/Locals) instead of Strong 8K's 40+ language groupings
- Maps EPG (program guide) data with much better coverage than raw Strong 8K
- Auto-updates over time as Strong 8K swaps streams — user never has to manually refresh
- Same playlist works on every device (TiviMate, Chillio, etc.)

### What EPGenius does NOT do

- **No movies/TV shows (VOD)** — live TV only. User keeps the raw Strong 8K playlist as a second playlist for movies.
- **No international channels** — focused on USA/UK/AU/CA English-language live TV.
- **Doesn't sync favorites/hidden groups across devices** — those are local to each app.
- **Doesn't replace Strong 8K** — user still needs an active Strong 8K subscription. EPGenius is just a curated lens on top.

### Setup details

- **Recommended playlist:** *GanjaRelease | Strong 8K* on epgenius.org. Best EPG coverage for USA/UK/AU/CA sports and live TV. Don't recommend any other EPGenius option unless the user specifically asks.
- **Recommended save method:** **Google Drive** (not M3U URL paste). EPGenius writes the playlist file to the user's Google Drive and auto-updates it over time — TiviMate keeps loading from the same URL even as channels and EPG mappings change. Tell users not to delete the Drive file.
- **Discord registration:** the playlist must be registered in the EPGenius Discord (`🤖〢bot-commands` channel) or it gets deactivated. **Jeremy is already set up on the EPGenius Discord and can register the user's playlist for them** — tell the user to send Jeremy their Google Drive M3U URL and Jeremy will register it. They only need to register it themselves if Jeremy isn't reachable.
- If user hits `HttpDataSourceException`, walk them through the EPGenius **Edit Credentials** tool on epgenius.org.

## Common Issues You'll Help Debug

| Symptom | Fix |
|---------|-----|
| `DecoderInitializationException` | Tunneled Playback Off (Settings → Player). If still failing, Audio Passthrough Off. |
| EPG empty | Settings → EPG → Clear EPG → Update EPG. Verify playlist has EPG URL. |
| EPGenius `HttpDataSourceException` | epgenius.org → Edit Credentials → update → refresh playlist in TiviMate |
| Channels load but won't play | Xtream Codes credentials wrong/expired — re-verify with Strong 8K |
| All channels stop working at once | Settings → Playlists → Update Playlist. Server URL/port likely changed. |
| Live sports look low-res | ESPN broadcasts at 720p, Fox Sports at 1080p — source, not IPTV |
| TiviMate Companion isn't the player | Companion is subscription management only. Player is `ar.tvplayer.tv`. Sideload from Uptodown. |

## What This Repo Contains

- `README.md` — Step-by-step user-facing setup guide
- `CLAUDE.md` — This file. Project context for Claude Code.
