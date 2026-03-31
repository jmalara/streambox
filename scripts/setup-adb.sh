#!/usr/bin/env bash
set -euo pipefail

# Streambox ADB Setup Script
# Applies system tweaks and optional Kodi config to Ugoos AM9 Pro via ADB.
#
# Prerequisites:
#   - ADB installed (brew install scrcpy includes it)
#   - Ugoos connected via USB or WiFi with USB Debugging enabled
#   - adb root supported (Ugoos AOSP allows this)
#
# Usage:
#   ./scripts/setup-adb.sh                    # Full setup (system tweaks + Kodi config)
#   ./scripts/setup-adb.sh --tivimate-only    # System tweaks only, skip Kodi (for IPTV-only boxes)
#   ./scripts/setup-adb.sh --skip-system-tweaks
#   ./scripts/setup-adb.sh --skip-kodi-config
#   ./scripts/setup-adb.sh --dry-run

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
ADVANCEDSETTINGS="$REPO_DIR/configs/advancedsettings.xml"

SKIP_SYSTEM=false
SKIP_KODI=false
DRY_RUN=false

for arg in "$@"; do
  case $arg in
    --skip-system-tweaks) SKIP_SYSTEM=true ;;
    --skip-kodi-config|--tivimate-only) SKIP_KODI=true ;;
    --dry-run) DRY_RUN=true ;;
    --help|-h)
      echo "Usage: $0 [--skip-system-tweaks] [--skip-kodi-config] [--tivimate-only] [--dry-run]"
      echo ""
      echo "Options:"
      echo "  --skip-system-tweaks  Skip Android system tweaks (animations, DNS, telemetry)"
      echo "  --skip-kodi-config    Skip Kodi advancedsettings.xml deployment"
      echo "  --tivimate-only       Alias for --skip-kodi-config (for IPTV-only setups)"
      echo "  --dry-run             Show commands without executing"
      exit 0
      ;;
  esac
done

run() {
  if $DRY_RUN; then
    echo "[dry-run] $*"
  else
    eval "$@"
  fi
}

echo "=== Streambox ADB Setup ==="
echo ""

# Check ADB connection
echo "Checking ADB connection..."
if ! adb devices | grep -q "device$"; then
  echo "ERROR: No device found. Make sure:"
  echo "  1. USB Debugging is enabled on the Ugoos (Developer Options)"
  echo "  2. The device is connected via USB or 'adb connect <ip>:5555'"
  exit 1
fi

DEVICE=$(adb devices | grep "device$" | head -1 | awk '{print $1}')
echo "Found device: $DEVICE"

# Get root
echo "Requesting root access..."
run "adb root" 2>/dev/null || true
sleep 2

# Get firmware version
echo ""
FW=$(adb shell "getprop ro.build.display.id" 2>/dev/null | tr -d '\r')
echo "Firmware: $FW"
echo "(If you're experiencing crashes, update to 2.0.6+ via Ugoos Settings → OTA Update)"
echo ""

# ── Kodi Configuration ──

if ! $SKIP_KODI; then
  echo "=== Kodi Configuration ==="

  # Find Kodi userdata path
  echo "Finding Kodi userdata path..."
  KODI_USERDATA=$(adb shell "find /data/media/0 -name 'guisettings.xml' -path '*org.xbmc.kodi*' 2>/dev/null | head -1" | tr -d '\r')

  if [ -z "$KODI_USERDATA" ]; then
    echo "WARNING: Could not find Kodi userdata. Is Kodi installed and has been launched at least once?"
    echo "Skipping Kodi configuration."
  else
    USERDATA_DIR=$(dirname "$KODI_USERDATA")
    echo "Found userdata at: $USERDATA_DIR"

    # Deploy advancedsettings.xml (network timeouts + GUI rendering only — cache is in Kodi GUI)
    echo ""
    echo "Deploying advancedsettings.xml (network timeouts + GUI config)..."
    if [ ! -f "$ADVANCEDSETTINGS" ]; then
      echo "ERROR: $ADVANCEDSETTINGS not found"
      exit 1
    fi

    CONTENT=$(cat "$ADVANCEDSETTINGS")
    run "adb shell \"cat > $USERDATA_DIR/advancedsettings.xml << 'XMLEOF'
$CONTENT
XMLEOF\""

    echo "Verifying advancedsettings.xml..."
    if ! $DRY_RUN; then
      if adb shell "test -f $USERDATA_DIR/advancedsettings.xml" 2>/dev/null; then
        echo "  ✓ advancedsettings.xml deployed successfully"
      else
        echo "  ✗ Failed to create advancedsettings.xml"
      fi
    fi

    echo ""
    echo "NOTE: Real Debrid and POV autostart are configured through the POV UI, not ADB."
    echo "  - Real Debrid: POV → Settings → My Services → Real Debrid → Authorize (priority 0)"
    echo "  - Autostart: POV → Settings → General → Auto Start POV when Kodi Starts → On"
    echo "  - Cache: Kodi → Settings → Services → Caching (Expert) → 350MB, readfactor 20"
  fi

  echo ""
fi

# ── System Tweaks ──

if ! $SKIP_SYSTEM; then
  echo "=== System Tweaks ==="

  echo "Disabling UI animations (instant menus)..."
  run 'adb shell "settings put global window_animation_scale 0"'
  run 'adb shell "settings put global transition_animation_scale 0"'
  run 'adb shell "settings put global animator_duration_scale 0"'
  echo "  ✓ Animations disabled"

  echo ""
  echo "Setting WiFi to stay alive during sleep..."
  run 'adb shell "settings put global wifi_sleep_policy 2"'
  echo "  ✓ WiFi sleep policy set to never"

  echo ""
  echo "Setting Cloudflare DNS-over-TLS..."
  run 'adb shell "settings put global private_dns_mode hostname"'
  run 'adb shell "settings put global private_dns_specifier 1dot1dot1dot1.cloudflare-dns.com"'
  echo "  ✓ DNS set to Cloudflare (1.1.1.1) with TLS"

  echo ""
  echo "Disabling telemetry and diagnostic reporting..."
  run 'adb shell "settings put global send_action_app_error 0"'
  run 'adb shell "settings put global netstats_enabled 0"'
  run 'adb shell "settings put global app_standby_enabled 0"'
  echo "  ✓ Telemetry disabled"

  echo ""
  echo "Disabling popup notifications during video..."
  run 'adb shell "settings put global heads_up_notifications_enabled 0"'
  echo "  ✓ Heads-up notifications disabled"

  echo ""
  echo "Disabling Android HDR tone mapping (let the TV handle it)..."
  run 'adb shell "settings put global hdr_conversion_mode 0"'
  echo "  ✓ HDR passthrough enabled"

  echo ""
  echo "Applying network streaming optimizations..."
  run 'adb shell "sysctl -w net.ipv4.tcp_slow_start_after_idle=0"' 2>/dev/null || true
  run 'adb shell "sysctl -w net.core.rmem_max=2097152"' 2>/dev/null || true
  run 'adb shell "sysctl -w net.core.wmem_max=2097152"' 2>/dev/null || true
  echo "  ✓ TCP optimizations applied (note: these don't persist across reboots)"

  echo ""
  echo "Disabling bloatware..."
  run 'adb shell "pm disable-user --user 0 com.android.printspooler"' 2>/dev/null || true
  run 'adb shell "pm disable-user --user 0 com.ugoos.ugoosfirstrun"' 2>/dev/null || true
  echo "  ✓ Print service and first-run wizard disabled"

  echo ""
fi

# ── Done ──

echo "=== Setup Complete ==="
echo ""
if $SKIP_KODI; then
  echo "Next steps (TiviMate-only setup):"
  echo "  1. Sideload TiviMate via Chrome: tivimate.en.uptodown.com/android/download"
  echo "  2. Add IPTV playlist: TiviMate → Add Playlist → Xtream Codes → enter credentials"
  echo "  3. Player settings: Tunneled Playback OFF, Audio Passthrough OFF, Buffer Small"
  echo "  4. Player settings: AFR ON, AFR on VOD OFF, Switch 50/60fps only ON"
  echo "  5. EPG: Settings → EPG → Update Interval → 4 hours"
  echo "  6. Clean up: Settings → Playlists → Manage Groups → hide unwanted language groups"
  echo "  7. Ugoos display: 4K 60Hz, YCbCr 4:2:2 12-bit, AFR on, HDR on, DV on"
  echo "  8. Check for Ugoos firmware updates (Settings → OTA Update)"
else
  echo "Next steps:"
  echo "  1. Restart Kodi for config changes to take effect"
  echo "  2. Install POV: Add-ons → Install from zip → kodifitzwell → Install from repo → POV"
  echo "  3. Authorize Real Debrid: POV → Settings → My Services → Real Debrid → Authorize"
  echo "  4. Set Real Debrid priority to 0 in POV → Settings → My Services → Real Debrid"
  echo "  5. Enable external scrapers: POV → Settings → Sources → External Scrapers → On"
  echo "  6. Enable POV autostart: POV → Settings → General → Auto Start POV → On"
  echo "  7. Configure Kodi cache: Settings → Services → Caching → 350MB, readfactor 20"
  echo "  8. Optional: Sideload TiviMate for live sports (tivimate.en.uptodown.com/android/download)"
  echo "  9. Optional: Install FLauncher from APKPure (Play Store incompatible on AOSP)"
  echo " 10. Check for Ugoos firmware updates (Settings → OTA Update)"
fi
echo ""
