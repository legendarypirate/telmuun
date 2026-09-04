"use client";

import React, { useEffect, useState } from "react";
import { useQueryClient } from "@tanstack/react-query";
import { useStatuses } from "@/hooks/use-lookups";
import { queryKeys } from "@/lib/api";
import dayjs from "dayjs";
import { toast } from "sonner";
import { Edit, Trash2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import { Checkbox } from "@/components/ui/checkbox";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Sheet, SheetContent, SheetHeader, SheetTitle } from "@/components/ui/sheet";

interface Region {
  id: number;
  name: string;
  status?: string;
  color?: string;
  createdAt?: string;
}

export default function StatusPage() {
  const [selectedRowKeys, setSelectedRowKeys] = useState<number[]>([]);
  const [isDrawerVisible, setIsDrawerVisible] = useState(false);
  const queryClient = useQueryClient();
  const { data: regionData = [] } = useStatuses();
  const [pagination, setPagination] = useState({ current: 1, pageSize: 10, total: 0 });
  const [status, setStatus] = useState("");

  const handleDelete = async (id: number) => {
    try {
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/status/${id}`, {
        method: "DELETE",
      });

      if (response.ok) {
        console.log("Deleted successfully");
        await queryClient.invalidateQueries({ queryKey: queryKeys.statuses });
      } else {
        console.error("Failed to delete");
      }
    } catch (error) {
      console.error("Error deleting:", error);
    }
  };

  useEffect(() => {
    document.title = "Хүргэлтийн төлөв";
  }, []);

  useEffect(() => {
    setPagination((p) => ({ ...p, total: regionData.length }));
  }, [regionData.length]);

  const handleOk = async () => {
    try {
      const payload = {
        status,
      };

      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/status`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(payload),
      });

      const result = await response.json();

      if (result.success) {
        await queryClient.invalidateQueries({ queryKey: queryKeys.statuses });
        setStatus("");
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
  const pageCount = Math.max(1, Math.ceil(regionData.length / pagination.pageSize));

  return (
    <div className="pb-24">
      <div className="mb-6 flex items-center justify-between">
        <h1 className="text-3xl font-bold">Төлөв</h1>
        <Button onClick={() => setIsDrawerVisible(true)}>+ Төлөв үүсгэх</Button>
      </div>

      <div className="border rounded-md">
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
              <TableHead>Төлөв</TableHead>
              <TableHead>Үйлдэл</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {paged.map((record) => (
              <TableRow key={record.id}>
                <TableCell>
                  <Checkbox checked={selectedRowKeys.includes(record.id)} onCheckedChange={() => toggleRow(record.id)} />
                </TableCell>
                <TableCell>{record.createdAt ? dayjs(record.createdAt).format("YYYY-MM-DD hh:mm A") : "-"}</TableCell>
                <TableCell>
                  <Badge style={{ backgroundColor: record.color || "#999", color: "#fff" }}>
                    {record.status}
                  </Badge>
                </TableCell>
                <TableCell className="flex gap-1">
                  <Button variant="ghost" size="sm" onClick={() => alert(`Edit ${record.name}`)}>
                    <Edit className="h-4 w-4" /> Edit
                  </Button>
                  <Button variant="ghost" size="sm" onClick={() => handleDelete(record.id)}>
                    <Trash2 className="h-4 w-4 text-red-500" /> Delete
                  </Button>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </div>

      <div className="mt-4 flex items-center gap-2">
        <Button variant="outline" size="sm" disabled={pagination.current <= 1} onClick={() => setPagination((p) => ({ ...p, current: p.current - 1 }))}>
          Өмнөх
        </Button>
        <span className="text-sm">{pagination.current} / {pageCount}</span>
        <Button variant="outline" size="sm" disabled={pagination.current >= pageCount} onClick={() => setPagination((p) => ({ ...p, current: p.current + 1 }))}>
          Дараах
        </Button>
      </div>

      <Sheet open={isDrawerVisible} onOpenChange={setIsDrawerVisible}>
        <SheetContent>
          <SheetHeader>
            <SheetTitle>Төлөв үүсгэх</SheetTitle>
          </SheetHeader>
          <div className="space-y-3 mt-4">
            <div className="space-y-2">
              <Label>Төлөв</Label>
              <Input placeholder="Төлөв оруулах" value={status} onChange={(e) => setStatus(e.target.value)} />
            </div>
            <Button className="w-full" onClick={handleOk}>Үүсгэх</Button>
          </div>
        </SheetContent>
      </Sheet>
    </div>
  );
}
