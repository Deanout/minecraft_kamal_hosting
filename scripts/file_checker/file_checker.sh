#!/bin/bash

# Path to the flag file
FLAG_FILE="/var/lib/docker/volumes/data/_data/pending_restart"
CONTAINER_NAME="deployer-game"
# FLAG_FILE="/test/flagfile.txt"

# Check if the flag file exists
if [ -f "$FLAG_FILE" ]; then
    echo "$(date): Flag file found." >> /test/file_checker_service.log
    docker restart $CONTAINER_NAME
    echo "$(date): Restarted the $CONTAINER_NAME container." >> /test/file_checker_service.log
    # Attempt to remove the flag file
    rm -f "$FLAG_FILE"
    echo "$(date): Removed the flag file." >> /test/file_checker_service.log
else
    echo "$(date): Flag file not found." >> /test/file_checker_service.log
fi