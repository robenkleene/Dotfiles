#!/usr/bin/env bash

set -euo pipefail

blacklist="
/Applications/Adobe After Effects 2022/Plug-ins/
/Applications/Adobe After Effects 2022/Presets/
/Applications/Adobe After Effects 2022/Scripts/
/Applications/Adobe Illustrator 2022/Cool Extras.localized/
/Applications/Adobe Illustrator 2022/Plug-ins.localized/
/Applications/Adobe Illustrator 2022/Presets.localized/
/Applications/Adobe Illustrator 2022/Scripting.localized/
/Applications/Adobe Illustrator 2022/Support Files/
/Applications/Adobe Photoshop 2022/Configuration/
/Applications/Adobe Photoshop 2022/Locales/
/Applications/Adobe Photoshop 2022/Plug-ins/
/Applications/Adobe Photoshop 2022/Presets/
/Applications/Houdini/Houdini19.0.589/Administrative Tools/
/Applications/Houdini/Houdini19.0.589/Frameworks/
/Applications/Maxon Cinema 4D R25/corelibs/
/Applications/Maxon Cinema 4D R25/Exchange Plugins/
/Applications/Maxon Cinema 4D R25/help/
/Applications/Maxon Cinema 4D R25/library/
/Applications/Maxon Cinema 4D R25/resource/
/Applications/Maxon Cinema 4D R26/corelibs/
/Applications/Maxon Cinema 4D R26/Exchange Plugins/
/Applications/Maxon Cinema 4D R26/help/
/Applications/Maxon Cinema 4D R26/library/
/Applications/Maxon Cinema 4D R26/plugins/
/Applications/Maxon Cinema 4D R26/Redshift/
/Applications/Maxon Cinema 4D R26/resource/
/Applications/Native Instruments/Reaktor 6/Library/
/Applications/Native Instruments/Reaktor 6/Documentation/
/Applications/Native Instruments/Maschine 2/Documentation/
/Applications/Native Instruments/Komplete Kontrol/Documentation/
/Applications/Native Instruments/Controller Editor/Template Support Files/
/Applications/Native Instruments/Controller Editor/Documentation/
/Applications/redshift/
/Applications/Utilities/Adobe Application Manager/
/Applications/Utilities/Adobe Creative Cloud/
/Applications/Utilities/Adobe Creative Cloud Experience/
/Applications/Utilities/Adobe Installers/
/Applications/Utilities/Adobe Sync/
/Users/robenkleene/Developer/
/Users/Shared/
"
raw=$(sudo /usr/libexec/PlistBuddy -c "Print :Exclusions" /System/Volumes/Data/.Spotlight-V100/VolumeConfiguration.plist | sed 's/^[ \t]*//;s/[ \t]*$//' || echo "Error: This terminal probably doesn't have full disk access" >&2)

current=""
while IFS= read -r line; do
  if [[ -d "$line" && $line != "Array {" && $line != "}" ]]; then
    current="${current}$line"
  fi
done <<< "$raw"

echo "current = $current"

exit 1

sudo /usr/libexec/PlistBuddy -c "Add :Exclusions:0 string '/path/to/folder'" /System/Volumes/Data/.Spotlight-V100/VolumeConfiguration.plist


sudo launchctl stop com.apple.metadata.mds
sudo launchctl start com.apple.metadata.mds
