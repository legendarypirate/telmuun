"use client";

import React, { useEffect, useState } from "react";
import dayjs from "dayjs";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { SearchableSelect } from "@/components/ui/searchable-select";
import {
  FilterBar,
  FilterClearButton,
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

interface General {
  id: number;
  user_id: number;
  type: number;
  count: number;
  sum: number;
  account: number;
  cash: number;
  status: number;
  createdAt: string;
  updatedAt: string;
  user?: {
    username: string;
  };
}

interface User {
  id: number;
  username: string;
}

export default function GeneralReportPage() {
  const [loading, setLoading] = useState(false);
  const [data, setData] = useState<General[]>([]);
  const [merchantId, setMerchantId] = useState<string>("");
  const [merchants, setMerchants] = useState<User[]>([]);
  const [user, setUser] = useState<any>(null);
  const [isMerchant, setIsMerchant] = useState<boolean>(false);
  const [page, setPage] = useState(1);
  const pageSize = 20;

  useEffect(() => {
    const userData = typeof window !== "undefined" ? localStorage.getItem("user") : null;
    const userObj = userData ? JSON.parse(userData) : null;
    setUser(userObj);
    setIsMerchant(userObj?.role === 2);

    if (userObj?.role === 2) {
      setMerchantId(String(userObj.id));
    }
  }, []);

  useEffect(() => {
    const fetchMerchants = async () => {
      if (isMerchant) return;

      try {
        const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/user/merchant`);
        const result = await res.json();
        if (result.success) {
          setMerchants(result.data);
        } else {
          toast.error("Failed to fetch merchants");
        }
      } catch {
        toast.error("Error fetching merchants");
      }
    };
    fetchMerchants();
  }, [isMerchant]);

  const fetchData = async () => {
    try {
      setLoading(true);

      const params = new URLSearchParams();

      if (isMerchant && user?.id) {
        params.append("merchantId", user.id.toString());
      } else if (merchantId) {
        params.append("merchantId", merchantId);
      }

      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/general?${params.toString()}`);
      const result = await res.json();

      if (result.success) {
        const formattedData = result.data.map((item: any) => ({
          ...item,
          sum: parseFloat(item.sum),
          account: parseFloat(item.account),
          cash: parseFloat(item.cash),
        }));
        setData(formattedData);
      } else {
        toast.error("Failed to fetch generals");
        setData([]);
      }
    } catch {
      toast.error("Error fetching generals");
      setData([]);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (user) {
      fetchData();
    }
  }, [merchantId, isMerchant, user]);

  const handleAccountChange = async (id: number, value: number) => {
    setData((prev) =>
      prev.map((item) => {
        if (item.id === id) {
          const newAccount = Math.min(value, item.sum);
          const newCash = item.sum - newAccount;
          return { ...item, account: newAccount, cash: newCash };
        }
        return item;
      })
    );

    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/general/update_account/${id}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ account: value }),
      });

      const result = await res.json();
      if (!result.success) {
        toast.error("Failed to update account");
      }
    } catch {
      toast.error("Error updating account");
    }
  };

  const paged = data.slice((page - 1) * pageSize, page * pageSize);

  return (
    <div className="p-5">
      <h4 className="mb-4 text-xl font-bold">Ерөнхий тайлан</h4>

      {!isMerchant && (
        <FilterBar
          actions={
            merchantId ? (
              <FilterClearButton
                onClick={() => {
                  setMerchantId("");
                  setPage(1);
                }}
              />
            ) : undefined
          }
        >
          <FilterField label="Дэлгүүр" className="w-48">
            <SearchableSelect
              size="sm"
              value={merchantId || undefined}
              onValueChange={(v) => setMerchantId(v || "")}
              placeholder="Дэлгүүр сонгох"
              searchPlaceholder="Дэлгүүр хайх..."
              options={merchants.map((merchant) => ({
                value: String(merchant.id),
                label: merchant.username,
              }))}
            />
          </FilterField>
          <FilterField>
            <Button variant="outline" size="sm" className="h-8" onClick={fetchData}>
              Шүүх
            </Button>
          </FilterField>
        </FilterBar>
      )}

      {loading ? (
        <p className="py-8 text-center text-muted-foreground">Ачааллаж байна...</p>
      ) : (
        <div className="overflow-hidden rounded-xl border border-border/80 bg-card shadow-sm">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Хэрэглэгч</TableHead>
                <TableHead>Төрөл</TableHead>
                <TableHead>Count</TableHead>
                <TableHead>Дүн (₮)</TableHead>
                <TableHead>Данс (₮)</TableHead>
                <TableHead>Бэлэн (₮)</TableHead>
                <TableHead>Төлөв</TableHead>
                <TableHead>Үүссэн огноо</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {paged.map((record) => (
                <TableRow key={record.id}>
                  <TableCell>{record.user?.username ?? "-"}</TableCell>
                  <TableCell>{record.type === 1 ? "Driver" : "Merchant"}</TableCell>
                  <TableCell>{record.count}</TableCell>
                  <TableCell>{record.sum.toLocaleString()}</TableCell>
                  <TableCell>
                    {isMerchant ? (
                      <span>{record.account.toLocaleString()}</span>
                    ) : (
                      <Input
                        type="number"
                        className="w-[120px]"
                        value={record.account}
                        min={0}
                        max={record.sum}
                        onChange={(e) => handleAccountChange(record.id, parseFloat(e.target.value))}
                      />
                    )}
                  </TableCell>
                  <TableCell>{record.cash.toLocaleString()}</TableCell>
                  <TableCell>
                    <Badge variant={record.status === 1 ? "destructive" : "success"}>
                      {record.status === 1 ? "Тооцоо нийлээгүй" : "Тооцоо нийлсэн"}
                    </Badge>
                  </TableCell>
                  <TableCell>{dayjs(record.createdAt).format("YYYY-MM-DD HH:mm:ss")}</TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
          <div className="px-3 pb-2">
            <TablePagination
              current={page}
              pageSize={pageSize}
              total={data.length}
              showPageSize={false}
              onPageChange={setPage}
            />
          </div>
        </div>
      )}
    </div>
  );
}
