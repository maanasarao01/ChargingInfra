#!/bin/bash

# Pull the latest images for services
docker-compose pull

# Builds the Docker images
docker-compose build

# Start the Docker containers
docker-compose up -d

# Display Docker container status
docker-compose ps

payload_file="payload.json"

#read the contents of file
documents=$(jq -c '.[]' "$payload_file")

# Display the contents of the file
echo "$documents"

#sends a post request to post all the documents in payload.json
 echo "$documents" | while IFS= read -r document; do
    echo "$document"
    sleep 2
    curl -X POST -H "Content-Type: application/json" -d "$document" http://localhost:3003/charging-stations/connectors
done

#get Connectors for a given location
curl "http://localhost:3003/charging-stations/connectors/Girinagar/DC%20Fast%20Charging"


docker compose down
