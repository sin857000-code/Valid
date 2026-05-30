import TestProgressSection from "./components/TestProgressSection";
import RoadmapSection from "./components/RoadmapSection";
import VersionHistorySection from "./components/VersionHistorySection";
import PixelWorld from "./components/PixelWorld";

const NAV_LINKS = [
  { href: "#test-progress", label: "테스트 진척도" },
  { href: "#roadmap", label: "로드맵" },
  { href: "#version-history", label: "버전 히스토리" },
];

export default function StatusPage() {
  return (
    <div className="min-h-screen">
      {/* Header */}
      <header className="sticky top-0 z-10 bg-gray-950/80 backdrop-blur border-b border-gray-800">
        <div className="max-w-3xl mx-auto px-4 sm:px-6 h-14 flex items-center justify-between">
          <div className="flex items-center gap-2">
            <span className="text-white font-bold text-lg tracking-tight">노써치</span>
            <span className="text-gray-600">/</span>
            <span className="text-gray-400 text-sm">서비스 현황</span>
          </div>
          <nav className="hidden sm:flex items-center gap-4">
            {NAV_LINKS.map((link) => (
              <a
                key={link.href}
                href={link.href}
                className="text-gray-400 hover:text-white text-sm transition-colors"
              >
                {link.label}
              </a>
            ))}
          </nav>
        </div>
      </header>

      <main className="max-w-3xl mx-auto px-4 sm:px-6 py-10 space-y-16">
        {/* Hero */}
        <div className="text-center py-6">
          <div className="inline-flex items-center gap-2 bg-blue-950 border border-blue-800 rounded-full px-4 py-1.5 mb-6">
            <span className="w-2 h-2 rounded-full bg-blue-400 animate-pulse" />
            <span className="text-blue-300 text-sm font-medium">베타 준비중</span>
          </div>
          <h1 className="text-3xl sm:text-4xl font-bold text-white mb-3">
            노써치 서비스 현황
          </h1>
          <p className="text-gray-400 max-w-md mx-auto">
            테스트 진척도와 출시 일정을 실시간으로 확인할 수 있어요.
            <br />
            정식 출시까지 지켜봐 주세요!
          </p>
        </div>

        {/* Summary cards */}
        <div className="grid grid-cols-3 gap-3">
          <div className="bg-gray-900 border border-gray-800 rounded-xl p-4 text-center">
            <p className="text-2xl font-bold text-emerald-400">2</p>
            <p className="text-gray-500 text-sm mt-1">테스트 완료</p>
          </div>
          <div className="bg-gray-900 border border-gray-800 rounded-xl p-4 text-center">
            <p className="text-2xl font-bold text-blue-400">6</p>
            <p className="text-gray-500 text-sm mt-1">진행중</p>
          </div>
          <div className="bg-gray-900 border border-gray-800 rounded-xl p-4 text-center">
            <p className="text-2xl font-bold text-gray-400">2</p>
            <p className="text-gray-500 text-sm mt-1">대기중</p>
          </div>
        </div>

        {/* Pixel World */}
        <div>
          <h2 className="text-sm font-semibold text-gray-500 uppercase tracking-widest mb-3">
            픽셀 세계
          </h2>
          <PixelWorld />
        </div>

        <TestProgressSection />
        <RoadmapSection />
        <VersionHistorySection />
      </main>

      {/* Footer */}
      <footer className="border-t border-gray-800 mt-16">
        <div className="max-w-3xl mx-auto px-4 sm:px-6 py-6 flex items-center justify-between text-sm text-gray-600">
          <span>© 2026 NorSearch. All rights reserved.</span>
          <span>마지막 업데이트: 2026.05.22</span>
        </div>
      </footer>
    </div>
  );
}
