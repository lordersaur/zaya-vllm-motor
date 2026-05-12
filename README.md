# zaya-vllm-motor

Minimal vLLM-based backend scaffold for serving `Zyphra/ZAYA1-8B`.

This intentionally does not reuse the Gemma/llama.cpp motor, because ZAYA1-8B
is documented to work through Zyphra's `vllm` and `transformers` forks instead.

## Files

- `.env.example` example runtime configuration
- `setup.sh` create a virtualenv and install the required forks
- `start.sh` launch an OpenAI-compatible vLLM server

## Quick start

1. Copy `.env.example` to `.env`
2. Adjust values as needed
3. Run:

```bash
./setup.sh
./start.sh
```

## API

When the server is running it exposes an OpenAI-compatible endpoint at:

```text
http://HOST:PORT/v1
```

Health/model behavior depends on the installed `vllm` version and Zyphra model
support.

## Notes

- This scaffold follows the model card guidance for `Zyphra/ZAYA1-8B`.
- `setup.sh` installs Zyphra's `zaya1` branches of `vllm` and `transformers`.
- `start.sh` uses the model card's `reasoning-parser` and `tool-call-parser`
  flags.
