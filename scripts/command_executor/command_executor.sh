#!/bin/bash

# Path to the flag file
FLAG_FILE="/var/lib/docker/volumes/data/_data/command_executor"
CONTAINER_NAME="deployer-game"
# FLAG_FILE="/test/flagfile.txt"

# Check if the flag file exists
if [ -f "$FLAG_FILE" ]; then
    # Read command from the file
    COMMAND=$(cat $FLAG_FILE)
    echo "$(date): Flag file found." >> /test/command_executor_service.log
    docker exec -i $CONTAINER_NAME rcon-cli $COMMAND
    echo "$(date): Ran the command '$COMMAND' in the $CONTAINER_NAME container." >> /test/command_executor_service.log
    # Attempt to remove the flag file
    rm -f "$FLAG_FILE"
    echo "$(date): Removed the flag file." >> /test/command_executor_service.log
else
    echo "$(date): Flag file not found." >> /test/command_executor_service.log
fi