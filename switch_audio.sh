#!/bin/bash

osascript <<EOF

set outputSources to {"Studio Display Speakers", "Scarlett Solo USB", "MacBook Pro Speakers"}
set inputSources to {"Scarlett Solo USB", "Studio Display Microphone", "MacBook Pro Microphone"}
set selectedOutput to ""
set selectedInput to ""

repeat with outputSource in outputSources
    try
        do shell script "/opt/homebrew/bin/SwitchAudioSource -t output -s " & quoted form of outputSource
        set selectedOutput to outputSource
        exit repeat
    on error
        -- If this source isn't available, the script will just try the next one.
    end try
end repeat

repeat with inputSource in inputSources
    try
        do shell script "/opt/homebrew/bin/SwitchAudioSource -t input -s " & quoted form of inputSource
        set selectedInput to inputSource
        exit repeat
    on error
        -- If this source isn't available, the script will just try the next one.
    end try
end repeat

return "🔊 " & selectedOutput & "\n🎤 " & selectedInput

EOF
