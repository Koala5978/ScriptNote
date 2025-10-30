#!/bin/bash
#Refence : https://www.wikigain.com/create-macos-big-sur-iso-image/
#Donwload macOS app cmd : softwareupdate --fetch-full-installer --full-installer-version 26.0

# v11.x.x
#MAC_VERSION_NAME="Big\ Sur" 

# v12.x.x
#MAC_VERSION_NAME="Monterey"

# v13.x.x
#MAC_VERSION_NAME="Ventura"

# v14.x.x
#MAC_VERSION_NAME="Sonoma"

# v15.x.x
#MAC_VERSION_NAME="Sequoia"

# v26.x.x
MAC_VERSION_NAME="Tahoe"

# dmg size:
#   before v15.2
#     16GB 16384MB 
#   after v15.2
#     18GB 18432MB
DMG_SIZE="18432m"

#Step.1
echo "Run the 1st step:"
sudo hdiutil create -o /tmp/${MAC_VERSION_NAME} -size ${DMG_SIZE} -volname ${MAC_VERSION_NAME} -layout SPUD -fs HFS+J

#Step.2
echo "Run the 2nd step:"
sudo hdiutil attach /tmp/${MAC_VERSION_NAME}.dmg -noverify -mountpoint /Volumes/${MAC_VERSION_NAME} 

#Step.3
echo "Run the 3rd step:"
sudo /Applications/Install\ macOS\ ${MAC_VERSION_NAME}.app/Contents/Resources/createinstallmedia --volume /Volumes/${MAC_VERSION_NAME} --nointeraction

#Step.4
echo "Run the 4th step:"
hdiutil eject -force /Volumes/Install\ macOS\ ${MAC_VERSION_NAME} 

#Step.5
echo "Run the 5th step:"
hdiutil convert /tmp/${MAC_VERSION_NAME}.dmg -format UDTO -o ~/Desktop/${MAC_VERSION_NAME} 
mv -v ~/Desktop/${MAC_VERSION_NAME}.cdr ~/Desktop/${MAC_VERSION_NAME}.iso
sudo rm -fv /tmp/${MAC_VERSION_NAME}.dmg 

echo "Done!!"
