#!/bin/bash

# Modify taskAffinity if the env variable is present
if [ -n "$targetapp" ]; then
    echo "Updating taskAffinity to: $targetapp"
    sed -i "s/android:taskAffinity=\"[^\"]*\"/android:taskAffinity=\"$targetapp\"/g" app/src/main/AndroidManifest.xml
fi

# Build the project
gradle assembleDebug --no-daemon