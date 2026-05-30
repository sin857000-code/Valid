#!/bin/bash
# 빌드 후 gh-pages에 자동 배포
set -e
PROJ="/home/user/Valid/roguelike"
REPO="/home/user/Valid"
GODOT="${GODOT_BIN:-godot4}"

echo "=== WebGL 빌드 ==="
mkdir -p "$PROJ/build/web"
$GODOT --headless --export-release "Web" "$PROJ/build/web/index.html" --path "$PROJ" 2>&1 | grep -E "savepack: end|SCRIPT ERROR" || true

echo "=== gh-pages 배포 ==="
cd "$REPO"
CURRENT=$(git branch --show-current)
git checkout gh-pages

for f in index.html index.js index.pck index.wasm index.worker.js index.audio.worklet.js; do
  cp "$PROJ/build/web/$f" "$REPO/$f" 2>/dev/null || true
done

grep -q "coi-serviceworker" index.html || \
  sed -i 's|<meta name="viewport"|<script src="coi-serviceworker.js"></script>\n\t\t<meta name="viewport"|' index.html

SCORE=$(python3 -c "import json; d=json.load(open('$PROJ/dev/report.json')); print(d['score'])" 2>/dev/null || echo "?")
git add index.html index.js index.pck index.wasm index.worker.js index.audio.worklet.js 2>/dev/null || true
git diff --cached --quiet || git commit -m "Auto deploy - score: $SCORE"
git push origin gh-pages

git checkout "$CURRENT"
echo "=== 배포 완료 ==="
