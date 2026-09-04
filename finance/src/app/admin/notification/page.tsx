"use client";

import React, { useEffect, useState } from "react";
import { useQueryClient } from "@tanstack/react-query";
import { useNotifications } from "@/hooks/use-lookups";
import { queryKeys } from "@/lib/api";
import dayjs from "dayjs";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Checkbox } from "@/components/ui/checkbox";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { TablePagination } from "@/components/ui/table-pagination";
import { Sheet, SheetContent, SheetHeader, SheetTitle } from "@/components/ui/sheet";

interface Notification {
  id: number;
  type: number;
  title: string;
  body: string;
  createdAt?: string;
}

export default function NotificationPage() {
  const [selectedRowKeys, setSelectedRowKeys] = useState<number[]>([]);
  const [isDrawerVisible, setIsDrawerVisible] = useState(false);
  const queryClient = useQueryClient();
  const { data: regionData = [] } = useNotifications();
  const [pagination, setPagination] = useState({ current: 1, pageSize: 10, total: 0 });
  const [form, setForm] = useState({ type: "", title: "", body: "" });

  useEffect(() => {
    document.title = "Мэдэгдэл";
  }, []);

  useEffect(() => {
    setPagination((p) => ({ ...p, total: regionData.length }));
  }, [regionData.length]);

  const handleOk = async () => {
    try {
      const payload = {
        title: form.title,
        body: form.body,
        type: Number(form.type),
      };

      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/notification`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(payload),
      });

      const result = await response.json();

      if (result.success) {
        await queryClient.invalidateQueries({ queryKey: queryKeys.notifications });
        setForm({ type: "", title: "", body: "" });
        setIsDrawerVisible(false);
      } else {
        console.error("Failed to create delivery:", result.message);
        toast.error(result.message || "Үүсгэхэд алдаа гарлаа");
      }
    } catch (err) {
      console.error("Validation or request error:", err);
    }
  };

  const toggleRow = (id: number) => {
    setSelectedRowKeys((prev) => (prev.includes(id) ? prev.filter((k) => k !== id) : [...prev, id]));
  };
  const paged = regionData.slice((pagination.current - 1) * pagination.pageSize, pagination.current * pagination.pageSize);

  return (
    <div className="pb-24">
      <div className="mb-6 flex items-center justify-between">
        <h1 className="text-3xl font-bold">Мэдэгдэл илгээх</h1>
        <Button onClick={() => setIsDrawerVisible(true)}>+ Мэдэгдэл илгээх</Button>
      </div>

      <div className="overflow-hidden rounded-xl border border-border/80 bg-card shadow-sm">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead className="w-10">
                <Checkbox
                  checked={paged.length > 0 && paged.every((r) => selectedRowKeys.includes(r.id))}
                  onCheckedChange={() => {
                    if (paged.every((r) => selectedRowKeys.includes(r.id))) {
                      setSelectedRowKeys((prev) => prev.filter((id) => !paged.some((r) => r.id === id)));
                    } else {
                      setSelectedRowKeys((prev) => [...new Set([...prev, ...paged.map((r) => r.id)])]);
                    }
                  }}
                />
              </TableHead>
              <TableHead>Үүссэн огноо</TableHead>
              <TableHead>Төрөл</TableHead>
              <TableHead>Гарчиг</TableHead>
              <TableHead>Мэдээлэл</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {paged.map((record) => (
              <TableRow key={record.id}>
                <TableCell>
                  <Checkbox checked={selectedRowKeys.includes(record.id)} onCheckedChange={() => toggleRow(record.id)} />
                </TableCell>
                <TableCell>{record.createdAt ? dayjs(record.createdAt).format("YYYY-MM-DD hh:mm A") : "-"}</TableCell>
                <TableCell>{record.type === 1 ? "Харилцагч" : "Жолооч"}</TableCell>
                <TableCell>{record.title}</TableCell>
                <TableCell>{record.body}</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
        <div className="px-3 pb-2">
          <TablePagination
            current={pagination.current}
            pageSize={pagination.pageSize}
            total={pagination.total}
            onPageChange={(page) => setPagination((p) => ({ ...p, current: page }))}
            onPageSizeChange={(pageSize) =>
              setPagination((p) => ({ ...p, pageSize, current: 1 }))
            }
          />
        </div>
      </div>

      <Sheet open={isDrawerVisible} onOpenChange={setIsDrawerVisible}>
        <SheetContent>
          <SheetHeader>
            <SheetTitle>Мэдэгдэл илгээх</SheetTitle>
          </SheetHeader>
          <div className="space-y-3 mt-4">
            <div className="space-y-2">
              <Label>Төрөл</Label>
              <Select value={form.type} onValueChange={(v) => setForm((p) => ({ ...p, type: v }))}>
                <SelectTrigger><SelectValue placeholder="Төрөл сонгох" /></SelectTrigger>
                <SelectContent>
                  <SelectItem value="1">Харилцагч</SelectItem>
                  <SelectItem value="2">Жолооч</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-2">
              <Label>Гарчиг</Label>
              <Input placeholder="Гарчиг оруулах" value={form.title} onChange={(e) => setForm((p) => ({ ...p, title: e.target.value }))} />
            </div>
            <div className="space-y-2">
              <Label>Мэдэгдэл</Label>
              <Input placeholder="Мэдэгдэл оруулах" value={form.body} onChange={(e) => setForm((p) => ({ ...p, body: e.target.value }))} />
            </div>
            <Button className="w-full" onClick={handleOk}>Үүсгэх</Button>
          </div>
        </SheetContent>
      </Sheet>
    </div>
  );
}
