#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
ENV_FILE="$ROOT/.env"
VENV="$ROOT/.venv"
LOG_DIR="$ROOT/logs"

if [ ! -f "$ENV_FILE" ]; then
    echo "Missing .env. Copy .env.example to .env first."
    exit 1
fi

if [ ! -d "$VENV" ]; then
    echo "Missing virtualenv. Run ./setup.sh first."
    exit 1
fi

set -a
source "$ENV_FILE"
set +a

mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/$(date +%Y%m%d_%H%M%S)_server.log"

source "$VENV/bin/activate"

echo "Starting vLLM server..."
echo "  Model:   $MODEL_ID"
echo "  Address: http://$HOST:$PORT/v1"
echo "  DType:   $DTYPE"
echo "  Log:     $LOG_FILE"
echo ""

exec vllm serve "$MODEL_ID" \
    --host "$HOST" \
    --port "$PORT" \
    --mamba-cache-dtype "$MAMBA_CACHE_DTYPE" \
    --dtype "$DTYPE" \
    --reasoning-parser qwen3 \
    --enable-auto-tool-choice \
    --tool-call-parser zaya_xml \
    ${EXTRA_ARGS:-} \
    2>&1 | tee "$LOG_FILE"
