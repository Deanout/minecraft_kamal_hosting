#!/bin/bash
while true; do
  # Listen on port 8080 and execute 'trigger_script.sh' upon connection
  nc -l 8080
        echo "Ping received, running script..."
        # Your script commands here
done