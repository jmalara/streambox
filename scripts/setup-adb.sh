#!/usr/bin/env bash
set -euo pipefail

# Streambox ADB Setup Script
# Applies Kodi optimizations and system tweaks to Ugoos AM9 Pro via ADB.
#
# Prerequisites:
#   - ADB installed (brew install scrcpy includes it)
#   - Ugoos connected via USB or WiFi with USB Debugging enabled
#   - adb root supported (Ugoos AOSP allows this)
#
# Usage:
#   ./scripts/setup-adb.sh
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
    --skip-kodi-config) SKIP_KODI=true ;;
    --dry-run) DRY_RUN=true ;;
    --help|-h)
      echo "Usage: $0 [--skip-system-tweaks] [--skip-kodi-config] [--dry-run]"
      echo ""
      echo "Options:"
      echo "  --skip-system-tweaks  Skip Android animation and WiFi tweaks"
      echo "  --skip-kodi-config    Skip advancedsettings.xml and ResolveURL priority"
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

    # Deploy advancedsettings.xml
    echo ""
    echo "Deploying advancedsettings.xml..."
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

    # Set Real Debrid priority
    echo ""
    echo "Setting Real Debrid priority in ResolveURL..."
    RESOLVEURL_SETTINGS="$USERDATA_DIR/addon_data/script.module.resolveurl/settings.xml"

    if ! $DRY_RUN && ! adb shell "test -f $RESOLVEURL_SETTINGS" 2>/dev/null; then
      echo "  ResolveURL settings not found. Real Debrid may not be authorized yet."
      echo "  Authorize Real Debrid in The Crew first, then re-run this script."
    else
      run "adb shell \"sed -i 's/RealDebridResolver_priority\\\">100/RealDebridResolver_priority\\\">90/' $RESOLVEURL_SETTINGS\""

      if ! $DRY_RUN; then
        PRIORITY=$(adb shell "grep RealDebridResolver_priority $RESOLVEURL_SETTINGS" 2>/dev/null | tr -d '\r')
        if echo "$PRIORITY" | grep -q '90'; then
          echo "  ✓ Real Debrid priority set to 90"
        else
          echo "  ✗ Could not verify priority change. Current: $PRIORITY"
        fi
      fi
    fi
  fi

  echo ""
fi

# ── System Tweaks ──

if ! $SKIP_SYSTEM; then
  echo "=== System Tweaks ==="

  echo "Reducing UI animations..."
  run 'adb shell "settings put global window_animation_scale 0.5"'
  run 'adb shell "settings put global transition_animation_scale 0.5"'
  run 'adb shell "settings put global animator_duration_scale 0.5"'
  echo "  ✓ Animations set to 0.5x"

  echo ""
  echo "Setting WiFi to stay alive during sleep..."
  run 'adb shell "settings put global wifi_sleep_policy 2"'
  echo "  ✓ WiFi sleep policy set to never"

  echo ""
fi

# ── Done ──

echo "=== Setup Complete ==="
echo ""
echo "Next steps:"
echo "  1. Restart Kodi for config changes to take effect"
echo "  2. If you haven't already, install The Crew and Mad Titan Sports through the Kodi UI"
echo "  3. Authorize Real Debrid in The Crew → Tools → RESOLVEURL: Settings"
echo "  4. Check for Ugoos firmware updates (Settings → OTA Update)"
echo ""
