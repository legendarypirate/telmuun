"use client";

import React, { useEffect, useState } from "react";
import dayjs from "dayjs";
import utc from "dayjs/plugin/utc";
import timezone from "dayjs/plugin/timezone";
import * as XLSX from "xlsx";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
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

dayjs.extend(utc);
dayjs.extend(timezone);

interface ReportData {
  id: number;
  merchant_id: number;
  phone: string;
  address: string;
  image: string | null;
  status: number;
  price: string;
  comment: string;
  driver_id: number;
  report_stage: number;
  is_reported: boolean;
  is_deleted: boolean;
  report_id: number;
  delivery_id: string;
  createdAt: string;
  updatedAt: string;
  delivered_at?: string;
  merchant?: { username: string };
  status_name?: { status: string; color: string | null };
  driver?: { username: string };
}

interface Driver {
  id: number;
  username: string;
}

export default function MergeReportPage() {
  const [loading, setLoading] = useState<boolean>(false);
  const [data, setData] = useState<ReportData[]>([]);
  const [selectedRowKeys, setSelectedRowKeys] = useState<number[]>([]);
  const [merchantId, setMerchantId] = useState<string>("");
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const [drivers, setDrivers] = useState<Driver[]>([]);
  const [user, setUser] = useState<any>(null);
  const [isMerchant, setIsMerchant] = useState<boolean>(false);
  const [page, setPage] = useState(1);
  const [pageSize, setPageSize] = useState(100);

  useEffect(() => {
    const userData = typeof window !== "undefined" ? localStorage.getItem("user") : null;
    const userObj = userData ? JSON.parse(userData) : null;
    setUser(userObj);
    setIsMerchant(userObj?.role === 2);

    if (userObj?.role === 2) {
      setMerchantId(String(userObj.id));
    }
  }, []);

  const handlePriceChange = async (id: number, newPrice: string) => {
    try {
      setData((prev) => prev.map((item) => (item.id === id ? { ...item, price: newPrice } : item)));

      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/delivery/update_price/${id}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ price: parseFloat(newPrice) }),
      });

      const result = await res.json();
      if (!result.success) {
        toast.error("Failed to update price");
      }
    } catch {
      toast.error("Error updating price");
    }
  };

  useEffect(() => {
    const fetchDrivers = async () => {
      if (isMerchant) return;

      try {
        const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/user/merchant`);
        const result = await res.json();
        if (result.success) {
          setDrivers(result.data);
        } else {
          toast.error("Failed to fetch drivers");
        }
      } catch {
        toast.error("Error fetching drivers");
      }
    };
    fetchDrivers();
  }, [isMerchant]);

  const dateRange = startDate && endDate
    ? [dayjs(startDate).startOf("day").toISOString(), dayjs(endDate).endOf("day").toISOString()] as [string, string]
    : undefined;

  const fetchData = async () => {
    try {
      setLoading(true);

      const params = new URLSearchParams();

      if (isMerchant && user?.id) {
        params.append("merchantId", user.id.toString());
      } else if (merchantId) {
        params.append("merchantId", merchantId);
      }

      if (dateRange) {
        params.append("startDate", dateRange[0]);
        params.append("endDate", dateRange[1]);
      }

      console.log("Fetching URL:", `${process.env.NEXT_PUBLIC_API_URL}/api/merge_report/merge_merchant?${params.toString()}`);

      const res = await fetch(
        `${process.env.NEXT_PUBLIC_API_URL}/api/merge_report/merge_merchant?${params.toString()}`
      );
      const result = await res.json();

      if (result.success) {
        setData(result.data);
      } else {
        setData([]);
      }
    } catch {
      toast.error("Error fetching data");
      setData([]);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (user) {
      fetchData();
    }
  }, [merchantId, startDate, endDate, isMerchant, user]);

  const selectedItems = data.filter((item) => selectedRowKeys.includes(item.id));
  const totalCount = selectedItems.length;
  const totalPrice = selectedItems.reduce((sum, item) => sum + parseFloat(item.price || "0"), 0);
  const paged = data.slice((page - 1) * pageSize, page * pageSize);
  const pageCount = Math.max(1, Math.ceil(data.length / pageSize));

  return (
    <div className="pb-24 p-5">
      <h4 className="mb-4 text-xl font-bold">Харилцагчийн нийлсэн тайлан</h4>

      {!isMerchant && (
        <div className="mb-4 flex flex-wrap items-center gap-3">
          <Select value={merchantId || undefined} onValueChange={setMerchantId}>
            <SelectTrigger className="w-[200px]"><SelectValue placeholder="Select Merchant" /></SelectTrigger>
            <SelectContent>
              {drivers.map((driver) => (
                <SelectItem key={driver.id} value={String(driver.id)}>{driver.username}</SelectItem>
              ))}
            </SelectContent>
          </Select>
          <Input type="date" value={startDate} onChange={(e) => { setStartDate(e.target.value); setPage(1); }} className="w-40" />
          <Input type="date" value={endDate} onChange={(e) => { setEndDate(e.target.value); setPage(1); }} className="w-40" />
          <Button variant="outline" onClick={fetchData}>Apply Filters</Button>
        </div>
      )}

      {loading ? (
        <p className="py-8 text-center text-muted-foreground">Ачааллаж байна...</p>
      ) : (
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
                <TableHead>Хүргэсэн цаг</TableHead>
                <TableHead>Merchant</TableHead>
                <TableHead>Phone</TableHead>
                <TableHead>Address</TableHead>
                <TableHead>Price</TableHead>
                <TableHead>Comment</TableHead>
                <TableHead>Driver</TableHead>
                <TableHead>Status</TableHead>
                <TableHead>Delivery ID</TableHead>
                <TableHead>Created At</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {paged.map((record) => (
                <TableRow key={record.id}>
                  <TableCell>
                    <Checkbox
                      checked={selectedRowKeys.includes(record.id)}
                      onCheckedChange={() =>
                        setSelectedRowKeys((prev) =>
                          prev.includes(record.id) ? prev.filter((k) => k !== record.id) : [...prev, record.id]
                        )
                      }
                    />
                  </TableCell>
                  <TableCell>
                    {record.delivered_at ? dayjs(record.delivered_at).tz("Asia/Ulaanbaatar").format("YYYY-MM-DD HH:mm:ss") : "-"}
                  </TableCell>
                  <TableCell>{record.merchant?.username}</TableCell>
                  <TableCell>{record.phone}</TableCell>
                  <TableCell>{record.address}</TableCell>
                  <TableCell>
                    {isMerchant ? (
                      <span>{record.price}</span>
                    ) : (
                      <Input type="number" className="w-[100px]" value={record.price} onChange={(e) => handlePriceChange(record.id, e.target.value)} />
                    )}
                  </TableCell>
                  <TableCell>{record.comment}</TableCell>
                  <TableCell>{record.driver?.username}</TableCell>
                  <TableCell>
                    <Badge style={{ backgroundColor: record.status_name?.color || "blue", color: "#fff" }}>
                      {record.status_name?.status}
                    </Badge>
                  </TableCell>
                  <TableCell>{record.delivery_id}</TableCell>
                  <TableCell>{new Date(record.createdAt).toLocaleString()}</TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </div>
      )}

      <div className="mt-4 flex items-center gap-2">
        <Select value={String(pageSize)} onValueChange={(v) => { setPageSize(Number(v)); setPage(1); }}>
          <SelectTrigger className="w-24"><SelectValue /></SelectTrigger>
          <SelectContent>
            {["100", "200", "300", "500"].map((n) => <SelectItem key={n} value={n}>{n}</SelectItem>)}
          </SelectContent>
        </Select>
        <Button variant="outline" size="sm" disabled={page <= 1} onClick={() => setPage((p) => p - 1)}>Өмнөх</Button>
        <span className="text-sm">{page} / {pageCount}</span>
        <Button variant="outline" size="sm" disabled={page >= pageCount} onClick={() => setPage((p) => p + 1)}>Дараах</Button>
      </div>

      <div className="fixed bottom-0 left-64 right-0 z-[999] flex flex-wrap items-center gap-4 border-t bg-background p-4">
        <span>✅ Selected Items: <b>{totalCount}</b></span>
        <span>💰 Total Price: <b>{totalPrice.toLocaleString()}₮</b></span>
        <Button
          variant="outline"
          disabled={selectedRowKeys.length === 0}
          onClick={() => {
            const selectedRows = data.filter((item) => selectedRowKeys.includes(item.id));
            const excelData = selectedRows.map((row) => ({
              Дэлгүүр: row.merchant?.username ?? "-",
              Хаяг: row.address,
              Утас: row.phone,
              Үнэ: row.price,
              Тайлбар: row.comment ?? "-",
              Жолооч: row.driver?.username ?? "-",
            }));
            const worksheet = XLSX.utils.json_to_sheet(excelData);
            const workbook = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(workbook, worksheet, "Selected Deliveries");
            XLSX.writeFile(workbook, "selected_deliveries.xlsx");
          }}
        >
          Export Excel
        </Button>
      </div>
    </div>
  );
}
