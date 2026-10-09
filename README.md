# Streambox Setup Guide

**Recommended box: the Ugoos AM9 Pro.** It's the one Jeremy uses and tested this guide on, it has the best picture (HDR and Dolby Vision), and it's the box Claude can set up for you over your home network. A Superbox works too, but you'll do more of the button pressing yourself.

This guide gets live TV running on your Android TV box with three pieces:

- TiviMate, the player app. It gives you a proper TV guide, favorites and recording.
- Strong 8K, the IPTV subscription. About 10,000 live channels, including all the sports networks.
- EPGenius, a free community playlist that sits on top of Strong 8K and cleans up channel names, logos and the guide.

It's written for a Ugoos AM9 Pro or a Superbox, and most other Android TV boxes work the same way. Plan on about 30 minutes, longer on a Superbox.

## The easy way: let Claude walk you through it

You don't have to read the rest of this. Claude Code can run the whole setup with you, one step at a time, and skip whatever doesn't apply to your box.

### What you need

- Claude Code, which needs a paid Claude plan. Install it on a Mac or Linux with:

  ```bash
  curl -fsSL https://claude.ai/install.sh | bash
  ```

  On Windows, in PowerShell:

  ```powershell
  irm https://claude.ai/install.ps1 | iex
  ```

  Docs are at [code.claude.com/docs](https://code.claude.com/docs).
- Git. On a Mac, run `git --version` and accept the prompt to install it. On Windows, get it from [git-scm.com](https://git-scm.com).

### Start it

```bash
git clone https://github.com/jmalara/streambox
cd streambox
claude
```

Then say:

> Walk me through setting up my Ugoos.

(Or "my Superbox", if that's your box.)

On a Ugoos, Claude connects to the box over your home network and does the technical parts itself, like installing TiviMate. It asks before it installs or changes anything. On a Superbox, Claude can't reach the box, so you press the buttons and it tells you what to press. The Ugoos steps are tested on Jeremy's own box; the Superbox steps come from research, so a menu name may look a little different on yours.

Everything below is the manual version of the same steps. Claude follows it too.

## Ask Jeremy for a TiviMate code first

Text Jeremy now and ask for a TiviMate Premium activation code, so it's ready by Step 4. He makes it in his TiviMate Companion app and it uses one of his 5 device slots, so you don't pay for Premium.

## Step 1: Power on and update

Updates first, so nothing crashes later.

1. Connect the box to your TV, and to your network. Ethernet is best for live sports; Wi-Fi works.
2. Install any pending firmware update.
   - Ugoos: in Settings, under About, open **OTA Update** and install the latest update (2.2.0 as of October 2026; anything 2.0.6 or newer fixes the HDR/Dolby Vision crashes).
   - Superbox: open the settings menu in the Superbox launcher and check for updates there. Superbox updates don't come through the normal Android settings.
3. While it updates, move on to Step 2 on your phone or laptop.

## Step 2: Sign up for Strong 8K

Strong 8K is where the channels come from. You get a server address, username and password that you'll type into TiviMate.

1. Go to [my8k.org](https://my8k.org). That's the Strong 8K storefront Jeremy uses.
2. Ask their support for the free 24-hour trial first, and test it during a live game before you pay.
3. Pick the 6-month plan ($35, about $6 a month). Monthly costs more per month, and services like this can disappear, so don't prepay a full year.
4. Your login arrives by email: server URL, username and password. Check spam if it isn't there in a few minutes. Save it somewhere you can copy from.

Each plan covers one device. Live sports come through at the broadcaster's resolution (ESPN is 720p, Fox Sports is 1080p). The "8K" in the name is about movies, not live games, and it still looks great on a modern TV.

## Step 3: Install TiviMate

TiviMate isn't in your box's app store. The Ugoos has Google Play, but TiviMate only shows up there on certified Android TV devices, and a Superbox has no Google Play at all. So you install the official app file from tivimate.com.

**Don't install "TiviMate Companion" on your box.** That's the phone app Jeremy uses to manage Premium. The player you want is **TiviMate IPTV Player** (`ar.tvplayer.tv`).

### On a Ugoos: let Claude install it

Claude installs TiviMate from your computer once you turn on network debugging on the box. You do this part with the remote:

1. Turn on Developer Options: in Settings, open About (on some firmware it's under Device Preferences) and click **Build** seven times.
2. Turn on the Ugoos network debugging toggle. The exact name varies by firmware; look in Developer Options or the Ugoos settings for ADB debugging over the network.
3. Find the box's IP address in its network settings and give it to Claude.
4. If the TV asks whether to allow debugging, tick **Always allow** and accept.

Claude installs the ADB tool on your computer if it's missing (it asks first), connects, installs TiviMate and checks that it's there. If your firmware only has **Wireless debugging**, Claude walks you through pairing with a code instead.

### On a Superbox, or if you'd rather do it by hand

The Downloader app is the easiest way.

1. Install **Downloader**: search for it in your box's app store, or get it from `aftvnews.com/downloader`.
2. Open Downloader and enter the code `272483` (or type the address `tivimate.com/apk`).
3. When it asks, allow Downloader to install unknown apps, then install TiviMate.

If you'd rather use the box's web browser, go to `https://tivimate.com/apk`, download the file and open it.

If the install is blocked, allow installs from unknown apps for whichever app downloaded the file. Where that lives depends on the box:

- Android 12 and newer (including newer Superbox models): Settings > Apps > Special Access > Install Unknown Apps, then turn it on for Downloader or the browser.
- Older boxes: Settings > Security > **Unknown Sources**.

### Open it once

Open TiviMate and get through the welcome screen. You need that before you can add Premium.

## Step 4: Unlock TiviMate Premium

Premium adds recording, multiple playlists, favorites management and automatic guide updates. You'll want it, because Step 6 adds a second playlist.

1. Get your activation code from Jeremy.
2. In TiviMate, open Settings and choose **Unlock Premium** (on some versions it's under Settings > About).
3. Enter the code. Premium turns on right away.

Still waiting on the code? Keep going. Step 5 and making the EPGenius playlist on your phone both work without it; you only need Premium to add EPGenius as a second playlist in TiviMate. If you'd rather buy it yourself, Premium is about $34 lifetime; the yearly price is shown in the app.

## Step 5: Add Strong 8K to TiviMate

This loads every channel and movie from your subscription.

1. In TiviMate, choose **Add Playlist**, then **Xtream Codes**.
2. Enter the server URL, username and password from the Strong 8K email.
3. Name it "Strong 8K" and connect. TiviMate downloads the channels and guide.

### Player settings

In Settings, under Player (called Playback on some versions), set:

- Buffer Size: Small, for fast channel changes. If games stutter, raise it to Medium.
- Audio Passthrough: On
- Tunneled Playback: **Off**. This one matters most; leaving it on causes playback errors on most boxes.
- AFR (Auto Frame Rate): On. It matches your TV's refresh rate to the stream, which makes sports smoother.
- AFR on VOD: Off, to avoid flicker on movies.
- Switch 50/60fps only: On
- Video Decoder: Hardware

### Guide and playlist settings

In Settings, under EPG and Playlists, set:

- EPG update interval: 4 hours
- Playlist update interval: 4 hours
- Past EPG days to keep: 1
- Logos: prefer logos from EPG

### Channel labels

Strong 8K tags channels by stream quality. Pick them in this order: VIP (most stable), 8K (higher bitrate, not real 8K), the plain version, then BK (backup only).

## Step 6: Add EPGenius

The raw Strong 8K list is huge and messy: names like `US: ESPN HD ᴴᴰ ⁴ᴷ`, duplicates, and 40-plus language groups. EPGenius turns it into a clean playlist that's easy to browse.

What it gives you:

- Clean names (`ESPN` instead of the mess above) and a proper logo on every channel.
- Sensible groups like Sports, News, Movies, Kids and Locals.
- A much more complete TV guide for US, UK, Canada, Australia, Ireland and New Zealand channels.
- Automatic updates. When Strong 8K moves or adds channels, EPGenius rebuilds your playlist and TiviMate keeps loading it from the same link.

What it doesn't do:

- No movies or shows. It's live TV only, so you keep the Strong 8K playlist from Step 5 for those.
- No channels outside those six countries. They're still in the raw Strong 8K list.
- It doesn't sync favorites or hidden groups between devices. Those stay in each app.
- It doesn't replace Strong 8K. It reads your Strong 8K login and builds a playlist from it.

### Make the playlist

Do this on your phone or laptop, not the box.

1. Go to [epgenius.org](https://epgenius.org) and filter by **Strong 8K**.
2. Pick **GanjaRelease | Strong 8K**. It has the best guide coverage for live TV and sports.
3. Choose **Google Drive** to save it, and sign in to Google.
4. When it asks for your login, choose **Xtream Codes** and enter your Strong 8K server URL, username and password.
5. EPGenius saves the playlist to your Google Drive and gives you a link. Copy it. Don't delete that Drive file: EPGenius keeps updating it.

### Register it

EPGenius turns off playlists that aren't registered on its Discord, so do this right after you make it:

1. Join the EPGenius Discord. The invite link is on epgenius.org.
2. Complete the verification in the welcome channel.
3. Open the `🤖〢bot-commands` channel, click **Register Playlist**, and paste your Google Drive link.

EPGenius is free. You can make an optional donation through their site or Discord.

### Add it to TiviMate

1. In TiviMate, choose **Add Playlist**, then **M3U Playlist**.
2. Paste the Google Drive link and name it "EPGenius".
3. Let it load.

Use EPGenius for everyday live TV and switch to the Strong 8K playlist for movies and shows.

### Clean up the channel groups

Out of the box your guide is crowded. Strong 8K alone has hundreds of groups for countries you'll never watch, and EPGenius still includes the UK, Canada, Australia, Ireland and New Zealand alongside the US. Hiding the groups you don't want makes the guide short and fast to scroll. Hidden groups aren't deleted: you can turn any of them back on later.

How to hide groups in TiviMate:

1. Open the TV guide and press left on the remote until the list of groups shows.
2. Long-press OK on any group and choose **Manage groups**. (You can also get there from Settings: open Playlists, pick the playlist, then its groups.)
3. Untick every group you don't want, then press Back to save.

Each playlist has its own group list, so do this once for Strong 8K and once for EPGenius.

**Strong 8K:** this is your movies and shows playlist, so you can hide almost all of its live TV groups. Most group names start with a country code (US, UK, CA, AU and so on), which makes the ones to hide easy to spot. Keep a couple of US sports groups as a backup in case an EPGenius channel is down. Movies and shows have their own group lists: go to Movies or Shows, long-press a group, and hide the foreign-language ones the same way.

**EPGenius:** keep the US groups and hide the UK, Canadian, Australian, Irish and New Zealand ones unless you watch them. If you follow the Premier League or other UK sports, keep the UK sports groups, since that's where those games show up.

### Make TiviMate open to your favorites

1. Long-press OK on a channel you like, choose **Add to Favorites**, and create a group such as "Sports".
2. Add more channels to your groups.
3. In Settings, find the startup option (usually under General) and set it to open to **Favorites**.

## Step 7: Get the best picture

A few settings make a big difference, especially for HDR.

### Ugoos display settings

In Settings > Display, set:

- Color Mode: YCbCr 4:2:2 12-bit
- Resolution: 4K 60Hz
- HDR: On
- Dolby Vision: On
- Automatic Frame Rate: On

A Superbox handles HDR, Dolby Vision and refresh rate on its own, so skip this part.

### TV settings (any box)

On your TV, for the HDMI input the box is plugged into:

- HDMI Deep Color (some TVs call it "HDMI Ultra HD Deep Color"): **On**. Without it the TV caps the signal at 8-bit and HDR won't work.
- Picture Mode: Filmmaker Mode or Cinema.
- OLED Pixel Brightness: 100 (OLED TVs only).
- Motion Smoothing or TruMotion: Off. This gets rid of the "soap opera" look.
- Sharpness: 0
- Noise Reduction: Off

## Step 8: Optional extras

### A cleaner home screen on a Ugoos

The stock Ugoos home screen is cluttered. FLauncher is a simple grid of your apps. Claude can install it and make it your home screen. It uses a maintained community version of FLauncher (the original lives at gitlab.com/flauncher/flauncher), and Claude shows you the download link and waits for your OK first. Don't try this on a Superbox: swapping its launcher can break the box.

### Watch on your iPhone or Apple TV

Chillio is an IPTV player on the App Store; search for "Chillio". Sign in with the same Strong 8K login (Xtream Codes), and add your EPGenius link if you want the same clean list there. Favorites don't carry over between apps.

## Step 9: Check that everything works

- TiviMate opens and your Strong 8K channels load.
- A live sports channel plays without an error.
- The TV guide shows what's on.
- The EPGenius playlist plays, with clean names and logos.
- The guide only shows the groups you want.
- Premium is active, or the code is on its way.

## Superbox notes

- Remote: it works out of the box, but voice search and some shortcuts need Bluetooth. Hold **OK** and **Return** together for about 8-12 seconds until the light flashes, then finish pairing in Settings > Bluetooth.
- Recording: internal storage is fine for the odd game. If you record a lot, plug in a USB drive and save recordings there.
- Launcher: keep the Superbox home screen. Replacing it isn't supported.
- Factory reset: a reset wipes TiviMate. Reinstall it the same way (Step 3) and ask Jeremy for a new activation code.

## Common issues

| Problem | Fix |
|---------|-----|
| TiviMate isn't in Google Play | Expected. Install the official app from `tivimate.com/apk` (Step 3) |
| Not sure whether you have TiviMate or TiviMate Companion | The player is TiviMate IPTV Player (`ar.tvplayer.tv`). Companion is Jeremy's phone app and doesn't belong on the box |
| `DecoderInitializationException` when a channel plays | Turn Tunneled Playback off. Still failing: turn Audio Passthrough off. Still failing: switch Video Decoder between Hardware and Software |
| Games stutter | Raise Buffer Size from Small to Medium |
| The guide is empty | In TiviMate's EPG settings, clear the EPG, then update it. Make sure the playlist has a guide source |
| EPGenius shows `HttpDataSourceException` | On epgenius.org, use **Edit Credentials** to update your server, username and password, then refresh the playlist in TiviMate |
| Channels load but won't play | Your login is wrong or expired. Re-enter it from the Strong 8K email |
| Every channel stops at once | Update the playlist in TiviMate's playlist settings. The server address may have changed |
| Sports look low resolution | That's the source: ESPN broadcasts at 720p, Fox Sports at 1080p |
| The Strong 8K email never came | Check spam. Still nothing after 30 minutes: contact Strong 8K support through my8k.org |
| EPGenius playlist stopped working | It was never registered on Discord. Register it in `🤖〢bot-commands` (Step 6) |

## What it costs

| Service | Cost | Notes |
|---------|------|-------|
| Strong 8K | 1 month $10, 3 months $22, 6 months $35, 12 months $52 | At [my8k.org](https://my8k.org). The 6-month plan works out to about $6 a month |
| TiviMate Premium | Free with Jeremy's activation code | Otherwise about $34 lifetime; the yearly price is shown in the app |
| EPGenius | Free | Optional donation |

All in, about $6 a month for Strong 8K, and nothing else.

## Network tips

- Ethernet is the most stable for live sports. The Ugoos AM9 Pro and Superbox both have gigabit ethernet.
- On Wi-Fi, use the 5GHz band, not 2.4GHz.
- Plan on about 50 Mbps for smooth HD sports.
- You usually don't need a VPN. If streams buffer at busy times while a speed test looks fine, your internet provider may be slowing IPTV, and a VPN to a nearby server fixes it. Surfshark and Mullvad both work well.

## Quick reference

| What | Where |
|------|-------|
| Strong 8K | [my8k.org](https://my8k.org) |
| TiviMate | `https://tivimate.com/apk`, or code `272483` in Downloader |
| TiviMate Premium | Activation code from Jeremy, entered at Settings > Unlock Premium |
| EPGenius | [epgenius.org](https://epgenius.org), filter by Strong 8K, pick GanjaRelease, save to Google Drive |
| Add Strong 8K | Add Playlist > Xtream Codes |
| Add EPGenius | Add Playlist > M3U Playlist > paste the Google Drive link |
| Key player settings | Tunneled Playback off, Audio Passthrough on, Buffer Small, AFR on |
| Chillio (iPhone, Apple TV) | Search "Chillio" on the App Store |
