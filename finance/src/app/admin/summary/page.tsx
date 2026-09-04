"use client";

import React, { useEffect, useState } from "react";
import dayjs from "dayjs";
import { Eye } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Switch } from "@/components/ui/switch";
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
import { Sheet, SheetContent, SheetHeader, SheetTitle } from "@/components/ui/sheet";

interface SummaryType {
  id: number;
  total: number;
  driver_calculation: number | string;
  account: number;
  comment: string;
  driver_summaries: { username: string };
  createdAt: string;
  merchant: { username: string };
}

export interface DeliveryType {
  id: number;
  merchant_id: number;
  phone: string;
  address: string;
  driver_id: number;
  price: string;
  status: number;
  createdAt: string;
  merchant: {
    username: string;
  };
  status_name: {
    status: string;
    color: string;
  };
}

type OptionType = {
  id: string;
  username: string;
};

export default function DeliveryPage() {
  const [pagination, setPagination] = useState({ current: 1, pageSize: 10, total: 0 });
  const [loadingDeliveries] = useState(false);
  const [merchantFilter, setMerchantFilter] = useState<string>("");
  const [secondOptions, setSecondOptions] = useState<OptionType[]>([]);
  const [secondValue, setSecondValue] = useState<string>("");
  const [loadingOptions, setLoadingOptions] = useState(false);
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const [isReportMergeMode, setIsReportMergeMode] = useState(true);
  const [summary, setSummary] = useState<SummaryType | null>(null);
  const [fetchingSummary, setFetchingSummary] = useState(false);
  const [fetchError, setFetchError] = useState<string | null>(null);
  const [tableData, setTableData] = useState<SummaryType[]>([]);
  const [drawerVisible, setDrawerVisible] = useState(false);
  const [deliveryList, setDeliveryList] = useState<DeliveryType[]>([]);
  const [drawerLoading, setDrawerLoading] = useState(false);

  useEffect(() => {
    document.title = "Тайлан харах";

    const fetchOptions = async () => {
      if (!merchantFilter) {
        setSecondOptions([]);
        return;
      }
      setLoadingOptions(true);
      try {
        const url =
          merchantFilter === "1"
            ? `${process.env.NEXT_PUBLIC_API_URL}/api/user/merchant`
            : `${process.env.NEXT_PUBLIC_API_URL}/api/user/drivers`;

        const response = await fetch(url);
        const result = await response.json();
        if (result.success && Array.isArray(result.data)) {
          setSecondOptions(result.data);
        } else {
          setSecondOptions([]);
        }
      } catch (error) {
        console.error("Fetch error:", error);
        setSecondOptions([]);
      } finally {
        setLoadingOptions(false);
      }
    };

    fetchOptions();
    setSecondValue("");
    setSummary(null);
    setTableData([]);
  }, [merchantFilter]);

  const handleShowDeliveries = async (reportId: number) => {
    setDrawerVisible(true);
    setDrawerLoading(true);
    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/report/${reportId}/deliveries`);
      const result = await res.json();
      setDeliveryList(result.success ? result.data : []);
    } catch {
      setDeliveryList([]);
    } finally {
      setDrawerLoading(false);
    }
  };

  const fetchSummary = async (userId: string, start: string, end: string) => {
    setFetchingSummary(true);
    setFetchError(null);

    try {
      const query = new URLSearchParams({
        user_id: userId,
        startDate: start,
        endDate: end,
      }).toString();

      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/summary?${query}`);
      const result = await response.json();

      if (!response.ok || !result.success) {
        throw new Error(result.message || "Failed to fetch summary.");
      }

      setTableData(result.data || []);
    } catch (error: any) {
      setFetchError(`Error: ${error.message || error}`);
      setSummary(null);
      setTableData([]);
    } finally {
      setFetchingSummary(false);
    }
  };

  const onDateChange = (start: string, end: string) => {
    if (start && end && secondValue) {
      fetchSummary(secondValue, start, end);
    }
  };

  const paged = tableData.slice((pagination.current - 1) * pagination.pageSize, pagination.current * pagination.pageSize);
  const pageCount = Math.max(1, Math.ceil(tableData.length / pagination.pageSize));

  return (
    <div className="flex min-h-screen flex-col">
      <div className="flex w-full flex-wrap items-center gap-4 p-4">
        <div className="flex items-center gap-2">
          <Switch
            checked={isReportMergeMode}
            onCheckedChange={(checked) => {
              setIsReportMergeMode(checked);
              setStartDate("");
              setEndDate("");
            }}
          />
          <span className="text-sm">{isReportMergeMode ? "Тайлан нийлэх" : "Тайлан харах"}</span>
        </div>
        <Select
          value={merchantFilter || undefined}
          onValueChange={(value) => {
            setMerchantFilter(value);
            setSummary(null);
            setFetchError(null);
            setTableData([]);
          }}
        >
          <SelectTrigger className="w-[150px]"><SelectValue placeholder="Сонгох" /></SelectTrigger>
          <SelectContent>
            <SelectItem value="1">Мерчант</SelectItem>
            <SelectItem value="2">Жолооч</SelectItem>
          </SelectContent>
        </Select>
        <Select
          value={secondValue || undefined}
          onValueChange={(value) => {
            setSecondValue(value);
            setSummary(null);
            setFetchError(null);
            setTableData([]);
          }}
          disabled={!merchantFilter}
        >
          <SelectTrigger className="w-[200px]"><SelectValue placeholder={loadingOptions ? "Ачааллаж..." : "Select Option"} /></SelectTrigger>
          <SelectContent>
            {secondOptions.map((o) => (
              <SelectItem key={o.id} value={String(o.id)}>{o.username}</SelectItem>
            ))}
          </SelectContent>
        </Select>
        <Input
          type="date"
          value={startDate}
          onChange={(e) => {
            setStartDate(e.target.value);
            onDateChange(e.target.value, endDate);
          }}
          className="w-40"
        />
        <Input
          type="date"
          value={endDate}
          onChange={(e) => {
            setEndDate(e.target.value);
            onDateChange(startDate, e.target.value);
          }}
          className="w-40"
        />
        {fetchError && <div className="text-sm text-red-600">{fetchError}</div>}
      </div>

      <div className="flex-1 overflow-y-auto px-6 pb-20">
        <div className="border rounded-md">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Үүссэн огноо</TableHead>
                <TableHead>Мерчант нэр</TableHead>
                <TableHead>Жолоочийн нэр</TableHead>
                <TableHead>Нийт</TableHead>
                <TableHead>Жолоочийн цалин</TableHead>
                <TableHead>Тооцоо</TableHead>
                <TableHead>Үзэх</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {loadingDeliveries || fetchingSummary ? (
                <TableRow>
                  <TableCell colSpan={7} className="py-8 text-center text-muted-foreground">Ачааллаж байна...</TableCell>
                </TableRow>
              ) : paged.map((record) => (
                <TableRow key={record.id}>
                  <TableCell>{dayjs(record.createdAt).format("YYYY-MM-DD hh:mm A")}</TableCell>
                  <TableCell>{record.merchant?.username || "-"}</TableCell>
                  <TableCell>{record.driver_summaries?.username || "-"}</TableCell>
                  <TableCell>{record.total}</TableCell>
                  <TableCell>{(record as any).driver}</TableCell>
                  <TableCell>{record.account}</TableCell>
                  <TableCell>
                    <Button variant="ghost" size="sm" onClick={() => handleShowDeliveries(record.id)}>
                      <Eye className="h-4 w-4" /> Хүргэлтүүд харах
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
      </div>

      <Sheet open={drawerVisible} onOpenChange={setDrawerVisible}>
        <SheetContent side="bottom" className="h-[50%]">
          <SheetHeader>
            <SheetTitle>Холбогдох хүргэлтүүд</SheetTitle>
          </SheetHeader>
          <div className="mt-4 border rounded-md">
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Мерчант</TableHead>
                  <TableHead>Утас</TableHead>
                  <TableHead>Хаяг</TableHead>
                  <TableHead>Үнэ</TableHead>
                  <TableHead>Төлөв</TableHead>
                  <TableHead>Огноо</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {drawerLoading ? (
                  <TableRow>
                    <TableCell colSpan={6} className="py-8 text-center text-muted-foreground">Ачааллаж байна...</TableCell>
                  </TableRow>
                ) : deliveryList.map((record) => (
                  <TableRow key={record.id}>
                    <TableCell>{record.merchant?.username || "-"}</TableCell>
                    <TableCell>{record.phone}</TableCell>
                    <TableCell>{record.address}</TableCell>
                    <TableCell>{record.price}</TableCell>
                    <TableCell>
                      <Badge style={{ backgroundColor: record.status_name?.color || "#999", color: "#fff" }}>
                        {record.status_name?.status || "N/A"}
                      </Badge>
                    </TableCell>
                    <TableCell>{dayjs(record.createdAt).format("YYYY-MM-DD hh:mm A")}</TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </div>
        </SheetContent>
      </Sheet>
    </div>
  );
}
