"use client";

import { Sidebar } from "@/components/admin/sidebar";
import { Navbar } from "@/components/admin/navbar";

export default function AdminSectionLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="flex min-h-screen bg-muted/10">
      <Sidebar />
      <div className="flex flex-1 flex-col">
        <Navbar />
        <main className="flex-1 px-3 py-3">{children}</main>
      </div>
    </div>
  );
}
