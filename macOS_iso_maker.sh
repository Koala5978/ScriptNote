#!/bin/bash 
MAC_VERSION_NAME="Tahoe"
APP_PATH="/Applications/Install macOS ${MAC_VERSION_NAME}.app"

if [ ! -d "$APP_PATH" ]; then
    echo "Error: Cannot find the installer at $APP_PATH"
    exit 1
fi

echo "Calculating required disk space..."
APP_SIZE_KIB=$(du -sk "$APP_PATH" | awk '{print $1}')
# Increase buffer to 20% to be safe for Tahoe
RAW_SIZE_KIB=$(echo "$APP_SIZE_KIB * 1.20 / 1" | bc)
DMG_SIZE="${RAW_SIZE_KIB}k"

echo "Installer size: $((APP_SIZE_KIB / 1024)) MiB"
echo "Target DMG size: $((RAW_SIZE_KIB / 1024)) MiB (${DMG_SIZE})"

# Step 1: CHANGED -layout to GPTSPUD for GUID Partition Map support
echo "Step 1: Creating empty disk image (GUID Partition Map)..."
sudo hdiutil create -o /tmp/${MAC_VERSION_NAME} -size ${DMG_SIZE} -volname ${MAC_VERSION_NAME} -layout GPTSPUD -fs HFS+

# Step 2: Attach
echo "Step 2: Attaching the disk image..."
sudo hdiutil attach /tmp/${MAC_VERSION_NAME}.dmg -noverify -mountpoint /Volumes/${MAC_VERSION_NAME}

# Step 3: Run createinstallmedia
echo "Step 3: Running createinstallmedia..."
sudo "$APP_PATH/Contents/Resources/createinstallmedia" --volume /Volumes/${MAC_VERSION_NAME} --nointeraction

# Step 4: Eject
# Note: The disk label usually becomes "Install macOS [Name]"
echo "Step 4: Ejecting the volume..."
hdiutil eject -force /Volumes/Install\ macOS\ ${MAC_VERSION_NAME}

# Step 5: Convert
echo "Step 5: Converting DMG to ISO..."
hdiutil convert /tmp/${MAC_VERSION_NAME}.dmg -format UDTO -o ~/Desktop/${MAC_VERSION_NAME}
mv -v ~/Desktop/${MAC_VERSION_NAME}.cdr ~/Desktop/${MAC_VERSION_NAME}.iso

echo "Cleaning up..."
sudo rm -fv /tmp/${MAC_VERSION_NAME}.dmg

echo "Done!!"
