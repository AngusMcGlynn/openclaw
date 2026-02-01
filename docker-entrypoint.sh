#!/bin/sh
set -e

# Create config file if using OPENCLAW_STATE_DIR
if [ -n "$OPENCLAW_STATE_DIR" ]; then
  CONFIG_FILE="$OPENCLAW_STATE_DIR/openclaw.json"
  if [ ! -f "$CONFIG_FILE" ]; then
    echo '{"gateway":{"mode":"local"}}' > "$CONFIG_FILE"
    echo "Created initial config at $CONFIG_FILE"
  fi
fi

# Run the main command
exec "$@"
