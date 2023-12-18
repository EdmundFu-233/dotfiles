#!/bin/bash
# Docker cleanup script
echo "Cleaning up Docker resources..."

# Remove stopped containers
docker container prune -f

# Remove unused images
docker image prune -a -f

# Remove unused volumes
docker volume prune -f

# Remove unused networks
docker network prune -f

# Show disk usage
docker system df

echo "Docker cleanup complete!"
