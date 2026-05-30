"use client";

import { useEffect, useRef, useState } from "react";

// Color palette
const C: Record<number, string> = {
  0: "transparent",
  1: "#FDBCB4", // skin
  2: "#3D2414", // hair
  3: "#4169E1", // shirt
  4: "#1C3A6E", // pants
  5: "#6B3A2A", // shoes
  6: "#1A0A00", // eyes / mouth
  7: "#FF6B8A", // mouth
};

// 16×16 pixel frames  (0 = transparent)
const FRAMES = [
  // Frame A — left leg forward
  [
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
  // Frame B — neutral
  [
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
  // Frame C — right leg forward
  [
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
  // Frame D — neutral (same as B, completes the cycle)
  [
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

const PX = 3;   // pixel size in px
const GRID = 16;
const WALK_SPEED = 1.5;   // px per tick
const FRAME_MS = 160;

export default function PixelCharacter() {
  const [frame, setFrame] = useState(0);
  const posX = useRef(0);
  const dir = useRef(1);
  const [displayX, setDisplayX] = useState(0);
  const containerRef = useRef<HTMLDivElement>(null);
  const maxX = useRef(200);

  useEffect(() => {
    const el = containerRef.current?.parentElement;
    if (el) maxX.current = el.clientWidth - GRID * PX - 16;
  }, []);

  useEffect(() => {
    const id = setInterval(() => {
      posX.current += WALK_SPEED * dir.current;
      if (posX.current >= maxX.current) { posX.current = maxX.current; dir.current = -1; }
      if (posX.current <= 0) { posX.current = 0; dir.current = 1; }
      setDisplayX(posX.current);
      setFrame(f => (f + 1) % FRAMES.length);
    }, FRAME_MS);
    return () => clearInterval(id);
  }, []);

  const pixels = FRAMES[frame];

  return (
    <div
      ref={containerRef}
      style={{
        transform: `translateX(${displayX}px) scaleX(${dir.current})`,
        transformOrigin: "left top",
        display: "inline-block",
        imageRendering: "pixelated",
      }}
    >
      <div
        style={{
          display: "grid",
          gridTemplateColumns: `repeat(${GRID}, ${PX}px)`,
          gridTemplateRows: `repeat(${GRID}, ${PX}px)`,
        }}
      >
        {pixels.flatMap((row, y) =>
          row.map((v, x) => (
            <div
              key={`${y}-${x}`}
              style={{ width: PX, height: PX, backgroundColor: C[v] }}
            />
          ))
        )}
      </div>
    </div>
  );
}
