#!/bin/bash
# 게임 품질 자동 테스트 스크립트
# 출력: dev/report.json

set -e
PROJ="/home/user/Valid/roguelike"
REPORT="$PROJ/dev/report.json"
BUILD_DIR="$PROJ/build/web"
GODOT="${GODOT_BIN:-godot4}"

echo "=== 게임 테스트 시작 ==="

# ---- 1. 스크립트 오류 체크 ----
BUILD_LOG=$($GODOT --headless --export-release "Web" "$BUILD_DIR/index.html" --path "$PROJ" 2>&1 || true)
SCRIPT_ERRORS=$(echo "$BUILD_LOG" | grep -c "SCRIPT ERROR" || true)
BUILD_OK=$(echo "$BUILD_LOG" | grep -c "savepack: end" || true)

# ---- 2. 코드 메트릭 ----
TOTAL_LINES=$(find "$PROJ/scripts" -name "*.gd" | xargs wc -l 2>/dev/null | tail -1 | awk '{print $1}')
SCRIPT_COUNT=$(find "$PROJ/scripts" -name "*.gd" | wc -l)
SCENE_COUNT=$(find "$PROJ/scenes" -name "*.tscn" | wc -l)
TODO_COUNT=$(grep -r "TODO\|FIXME\|HACK" "$PROJ/scripts" 2>/dev/null | wc -l || true)

# ---- 3. 기능 체크리스트 ----
HAS_FOG=$(grep -l "fog_of_war" "$PROJ/scripts/maps/dungeon.gd" 2>/dev/null | wc -l)
HAS_BOSS=$([ -f "$PROJ/scripts/enemies/enemy_boss.gd" ] && echo 1 || echo 0)
HAS_RANGED=$([ -f "$PROJ/scripts/enemies/enemy_ranged.gd" ] && echo 1 || echo 0)
HAS_DASH=$(grep -c "_is_dashing" "$PROJ/scripts/player/player.gd" 2>/dev/null || true)
HAS_SAVE=$(grep -c "FileAccess" "$PROJ/scripts/core/game_manager.gd" 2>/dev/null || true)
HAS_MINIMAP=$([ -f "$PROJ/scripts/ui/minimap.gd" ] && echo 1 || echo 0)
HAS_PARTICLE=$([ -f "$PROJ/scripts/ui/hit_particle.gd" ] && echo 1 || echo 0)
HAS_TRANSITION=$([ -f "$PROJ/scripts/ui/floor_transition.gd" ] && echo 1 || echo 0)
HAS_WEAPONS=$(find "$PROJ/scripts/items" -name "weapon_*.gd" | wc -l)
HAS_ITEMS=$(find "$PROJ/scripts/items" -name "item_*.gd" | wc -l)
ENEMY_TYPES=$(find "$PROJ/scripts/enemies" -name "enemy_*.gd" | wc -l)

# ---- 4. 누락/개선 가능 항목 탐지 ----
MISSING=()
[ "$HAS_FOG" = "0" ]        && MISSING+=("fog_of_war")
[ "$HAS_BOSS" = "0" ]       && MISSING+=("boss")
[ "$HAS_RANGED" = "0" ]     && MISSING+=("ranged_enemy")
[ "$HAS_DASH" = "0" ]       && MISSING+=("dash")
[ "$HAS_SAVE" = "0" ]       && MISSING+=("save_load")
[ "$HAS_MINIMAP" = "0" ]    && MISSING+=("minimap")
[ "$HAS_PARTICLE" = "0" ]   && MISSING+=("particles")
[ "$HAS_TRANSITION" = "0" ] && MISSING+=("floor_transition")
[ "$HAS_WEAPONS" -lt 3 ]    && MISSING+=("more_weapons")
[ "$HAS_ITEMS" -lt 3 ]      && MISSING+=("more_items")
[ "$ENEMY_TYPES" -lt 4 ]    && MISSING+=("more_enemy_types")
grep -rq "sound\|AudioStream" "$PROJ/scripts" 2>/dev/null || MISSING+=("sound_effects")
grep -rq "save_screenshot\|screenshot\|HighScore\|best_score" "$PROJ/scripts" 2>/dev/null || MISSING+=("high_score")
[ -f "$PROJ/scripts/enemies/enemy_exploder.gd" ] || MISSING+=("exploder_enemy")
[ -f "$PROJ/scripts/items/item_shield.gd" ] || MISSING+=("shield_item")
grep -rq "StatusEffect\|poison\|stun\|slow" "$PROJ/scripts" 2>/dev/null || MISSING+=("status_effects")

MISSING_JSON=$(printf '"%s",' "${MISSING[@]}" | sed 's/,$//')

# ---- 5. 점수 계산 ----
FEATURE_SCORE=$(( (HAS_FOG + HAS_BOSS + HAS_RANGED + (HAS_DASH > 0 ? 1 : 0) + HAS_SAVE + HAS_MINIMAP + HAS_PARTICLE + HAS_TRANSITION) * 10 + HAS_WEAPONS * 5 + HAS_ITEMS * 5 + ENEMY_TYPES * 8 ))

cat > "$REPORT" <<EOF
{
  "timestamp": "$(date -Iseconds)",
  "build": {
    "success": $BUILD_OK,
    "script_errors": $SCRIPT_ERRORS
  },
  "metrics": {
    "total_lines": $TOTAL_LINES,
    "script_count": $SCRIPT_COUNT,
    "scene_count": $SCENE_COUNT,
    "todo_count": $TODO_COUNT,
    "enemy_types": $ENEMY_TYPES,
    "weapon_count": $HAS_WEAPONS,
    "item_count": $HAS_ITEMS
  },
  "features": {
    "fog_of_war": $HAS_FOG,
    "boss": $HAS_BOSS,
    "ranged_enemy": $HAS_RANGED,
    "dash": $([ "$HAS_DASH" -gt 0 ] && echo 1 || echo 0),
    "save_load": $([ "$HAS_SAVE" -gt 0 ] && echo 1 || echo 0),
    "minimap": $HAS_MINIMAP,
    "particles": $HAS_PARTICLE,
    "floor_transition": $HAS_TRANSITION
  },
  "missing": [$MISSING_JSON],
  "score": $FEATURE_SCORE
}
EOF

echo ""
echo "=== 결과 ==="
echo "빌드 성공: $BUILD_OK | 스크립트 오류: $SCRIPT_ERRORS"
echo "총 코드: ${TOTAL_LINES}줄 | 스크립트: ${SCRIPT_COUNT}개"
echo "누락 기능: ${#MISSING[@]}개 → ${MISSING[*]}"
echo "품질 점수: $FEATURE_SCORE"
echo "리포트: $REPORT"
