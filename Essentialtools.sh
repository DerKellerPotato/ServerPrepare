#!/bin/bash

# Check for sudo privileges
if [ "$EUID" -ne 0 ]; then
    echo "This script requires superuser privileges. Please run it with sudo."
    exit 1
fi

# Update the package list to get the latest information about available packages
apt update

# Install necessary tools and packages
apt install -y nano       
apt install -y docker.io  
apt install -y curl       
apt install -y wget       
apt install -y git        


# Optionally, you can add more tools or packages here

# Display a message to indicate that the installation is complete
echo "
++++++++++++++++++++++++++++++++++++++++
All necessary tools have been installed.
++++++++++++++++++++++++++++++++++++++++
"

# Exit the script
exit 0
