"use client";

import { useEffect, useRef, useState } from "react";

/* ─── Palette ───────────────────────────────────────────── */
const HERO_C: Record<number, string> = {
  0: "transparent", 1: "#FDBCB4", 2: "#3D2414",
  3: "#4169E1", 4: "#1C3A6E", 5: "#6B3A2A",
  6: "#1A0A00", 7: "#FF6B8A",
};

const SLIME_C: Record<number, string> = {
  0: "transparent", 1: "#4ADE80", 2: "#16A34A",
  3: "#1A0A00", 4: "#86EFAC",
};

const BAT_C: Record<number, string> = {
  0: "transparent", 1: "#7C3AED", 2: "#4C1D95",
  3: "#1A0A00", 4: "#DDD6FE",
};

/* ─── Hero frames (16×16) ──────────────────────────────── */
const HERO_FRAMES = [
  [ // Frame A — left leg forward
    [0,0,0,0,0,2,2,2,2,2,0,0,0,0,0,0],
    [0,0,0,0,2,2,2,2,2,2,2,0,0,0,0,0],
    [0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0],
    [0,0,0,0,1,6,1,1,1,6,1,0,0,0,0,0],
    [0,0,0,0,1,1,1,7,1,1,1,0,0,0,0,0],
    [0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0],
    [0,1,1,3,3,3,3,3,3,3,3,1,1,0,0,0],
    [0,0,1,3,3,3,3,3,3,3,3,1,0,0,0,0],
    [0,0,0,3,3,3,3,3,3,3,3,0,0,0,0,0],
    [0,0,0,3,3,3,3,3,3,3,3,0,0,0,0,0],
    [0,0,0,4,4,4,0,0,4,4,4,0,0,0,0,0],
    [0,0,0,4,4,4,0,0,4,4,4,0,0,0,0,0],
    [0,0,4,4,4,0,0,0,0,4,4,0,0,0,0,0],
    [0,0,5,5,5,0,0,0,0,0,5,5,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  ],
  [ // Frame B — neutral
    [0,0,0,0,0,2,2,2,2,2,0,0,0,0,0,0],
    [0,0,0,0,2,2,2,2,2,2,2,0,0,0,0,0],
    [0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0],
    [0,0,0,0,1,6,1,1,1,6,1,0,0,0,0,0],
    [0,0,0,0,1,1,1,7,1,1,1,0,0,0,0,0],
    [0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0],
    [0,0,1,3,3,3,3,3,3,3,3,1,0,0,0,0],
    [0,0,1,3,3,3,3,3,3,3,3,1,0,0,0,0],
    [0,0,0,3,3,3,3,3,3,3,3,0,0,0,0,0],
    [0,0,0,3,3,3,3,3,3,3,3,0,0,0,0,0],
    [0,0,0,4,4,4,0,0,4,4,4,0,0,0,0,0],
    [0,0,0,4,4,4,0,0,4,4,4,0,0,0,0,0],
    [0,0,0,4,4,4,0,0,4,4,4,0,0,0,0,0],
    [0,0,0,5,5,5,0,0,5,5,5,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  ],
  [ // Frame C — right leg forward
    [0,0,0,0,0,2,2,2,2,2,0,0,0,0,0,0],
    [0,0,0,0,2,2,2,2,2,2,2,0,0,0,0,0],
    [0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0],
    [0,0,0,0,1,6,1,1,1,6,1,0,0,0,0,0],
    [0,0,0,0,1,1,1,7,1,1,1,0,0,0,0,0],
    [0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0],
    [0,0,0,1,3,3,3,3,3,3,1,1,1,0,0,0],
    [0,0,0,1,3,3,3,3,3,3,3,1,0,0,0,0],
    [0,0,0,3,3,3,3,3,3,3,3,0,0,0,0,0],
    [0,0,0,3,3,3,3,3,3,3,3,0,0,0,0,0],
    [0,0,0,4,4,4,0,0,4,4,4,0,0,0,0,0],
    [0,0,0,4,4,4,0,0,4,4,4,0,0,0,0,0],
    [0,0,0,4,4,0,0,0,0,4,4,4,0,0,0,0],
    [0,0,0,5,5,0,0,0,0,0,5,5,5,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  ],
  [ // Frame D — neutral (mirror of B)
    [0,0,0,0,0,2,2,2,2,2,0,0,0,0,0,0],
    [0,0,0,0,2,2,2,2,2,2,2,0,0,0,0,0],
    [0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0],
    [0,0,0,0,1,6,1,1,1,6,1,0,0,0,0,0],
    [0,0,0,0,1,1,1,7,1,1,1,0,0,0,0,0],
    [0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0],
    [0,0,1,3,3,3,3,3,3,3,3,1,0,0,0,0],
    [0,0,1,3,3,3,3,3,3,3,3,1,0,0,0,0],
    [0,0,0,3,3,3,3,3,3,3,3,0,0,0,0,0],
    [0,0,0,3,3,3,3,3,3,3,3,0,0,0,0,0],
    [0,0,0,4,4,4,0,0,4,4,4,0,0,0,0,0],
    [0,0,0,4,4,4,0,0,4,4,4,0,0,0,0,0],
    [0,0,0,4,4,4,0,0,4,4,4,0,0,0,0,0],
    [0,0,0,5,5,5,0,0,5,5,5,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  ],
];

/* ─── Slime frames (12×10) ─────────────────────────────── */
const SLIME_FRAMES = [
  [ // squished
    [0,0,1,1,1,1,1,1,1,1,0,0],
    [0,1,1,4,1,1,1,1,4,1,1,0],
    [1,1,1,4,1,1,1,1,4,1,1,1],
    [1,1,1,1,1,3,3,1,1,1,1,1],
    [1,1,2,1,1,1,1,1,1,2,1,1],
    [1,1,2,1,1,1,1,1,1,2,1,1],
    [0,1,1,1,1,1,1,1,1,1,1,0],
    [0,0,1,1,1,1,1,1,1,1,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0],
  ],
  [ // tall
    [0,0,0,1,1,1,1,1,1,0,0,0],
    [0,0,1,1,1,1,1,1,1,1,0,0],
    [0,1,1,1,4,1,1,4,1,1,1,0],
    [0,1,1,1,4,1,1,4,1,1,1,0],
    [0,1,1,1,1,3,3,1,1,1,1,0],
    [0,1,1,2,1,1,1,1,2,1,1,0],
    [0,1,1,2,1,1,1,1,2,1,1,0],
    [0,0,1,1,1,1,1,1,1,1,0,0],
    [0,0,0,1,1,1,1,1,1,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0],
  ],
];

/* ─── Bat frames (14×10) ──────────────────────────────── */
const BAT_FRAMES = [
  [ // wings up
    [1,1,0,0,0,0,0,0,0,0,1,1,0,0],
    [1,1,1,0,0,0,0,0,0,1,1,1,0,0],
    [1,1,4,1,0,2,2,2,0,1,4,1,1,0],
    [1,1,4,1,2,2,3,2,2,1,4,1,1,0],
    [0,1,1,1,2,3,3,3,2,1,1,1,0,0],
    [0,0,1,1,1,2,2,2,1,1,1,0,0,0],
    [0,0,0,0,1,1,1,1,1,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  ],
  [ // wings down
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,2,2,2,0,0,0,0,0,0],
    [0,0,0,0,2,2,3,2,2,0,0,0,0,0],
    [0,1,1,0,2,3,3,3,2,0,1,1,0,0],
    [1,1,4,1,1,2,2,2,1,1,4,1,1,0],
    [1,1,4,1,0,1,1,1,0,1,4,1,1,0],
    [1,1,1,1,0,0,0,0,0,1,1,1,1,0],
    [1,1,0,0,0,0,0,0,0,0,0,1,1,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  ],
];

/* ─── Pixel grid renderer ───────────────────────────────── */
function PixelGrid({
  pixels,
  palette,
  px,
  cols,
}: {
  pixels: number[][];
  palette: Record<number, string>;
  px: number;
  cols: number;
}) {
  return (
    <div
      style={{
        display: "grid",
        gridTemplateColumns: `repeat(${cols}, ${px}px)`,
        imageRendering: "pixelated",
      }}
    >
      {pixels.flatMap((row, y) =>
        row.map((v, x) => (
          <div
            key={`${y}-${x}`}
            style={{ width: px, height: px, backgroundColor: palette[v] ?? "transparent" }}
          />
        ))
      )}
    </div>
  );
}

/* ─── Individual sprite hooks ───────────────────────────── */
function useWalker(
  containerWidth: number,
  spriteWidth: number,
  speed: number,
  startX: number,
  startDir: number,
) {
  const posX = useRef(startX);
  const dir = useRef(startDir);
  const [state, setState] = useState({ x: startX, dir: startDir, frame: 0 });

  useEffect(() => {
    const id = setInterval(() => {
      posX.current += speed * dir.current;
      const max = containerWidth - spriteWidth;
      if (posX.current >= max) { posX.current = max; dir.current = -1; }
      if (posX.current <= 0) { posX.current = 0; dir.current = 1; }
      setState(s => ({ x: posX.current, dir: dir.current, frame: (s.frame + 1) % 4 }));
    }, 160);
    return () => clearInterval(id);
  }, [containerWidth, spriteWidth, speed]);

  return state;
}

function useBouncer(startX: number, amplitude: number) {
  const [state, setState] = useState({ x: startX, y: 0, frame: 0 });
  const tick = useRef(0);

  useEffect(() => {
    const id = setInterval(() => {
      tick.current += 1;
      const y = Math.round(Math.sin(tick.current * 0.4) * amplitude);
      setState(s => ({ x: startX, y, frame: s.frame === 0 ? 1 : 0 }));
    }, 180);
    return () => clearInterval(id);
  }, [startX, amplitude]);

  return state;
}

/* ─── Main scene ────────────────────────────────────────── */
const SCENE_H = 120;
const GROUND_Y = 82; // ground line from top (in px)

export default function PixelWorld() {
  const containerRef = useRef<HTMLDivElement>(null);
  const [width, setWidth] = useState(600);

  useEffect(() => {
    const el = containerRef.current;
    if (!el) return;
    const ro = new ResizeObserver(([e]) => setWidth(e.contentRect.width));
    ro.observe(el);
    setWidth(el.clientWidth);
    return () => ro.disconnect();
  }, []);

  const PX = 3;
  const HERO_W = 16 * PX;  // 48px
  const SLIME_W = 12 * PX; // 36px
  const BAT_W = 14 * PX;   // 42px

  const hero = useWalker(width, HERO_W, 1.8, 20, 1);
  const slime = useBouncer(Math.floor(width * 0.55), 4);
  const bat = useBouncer(Math.floor(width * 0.75), 6);

  const heroFrameIdx = hero.frame % HERO_FRAMES.length;
  const slimeFrameIdx = slime.frame % SLIME_FRAMES.length;
  const batFrameIdx = bat.frame % BAT_FRAMES.length;

  return (
    <div
      ref={containerRef}
      className="relative w-full overflow-hidden rounded-xl border border-gray-800 bg-gray-950"
      style={{ height: SCENE_H }}
    >
      {/* Stars */}
      {[14, 28, 45, 62, 78, 90, 105, 120, 135, 150].map((x, i) => (
        <div
          key={i}
          className="absolute rounded-full bg-white opacity-60"
          style={{ left: `${x * (width / 160)}px`, top: `${[6,12,5,14,8,11,4,9,13,7][i]}px`, width: 2, height: 2 }}
        />
      ))}

      {/* Ground */}
      <div
        className="absolute left-0 right-0 bg-gray-800"
        style={{ top: GROUND_Y, height: 2 }}
      />
      <div
        className="absolute left-0 right-0 bg-gray-900"
        style={{ top: GROUND_Y + 2, height: SCENE_H - GROUND_Y - 2 }}
      />

      {/* Slime — sits on ground */}
      <div
        className="absolute"
        style={{
          left: slime.x,
          top: GROUND_Y - 10 * PX + slime.y,
          imageRendering: "pixelated",
        }}
      >
        <PixelGrid pixels={SLIME_FRAMES[slimeFrameIdx]} palette={SLIME_C} px={PX} cols={12} />
      </div>

      {/* Second slime — opposite side */}
      <div
        className="absolute"
        style={{
          left: Math.floor(width * 0.25),
          top: GROUND_Y - 10 * PX + (slime.y > 0 ? -slime.y : slime.y),
          imageRendering: "pixelated",
          transform: "scaleX(-1)",
        }}
      >
        <PixelGrid pixels={SLIME_FRAMES[(slimeFrameIdx + 1) % 2]} palette={SLIME_C} px={PX} cols={12} />
      </div>

      {/* Bat — floats above ground */}
      <div
        className="absolute"
        style={{
          left: bat.x,
          top: GROUND_Y - 52 + bat.y,
          imageRendering: "pixelated",
        }}
      >
        <PixelGrid pixels={BAT_FRAMES[batFrameIdx]} palette={BAT_C} px={PX} cols={14} />
      </div>

      {/* Hero — walks along ground */}
      <div
        className="absolute"
        style={{
          left: hero.x,
          top: GROUND_Y - 16 * PX + 2,
          imageRendering: "pixelated",
          transform: `scaleX(${hero.dir})`,
          transformOrigin: "left top",
        }}
      >
        <PixelGrid pixels={HERO_FRAMES[heroFrameIdx]} palette={HERO_C} px={PX} cols={16} />
      </div>

      {/* Label */}
      <div className="absolute bottom-2 right-3 text-gray-700 text-xs font-mono select-none">
        pixel world
      </div>
    </div>
  );
}
