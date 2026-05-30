# Roguelike Dungeon — Godot 4 Portfolio Project

## 구조

```
roguelike/
├── scenes/
│   ├── maps/        # 던전 씬
│   ├── player/      # 플레이어 씬
│   ├── enemies/     # 적 씬
│   └── ui/          # HUD, 게임오버 씬
├── scripts/
│   ├── core/        # GameManager (Autoload)
│   ├── player/      # 플레이어 로직
│   ├── enemies/     # 적 AI
│   ├── maps/        # BSP 맵 생성기
│   └── ui/          # HUD
└── assets/
```

## 핵심 시스템

| 시스템 | 파일 | 설명 |
|--------|------|------|
| 맵 생성 | `scripts/maps/dungeon_generator.gd` | BSP 알고리즘으로 절차적 던전 생성 |
| 플레이어 | `scripts/player/player.gd` | 이동, 공격, 체력 관리 |
| 적 AI | `scripts/enemies/enemy_base.gd` | 추적, 공격 쿨다운 |
| 게임 상태 | `scripts/core/game_manager.gd` | 층수, 점수 관리 (Autoload) |
| HUD | `scripts/ui/hud.gd` | 체력바, 점수, 층수 표시 |

## 시작하기

1. Godot 4.2 이상 설치
2. 프로젝트 열기 (`project.godot`)
3. `project.godot`에 Autoload 등록: `GameManager` → `scripts/core/game_manager.gd`
4. 씬 파일 생성 후 스크립트 연결

## 다음 단계 (기능 추가 아이디어)

- [ ] 아이템 시스템 (체력 포션, 무기 업그레이드)
- [ ] 다양한 적 종류
- [ ] 보스 방
- [ ] 미니맵
- [ ] 세이브/로드
