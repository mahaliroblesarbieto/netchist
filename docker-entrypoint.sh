#!/bin/sh
set -e

# Detect Railway-provided $PORT, default to 8080
PORT_TO_USE=${PORT:-8080}

# Update Tomcat connector port if PORT is set
# This sed replaces the first occurrence of port="8080" in server.xml
sed -i "0,/<Connector port=\"[0-9]\+\"/s//<Connector port=\"${PORT_TO_USE}\"/" conf/server.xml || true

echo "Starting Tomcat on port ${PORT_TO_USE}"
exec "$@"
