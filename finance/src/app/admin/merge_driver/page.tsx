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
import { SearchableSelect } from "@/components/ui/searchable-select";
import {
  FilterBar,
  FilterClearButton,
  FilterDate,
  FilterField,
} from "@/components/ui/filter-bar";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { TablePagination } from "@/components/ui/table-pagination";

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
  const [driverId, setDriverId] = useState<string>("");
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const [drivers, setDrivers] = useState<Driver[]>([]);
  const [page, setPage] = useState(1);
  const [pageSize, setPageSize] = useState(100);

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
      try {
        const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/user/drivers`);
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
  }, []);

  const dateRange = startDate && endDate
    ? [dayjs(startDate).startOf("day").toISOString(), dayjs(endDate).endOf("day").toISOString()] as [string, string]
    : undefined;

  const fetchData = async () => {
    try {
      setLoading(true);

      const params = new URLSearchParams();
      if (driverId) params.append("driverId", driverId);
      if (dateRange) {
        params.append("startDate", dateRange[0]);
        params.append("endDate", dateRange[1]);
      }

      const res = await fetch(
        `${process.env.NEXT_PUBLIC_API_URL}/api/merge_report/merge_driver?${params.toString()}`
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
    fetchData();
  }, [driverId, startDate, endDate]);

  const handleMergeReport = async () => {
    if (!driverId) {
      toast.error("Please select a driver");
      return;
    }

    const selectedRows = data.filter((item) => selectedRowKeys.includes(item.id));
    if (selectedRows.length === 0) {
      toast.error("No deliveries selected");
      return;
    }

    const totalPrice = selectedRows.reduce((sum, item) => sum + parseFloat(item.price || "0"), 0);

    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/general/merge_driver`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          driver_id: Number(driverId),
          delivery_ids: selectedRows.map((item) => item.id),
          count: selectedRows.length,
          sum: totalPrice,
          status: 1,
          type: 1,
        }),
      });

      const result = await res.json();
      if (result.success) {
        toast.success("Deliveries merged successfully");
        setData((prev) =>
          prev.map((item) => (selectedRowKeys.includes(item.id) ? { ...item, report_stage: 2 } : item))
        );
        setSelectedRowKeys([]);
      } else {
        toast.error(result.message || "Failed to merge deliveries");
      }
    } catch (err) {
      console.error(err);
      toast.error("Error merging deliveries");
    }
  };

  const selectedItems = data.filter((item) => selectedRowKeys.includes(item.id));
  const totalCount = selectedItems.length;
  const totalPrice = selectedItems.reduce((sum, item) => sum + parseFloat(item.price || "0"), 0);
  const paged = data.slice((page - 1) * pageSize, page * pageSize);

  return (
    <div className="pb-24 p-5">
      <h4 className="mb-4 text-xl font-bold">Жолоочийн нийлсэн тайлан</h4>

      <FilterBar
        actions={
          (driverId || startDate || endDate) ? (
            <FilterClearButton
              onClick={() => {
                setDriverId("");
                setStartDate("");
                setEndDate("");
                setPage(1);
              }}
            />
          ) : undefined
        }
      >
        <FilterField label="Жолооч" className="w-48">
          <SearchableSelect
            size="sm"
            value={driverId || undefined}
            onValueChange={(v) => setDriverId(v || "")}
            placeholder="Жолооч сонгох"
            searchPlaceholder="Жолооч хайх..."
            options={drivers.map((driver) => ({
              value: String(driver.id),
              label: driver.username,
            }))}
          />
        </FilterField>
        <FilterField label="Эхлэх" className="w-36">
          <FilterDate
            value={startDate}
            onChange={(e) => {
              setStartDate(e.target.value);
              setPage(1);
            }}
          />
        </FilterField>
        <FilterField label="Дуусах" className="w-36">
          <FilterDate
            value={endDate}
            onChange={(e) => {
              setEndDate(e.target.value);
              setPage(1);
            }}
          />
        </FilterField>
        <FilterField>
          <Button variant="outline" size="sm" className="h-8" onClick={fetchData}>
            Шүүх
          </Button>
        </FilterField>
      </FilterBar>

      {loading ? (
        <p className="py-8 text-center text-muted-foreground">Ачааллаж байна...</p>
      ) : (
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
                <TableHead>ID</TableHead>
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
                  <TableCell>{record.id}</TableCell>
                  <TableCell>
                    {record.delivered_at ? dayjs(record.delivered_at).tz("Asia/Ulaanbaatar").format("YYYY-MM-DD HH:mm:ss") : "-"}
                  </TableCell>
                  <TableCell>{record.merchant?.username}</TableCell>
                  <TableCell>{record.phone}</TableCell>
                  <TableCell>{record.address}</TableCell>
                  <TableCell>
                    <Input type="number" className="w-[100px]" value={record.price} onChange={(e) => handlePriceChange(record.id, e.target.value)} />
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
          <div className="px-3 pb-2">
            <TablePagination
              current={page}
              pageSize={pageSize}
              total={data.length}
              pageSizeOptions={[100, 200, 300, 500]}
              onPageChange={setPage}
              onPageSizeChange={(size) => {
                setPageSize(size);
                setPage(1);
              }}
            />
          </div>
        </div>
      )}

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
