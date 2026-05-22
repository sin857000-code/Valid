"use client";

import { useState } from "react";
import { testItems, type TestStatus } from "@/data/status";

const STATUS_CONFIG: Record<TestStatus, { label: string; color: string; dot: string }> = {
  완료: { label: "완료", color: "text-emerald-400", dot: "bg-emerald-400" },
  진행중: { label: "진행중", color: "text-blue-400", dot: "bg-blue-400" },
  대기: { label: "대기", color: "text-gray-500", dot: "bg-gray-500" },
};

const PROGRESS_COLOR: Record<TestStatus, string> = {
  완료: "bg-emerald-500",
  진행중: "bg-blue-500",
  대기: "bg-gray-600",
};

const categories = ["전체", ...Array.from(new Set(testItems.map((i) => i.category)))];

export default function TestProgressSection() {
  const [activeCategory, setActiveCategory] = useState("전체");

  const filtered =
    activeCategory === "전체"
      ? testItems
      : testItems.filter((i) => i.category === activeCategory);

  const overall = Math.round(
    testItems.reduce((sum, i) => sum + i.progress, 0) / testItems.length
  );

  return (
    <section id="test-progress">
      <div className="flex items-center justify-between mb-6">
        <h2 className="text-xl font-semibold text-white">테스트 진척도</h2>
        <div className="flex items-center gap-2 bg-gray-800 rounded-full px-4 py-1.5">
          <span className="text-gray-400 text-sm">전체</span>
          <span className="text-white font-bold text-lg">{overall}%</span>
        </div>
      </div>

      {/* Overall bar */}
      <div className="mb-6">
        <div className="h-2.5 bg-gray-800 rounded-full overflow-hidden">
          <div
            className="h-full bg-gradient-to-r from-blue-600 to-emerald-500 rounded-full transition-all duration-700"
            style={{ width: `${overall}%` }}
          />
        </div>
      </div>

      {/* Category filter */}
      <div className="flex flex-wrap gap-2 mb-6">
        {categories.map((cat) => (
          <button
            key={cat}
            onClick={() => setActiveCategory(cat)}
            className={`px-3 py-1 rounded-full text-sm font-medium transition-colors ${
              activeCategory === cat
                ? "bg-blue-600 text-white"
                : "bg-gray-800 text-gray-400 hover:bg-gray-700 hover:text-gray-200"
            }`}
          >
            {cat}
          </button>
        ))}
      </div>

      {/* Item list */}
      <div className="space-y-4">
        {filtered.map((item) => {
          const cfg = STATUS_CONFIG[item.status];
          return (
            <div key={item.feature} className="bg-gray-900 rounded-xl p-4 border border-gray-800">
              <div className="flex items-start justify-between mb-2 gap-2">
                <div>
                  <p className="text-white font-medium">{item.feature}</p>
                  <p className="text-gray-500 text-sm mt-0.5">{item.description}</p>
                </div>
                <div className="flex items-center gap-1.5 shrink-0">
                  <span className={`w-2 h-2 rounded-full ${cfg.dot}`} />
                  <span className={`text-sm font-medium ${cfg.color}`}>{cfg.label}</span>
                </div>
              </div>
              <div className="flex items-center gap-3">
                <div className="flex-1 h-2 bg-gray-800 rounded-full overflow-hidden">
                  <div
                    className={`h-full rounded-full transition-all duration-500 ${PROGRESS_COLOR[item.status]}`}
                    style={{ width: `${item.progress}%` }}
                  />
                </div>
                <span className="text-gray-400 text-sm w-9 text-right">{item.progress}%</span>
              </div>
            </div>
          );
        })}
      </div>
    </section>
  );
}
