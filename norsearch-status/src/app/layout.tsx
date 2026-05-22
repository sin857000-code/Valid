import type { Metadata } from "next";
import { Geist } from "next/font/google";
import "./globals.css";

const geist = Geist({
  variable: "--font-geist",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "노써치 서비스 현황 | NorSearch Status",
  description: "노써치 테스트 진척도, 업데이트 로드맵, 버전 히스토리를 확인하세요.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="ko" className={`${geist.variable} h-full antialiased`}>
      <body className="min-h-full bg-gray-950 text-gray-100">{children}</body>
    </html>
  );
}
