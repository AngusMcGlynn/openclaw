#!/bin/sh
set -e

# Setup state directory and config if using OPENCLAW_STATE_DIR
if [ -n "$OPENCLAW_STATE_DIR" ]; then
  CONFIG_FILE="$OPENCLAW_STATE_DIR/openclaw.json"
  WORKSPACE_DIR="$OPENCLAW_STATE_DIR/workspace"

  # Create workspace directory if it doesn't exist
  mkdir -p "$WORKSPACE_DIR"
  mkdir -p "$WORKSPACE_DIR/memory"

  # Copy bundled config if no config exists
  if [ ! -f "$CONFIG_FILE" ]; then
    if [ -f "/app/config/openclaw.json" ]; then
      cp /app/config/openclaw.json "$CONFIG_FILE"
      echo "Copied bundled config to $CONFIG_FILE"
    else
      echo '{"gateway":{"mode":"local","bind":"lan"}}' > "$CONFIG_FILE"
      echo "Created minimal config at $CONFIG_FILE"
    fi
  else
    echo "Using existing config at $CONFIG_FILE"
  fi

  # Copy bundled workspace files if they don't exist
  if [ -d "/app/config/workspace" ]; then
    for file in /app/config/workspace/*.md; do
      if [ -f "$file" ]; then
        filename=$(basename "$file")
        if [ ! -f "$WORKSPACE_DIR/$filename" ]; then
          cp "$file" "$WORKSPACE_DIR/$filename"
          echo "Copied $filename to workspace"
        fi
      fi
    done
  fi
fi

# Run the main command
exec "$@"
