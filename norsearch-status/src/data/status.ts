export type TestStatus = "완료" | "진행중" | "대기";

export interface TestItem {
  feature: string;
  description: string;
  progress: number;
  status: TestStatus;
  category: string;
}

export interface RoadmapItem {
  version: string;
  title: string;
  targetDate: string;
  features: string[];
  status: "출시완료" | "개발중" | "예정";
}

export interface VersionHistory {
  version: string;
  date: string;
  changes: { type: "추가" | "개선" | "수정" | "제거"; description: string }[];
}

export const testItems: TestItem[] = [
  {
    feature: "검색 엔진 핵심 로직",
    description: "키워드 매칭, 관련도 스코어링, 인덱싱",
    progress: 92,
    status: "진행중",
    category: "검색",
  },
  {
    feature: "자동완성 / 검색 제안",
    description: "실시간 제안어 노출 및 정확도",
    progress: 78,
    status: "진행중",
    category: "검색",
  },
  {
    feature: "필터 & 정렬",
    description: "카테고리, 가격, 평점 필터링",
    progress: 100,
    status: "완료",
    category: "검색",
  },
  {
    feature: "사용자 인증 / 로그인",
    description: "소셜 로그인, 세션 관리",
    progress: 100,
    status: "완료",
    category: "계정",
  },
  {
    feature: "찜 / 북마크 기능",
    description: "상품 저장 및 리스트 관리",
    progress: 65,
    status: "진행중",
    category: "계정",
  },
  {
    feature: "검색 히스토리",
    description: "최근 검색어 저장 및 삭제",
    progress: 40,
    status: "진행중",
    category: "계정",
  },
  {
    feature: "모바일 반응형 UI",
    description: "iOS / Android 브라우저 대응",
    progress: 85,
    status: "진행중",
    category: "UI/UX",
  },
  {
    feature: "다크모드",
    description: "시스템 설정 연동 및 수동 전환",
    progress: 20,
    status: "대기",
    category: "UI/UX",
  },
  {
    feature: "성능 최적화 (Core Web Vitals)",
    description: "LCP, FID, CLS 목표 달성",
    progress: 55,
    status: "진행중",
    category: "성능",
  },
  {
    feature: "API 부하 테스트",
    description: "동시 요청 1,000건 이상 안정성",
    progress: 30,
    status: "대기",
    category: "성능",
  },
];

export const roadmapItems: RoadmapItem[] = [
  {
    version: "v0.8",
    title: "베타 오픈 준비",
    targetDate: "2026-06-15",
    features: [
      "핵심 검색 로직 안정화",
      "자동완성 정확도 개선",
      "모바일 UI 완성",
      "기본 사용자 계정 기능",
    ],
    status: "개발중",
  },
  {
    version: "v0.9",
    title: "클로즈드 베타",
    targetDate: "2026-07-10",
    features: [
      "찜 / 북마크 기능 출시",
      "검색 히스토리 기능",
      "성능 최적화 1차",
      "피드백 수집 시스템",
    ],
    status: "예정",
  },
  {
    version: "v1.0",
    title: "정식 출시",
    targetDate: "2026-08-20",
    features: [
      "전체 기능 안정화",
      "다크모드 지원",
      "API 부하 테스트 통과",
      "앱 스토어 출시 (iOS/Android)",
    ],
    status: "예정",
  },
  {
    version: "v1.1",
    title: "포스트-런치 강화",
    targetDate: "2026-09-30",
    features: [
      "AI 추천 검색",
      "소셜 공유 기능",
      "알림 센터",
      "고급 필터 옵션",
    ],
    status: "예정",
  },
];

export const versionHistory: VersionHistory[] = [
  {
    version: "v0.7.2",
    date: "2026-05-18",
    changes: [
      { type: "수정", description: "검색 결과 중복 표시 버그 수정" },
      { type: "개선", description: "검색 응답 속도 30% 향상" },
      { type: "수정", description: "모바일에서 필터 패널 레이아웃 깨짐 수정" },
    ],
  },
  {
    version: "v0.7.1",
    date: "2026-05-05",
    changes: [
      { type: "추가", description: "가격 범위 슬라이더 필터 추가" },
      { type: "개선", description: "자동완성 응답 속도 개선" },
      { type: "수정", description: "로그인 세션 만료 처리 버그 수정" },
    ],
  },
  {
    version: "v0.7.0",
    date: "2026-04-22",
    changes: [
      { type: "추가", description: "소셜 로그인 (Google, Apple) 지원" },
      { type: "추가", description: "카테고리 필터링 기능" },
      { type: "개선", description: "검색 인덱싱 알고리즘 개선" },
      { type: "제거", description: "레거시 XML API 엔드포인트 제거" },
    ],
  },
  {
    version: "v0.6.5",
    date: "2026-04-08",
    changes: [
      { type: "수정", description: "iOS Safari 스크롤 버그 수정" },
      { type: "개선", description: "이미지 로딩 지연 최적화" },
    ],
  },
];
