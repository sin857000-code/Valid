#!/bin/bash
# 빌드 후 gh-pages에 자동 배포 (worktree 방식)
set -e
PROJ="/home/user/Valid/roguelike"
REPO="/home/user/Valid"
GODOT="${GODOT_BIN:-godot4}"
GH_PAGES_DIR="/tmp/gh-pages-deploy"

echo "=== WebGL 빌드 ==="
mkdir -p "$PROJ/build/web"
cd "$PROJ"
# 변경사항 임시 저장
git -C "$REPO" stash --include-untracked -q 2>/dev/null || true
$GODOT --headless --export-release "Web" "$PROJ/build/web/index.html" 2>&1 | grep -E "savepack: end|SCRIPT ERROR" || true
git -C "$REPO" stash pop -q 2>/dev/null || true

echo "=== gh-pages 배포 ==="
# worktree로 브랜치 충돌 없이 배포
rm -rf "$GH_PAGES_DIR"
git -C "$REPO" worktree add "$GH_PAGES_DIR" gh-pages 2>/dev/null || true

for f in index.html index.js index.pck index.wasm index.worker.js index.audio.worklet.js; do
  cp "$PROJ/build/web/$f" "$GH_PAGES_DIR/$f" 2>/dev/null || true
done

grep -q "coi-serviceworker" "$GH_PAGES_DIR/index.html" || \
  sed -i 's|<meta name="viewport"|<script src="coi-serviceworker.js"></script>\n\t\t<meta name="viewport"|' "$GH_PAGES_DIR/index.html"

SCORE=$(python3 -c "import json; d=json.load(open('$PROJ/dev/report.json')); print(d['score'])" 2>/dev/null || echo "?")
cd "$GH_PAGES_DIR"
git add index.html index.js index.pck index.wasm index.worker.js index.audio.worklet.js 2>/dev/null || true
git diff --cached --quiet || git commit -m "Auto deploy - score: $SCORE"
git push origin gh-pages

git -C "$REPO" worktree remove "$GH_PAGES_DIR" --force 2>/dev/null || true
echo "=== 배포 완료 (score: $SCORE) ==="
