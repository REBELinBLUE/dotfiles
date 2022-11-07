#!/bin/zsh

typeset PID=$(ps -fe | grep "[A]ndroid File Transfer Agent" | awk '{print $2}')

if [[ -n ${PID} ]]; then
    kill ${PID}
fi

for AFT in                              \
    "/Applications/Android File Transfer.app"               \
    "/Applications/Sync/Android File Transfer.app"          \
    "${HOME}/Library/Application Support/Google/Android File Transfer"
do
    echo "### Look for agents in “${AFT}”"

    if test -e "${AFT}"; then
    for AFTA in                         \
        "${AFT}/Contents/Resources/Android File Transfer Agent.app" \
        "${AFT}/Contents/Helpers/Android File Transfer Agent.app" \
        "${AFT}/Android File Transfer Agent.app"
    do
        echo "# Look for agent “${AFTA}”"

        if test -e "${AFTA}"; then
        mv -v "${AFTA}" "${AFTA}.DISABLE"
        fi
    done; unset AFTA
    fi
done; unset AFT

osascript -e 'tell application "System Events" to delete every login item whose name is "Android File Transfer Agent"'