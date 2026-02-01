#!/bin/sh
set -e

# Create/update config file if using OPENCLAW_STATE_DIR
if [ -n "$OPENCLAW_STATE_DIR" ]; then
  CONFIG_FILE="$OPENCLAW_STATE_DIR/openclaw.json"
  # Always write the minimal required config for container deployment
  echo '{"gateway":{"mode":"local","bind":"lan"}}' > "$CONFIG_FILE"
  echo "Config ready at $CONFIG_FILE"
fi

# Run the main command
exec "$@"
