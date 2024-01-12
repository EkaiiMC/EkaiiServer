#!/bin/bash

DELAY=5

while true; do
    # Start the Minecraft server in the background
    java -Xmx1G -Xmx64G --add-modules=jdk.incubator.vector -XX:+CrashOnOutOfMemoryError -XX:HeapDumpPath=logs/dump.log -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15 -XX:+CrashOnOutOfMemoryError -Dpaper.playerconnection.keepalive=999999 -jar ekaii.jar nogui

    # Get the PID of the server process
    SERVER_PID=$!

    # Wait for the server process to terminate
    wait $SERVER_PID

    # Log the exit code
    if [[ ! -d "exit_codes" ]]; then
        mkdir "exit_codes";
    fi
    if [[ ! -f "exit_codes/server_exit_codes.log" ]]; then
        touch "exit_codes/server_exit_codes.log";
    fi
    echo "[$(date +"%d.%m.%Y %T")] ExitCode: $?" >> "exit_codes/server_exit_codes.log"

    # Wait for the specified delay before restarting the server
    echo "------------------- SERVER STOPPED, WAITING $DELAY SECONDS BEFORE RESTARTING -------------------";
    sleep $DELAY
done
