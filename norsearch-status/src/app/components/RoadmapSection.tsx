import { roadmapItems, type RoadmapItem } from "@/data/status";

const STATUS_CONFIG: Record<RoadmapItem["status"], { label: string; bg: string; text: string; border: string }> = {
  출시완료: { label: "출시완료", bg: "bg-emerald-900/40", text: "text-emerald-400", border: "border-emerald-700" },
  개발중: { label: "개발중", bg: "bg-blue-900/40", text: "text-blue-400", border: "border-blue-700" },
  예정: { label: "예정", bg: "bg-gray-800/40", text: "text-gray-400", border: "border-gray-700" },
};

const CONNECTOR_COLOR: Record<RoadmapItem["status"], string> = {
  출시완료: "bg-emerald-500",
  개발중: "bg-blue-500",
  예정: "bg-gray-700",
};

function formatDate(dateStr: string) {
  const d = new Date(dateStr);
  return d.toLocaleDateString("ko-KR", { year: "numeric", month: "long", day: "numeric" });
}

export default function RoadmapSection() {
  return (
    <section id="roadmap">
      <h2 className="text-xl font-semibold text-white mb-6">업데이트 로드맵</h2>

      <div className="relative">
        {/* Vertical line */}
        <div className="absolute left-6 top-0 bottom-0 w-0.5 bg-gray-800" />

        <div className="space-y-6">
          {roadmapItems.map((item, idx) => {
            const cfg = STATUS_CONFIG[item.status];
            return (
              <div key={item.version} className="relative pl-16">
                {/* Circle connector */}
                <div
                  className={`absolute left-4 top-5 w-4 h-4 rounded-full border-2 border-gray-950 ${CONNECTOR_COLOR[item.status]}`}
                />

                <div className={`rounded-xl p-5 border ${cfg.bg} ${cfg.border}`}>
                  <div className="flex flex-wrap items-center gap-2 mb-1">
                    <span className={`text-xs font-bold px-2 py-0.5 rounded-full ${cfg.bg} ${cfg.text} border ${cfg.border}`}>
                      {cfg.label}
                    </span>
                    <span className="text-gray-500 text-xs">목표 {formatDate(item.targetDate)}</span>
                  </div>

                  <div className="flex items-baseline gap-2 mb-3">
                    <span className="text-gray-500 text-sm font-mono">{item.version}</span>
                    <h3 className="text-white font-semibold text-lg">{item.title}</h3>
                  </div>

                  <ul className="grid grid-cols-1 sm:grid-cols-2 gap-1.5">
                    {item.features.map((f) => (
                      <li key={f} className="flex items-center gap-2 text-sm text-gray-300">
                        <span className={`w-1.5 h-1.5 rounded-full shrink-0 ${CONNECTOR_COLOR[item.status]}`} />
                        {f}
                      </li>
                    ))}
                  </ul>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
}
