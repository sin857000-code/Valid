import { versionHistory } from "@/data/status";

const TYPE_CONFIG = {
  추가: { label: "추가", bg: "bg-blue-900/50", text: "text-blue-300", border: "border-blue-800" },
  개선: { label: "개선", bg: "bg-emerald-900/50", text: "text-emerald-300", border: "border-emerald-800" },
  수정: { label: "수정", bg: "bg-yellow-900/50", text: "text-yellow-300", border: "border-yellow-800" },
  제거: { label: "제거", bg: "bg-red-900/50", text: "text-red-300", border: "border-red-800" },
};

function formatDate(dateStr: string) {
  const d = new Date(dateStr);
  return d.toLocaleDateString("ko-KR", { year: "numeric", month: "long", day: "numeric" });
}

export default function VersionHistorySection() {
  return (
    <section id="version-history">
      <h2 className="text-xl font-semibold text-white mb-6">버전 히스토리</h2>

      <div className="space-y-4">
        {versionHistory.map((v, idx) => (
          <div key={v.version} className="bg-gray-900 rounded-xl border border-gray-800 overflow-hidden">
            <div className="flex items-center justify-between px-5 py-3 border-b border-gray-800">
              <div className="flex items-center gap-3">
                {idx === 0 && (
                  <span className="text-xs bg-blue-600 text-white px-2 py-0.5 rounded-full font-medium">
                    최신
                  </span>
                )}
                <span className="text-white font-mono font-semibold">{v.version}</span>
              </div>
              <span className="text-gray-500 text-sm">{formatDate(v.date)}</span>
            </div>

            <ul className="p-4 space-y-2">
              {v.changes.map((change, ci) => {
                const cfg = TYPE_CONFIG[change.type];
                return (
                  <li key={ci} className="flex items-start gap-2.5">
                    <span
                      className={`mt-0.5 text-xs px-1.5 py-0.5 rounded font-medium shrink-0 ${cfg.bg} ${cfg.text} border ${cfg.border}`}
                    >
                      {cfg.label}
                    </span>
                    <span className="text-gray-300 text-sm">{change.description}</span>
                  </li>
                );
              })}
            </ul>
          </div>
        ))}
      </div>
    </section>
  );
}
