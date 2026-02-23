
import type { Metadata } from "next";
import { Rubik } from "next/font/google";
import "./globals.css";
import { AntdProvider } from "@/components/AntdProvider";

const rubik = Rubik({
  subsets: ["latin"],
  variable: "--font-rubik",
});

export const metadata: Metadata = {
  title: "My App",
  description: "Next.js + Ant Design styled",
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" className={rubik.variable}>
      <body>
        <AntdProvider>{children}</AntdProvider>
      </body>
    </html>
  );
}