#!/bin/bash
# WebGL 빌드 스크립트
# 사용법: ./build_web.sh

set -e

GODOT="${GODOT_BIN:-godot4}"
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="$PROJECT_DIR/build/web"

echo "=== Roguelike WebGL Build ==="
echo "Godot: $GODOT"
echo "Output: $BUILD_DIR"

mkdir -p "$BUILD_DIR"

# Web export 템플릿이 필요합니다
# 없으면: Godot 에디터 > Editor > Manage Export Templates > Download
"$GODOT" --headless --export-release "Web" "$BUILD_DIR/index.html" --path "$PROJECT_DIR"

echo ""
echo "=== 빌드 완료 ==="
echo "브라우저에서 열려면:"
echo "  cd $BUILD_DIR && python3 -m http.server 8080"
echo "  http://localhost:8080"
