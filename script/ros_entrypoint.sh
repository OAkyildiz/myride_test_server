#!/bin/bash
set -e

# setup ros environment
source "/ws_testserver/devel/setup.bash"
exec "$@"