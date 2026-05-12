#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
VENV="$ROOT/.venv"

if [ ! -d "$VENV" ]; then
    python3 -m venv "$VENV"
fi

source "$VENV/bin/activate"

export TORCH_CUDA_ARCH_LIST="${TORCH_CUDA_ARCH_LIST:-12.0+PTX}"
export CMAKE_CUDA_ARCHITECTURES="${CMAKE_CUDA_ARCHITECTURES:-120}"

python -m pip install --upgrade pip
python -m pip install "vllm @ git+https://github.com/Zyphra/vllm.git@zaya1"
python -m pip install "transformers @ git+https://github.com/Zyphra/transformers.git@zaya1"

echo ""
echo "Setup complete: $VENV"
echo "TORCH_CUDA_ARCH_LIST=$TORCH_CUDA_ARCH_LIST"
echo "CMAKE_CUDA_ARCHITECTURES=$CMAKE_CUDA_ARCHITECTURES"
echo "Run ./start.sh to launch the server."
