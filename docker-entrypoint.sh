#!/bin/sh
set -e

# Create config directory if using OPENCLAW_STATE_DIR
if [ -n "$OPENCLAW_STATE_DIR" ]; then
  mkdir -p "$OPENCLAW_STATE_DIR"

  CONFIG_FILE="$OPENCLAW_STATE_DIR/openclaw.json"
  if [ ! -f "$CONFIG_FILE" ]; then
    echo '{"gateway":{"mode":"local"}}' > "$CONFIG_FILE"
    echo "Created initial config at $CONFIG_FILE"
  fi
fi

# Run the main command
exec "$@"
