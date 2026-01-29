#!/bin/bash
# Description: Records audio from the default microphone to a file.
set -euo pipefail

OUTPUT_FILE="${1:-input.wav}"

echo "🎤 Recording to $OUTPUT_FILE..."
echo "Press Ctrl+C to stop."

# Record indefinitely until interrupted
# -f cd: Quality (16 bit, 44.1kHz)
# -q: Quiet mode
arecord -f cd "$OUTPUT_FILE" 2>/dev/null || true

echo -e "\n✅ Recording saved to $OUTPUT_FILE"
