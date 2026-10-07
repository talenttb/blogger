#!/usr/bin/env bash
# Cloudflare Workers 建置用：下載 Zola、抓 theme submodule、產生 public/
set -euo pipefail
ZOLA_VERSION=0.23.6

curl -sSfL "https://github.com/getzola/zola/releases/download/v${ZOLA_VERSION}/zola-v${ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz" | tar -xz
git submodule update --init --recursive
./zola build
