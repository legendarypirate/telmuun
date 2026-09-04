"use client";

import React, { useEffect, useMemo, useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { useDrivers, useMerchants } from "@/hooks/use-lookups";
import { queryKeys } from "@/lib/api";
import dayjs from "dayjs";
import isSameOrAfter from "dayjs/plugin/isSameOrAfter";
import isSameOrBefore from "dayjs/plugin/isSameOrBefore";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
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
  FilterBar,
  FilterChip,
  FilterClearButton,
  FilterDate,
  FilterField,
  FilterInput,
} from "@/components/ui/filter-bar";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import {
  TableActions,
  TableEditButton,
  TableDeleteButton,
} from "@/components/ui/table-actions";
import { TablePagination } from "@/components/ui/table-pagination";
import {
  Dialog,
  DialogContent,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Sheet, SheetContent, SheetHeader, SheetTitle } from "@/components/ui/sheet";

dayjs.extend(isSameOrAfter);
dayjs.extend(isSameOrBefore);

interface Order {
  id: number;
  phone: string;
  address: string;
  status: number | string;
  comment: string;
  driver: {
    username: string;
  };
  createdAt: string;
  merchant: {
    username: string;
  };
  status_name: {
    status: string;
    color: string;
  };
}

interface Status {
  id: number;
  label: string;
  color: string;
}

export default function DeliveryPage() {
  const [selectedRowKeys, setSelectedRowKeys] = useState<number[]>([]);
  const [merchantFilter, setMerchantFilter] = useState("");
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const [isModalVisible, setIsModalVisible] = useState(false);
  const [isDrawerVisible, setIsDrawerVisible] = useState(false);
  const { data: merchants = [] } = useMerchants();
  const { data: drivers = [] } = useDrivers();
  const [refreshKey, setRefreshKey] = useState(0);
  const [selectedDriverId, setSelectedDriverId] = useState<string>("");
  const [pagination, setPagination] = useState({ current: 1, pageSize: 10, total: 0 });
  const [permissions, setPermissions] = useState<string[]>([]);
  const [createForm, setCreateForm] = useState({
    merchantId: "",
    phone: "",
    address: "",
    comment: "",
  });

  const userData = typeof window !== "undefined" ? localStorage.getItem("user") : null;
  const user = userData ? JSON.parse(userData) : null;
  const isMerchant = user?.role === 2;
  const username = typeof window !== "undefined" ? localStorage.getItem("username") : null;
  const merchantId = isMerchant ? user.id : null;
  const [statusList] = useState<Status[]>([
    { id: 1, label: "Шинэ", color: "orange" },
    { id: 2, label: "Жолоочид", color: "blue" },
    { id: 3, label: "Хүргэсэн", color: "green" },
    { id: 4, label: "Цуцалсан", color: "red" },
  ]);
  const [selectedStatuses, setSelectedStatuses] = useState<number[]>([]);
  const [phoneFilter, setPhoneFilter] = useState("");

  const toggleStatus = (id: number) => {
    setSelectedStatuses((prev) => (prev.includes(id) ? prev.filter((s) => s !== id) : [...prev, id]));
  };

  useEffect(() => {
    document.title = "Татан авалт";
    if (isMerchant && merchantId) {
      setCreateForm((p) => ({ ...p, merchantId: String(merchantId) }));
    }
    const saved = localStorage.getItem("permissions");
    if (saved) setPermissions(JSON.parse(saved));
  }, [isMerchant, merchantId]);

  const orderFilters = {
    page: pagination.current,
    pageSize: pagination.pageSize,
    phoneFilter,
    selectedStatuses,
    startDate,
    endDate,
    refreshKey,
    merchantId: isMerchant ? merchantId : undefined,
  };

  const { data: orderResult } = useQuery({
    queryKey: queryKeys.orders(orderFilters),
    queryFn: async () => {
      const storedUserData = localStorage.getItem("user");
      const storedUser = storedUserData ? JSON.parse(storedUserData) : null;
      let url = `${process.env.NEXT_PUBLIC_API_URL}/api/order?page=${pagination.current}&limit=${pagination.pageSize}`;
      if (storedUser && storedUser.role === 2) url += `&merchant_id=${storedUser.id}`;
      if (phoneFilter) url += `&phone=${phoneFilter}`;
      if (selectedStatuses.length > 0) url += `&status_ids=${selectedStatuses.join(",")}`;
      if (startDate && endDate) url += `&start_date=${startDate}&end_date=${endDate}`;
      const orderRes = await fetch(url);
      const ordersResult = await orderRes.json();
      if (!ordersResult.success) throw new Error(ordersResult.message || "Failed to fetch orders");
      return {
        data: (ordersResult.data || []) as Order[],
        total: ordersResult.pagination?.total || 0,
      };
    },
    staleTime: 20_000,
    placeholderData: (prev) => prev,
  });

  const orderData = orderResult?.data || [];

  useEffect(() => {
    if (orderResult?.total != null) {
      setPagination((prev) => (prev.total === orderResult.total ? prev : { ...prev, total: orderResult.total }));
    }
  }, [orderResult?.total]);

  const hasPermission = (perm: string) => permissions.includes(perm);

  const handleOk = async () => {
    try {
      const payload = {
        merchant_id: isMerchant ? merchantId : Number(createForm.merchantId),
        phone: createForm.phone,
        address: createForm.address,
        status: 1,
        comment: createForm.comment,
      };

      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/order`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(payload),
      });

      const result = await response.json();

      if (result.success) {
        setRefreshKey((k) => k + 1);
        setCreateForm({ merchantId: isMerchant && merchantId ? String(merchantId) : "", phone: "", address: "", comment: "" });
        setIsDrawerVisible(false);
      } else {
        console.error("Failed to create delivery:", result.message);
      }
    } catch (err) {
      console.error("Validation or request error:", err);
    }
  };

  const filteredData = useMemo(() => {
    return orderData.filter((item) => {
      const matchesMerchant = item.merchant?.username?.toLowerCase().includes(merchantFilter.toLowerCase());
      const itemDate = dayjs(item.createdAt);
      const matchesDate =
        !startDate ||
        !endDate ||
        (itemDate.isSameOrAfter(dayjs(startDate).startOf("day")) && itemDate.isSameOrBefore(dayjs(endDate).endOf("day")));
      return matchesMerchant && matchesDate;
    });
  }, [orderData, merchantFilter, startDate, endDate]);

  const handleAllocateToDriver = async () => {
    if (selectedRowKeys.length === 0) {
      alert("Please select at least one delivery.");
      return;
    }

    setIsModalVisible(true);
  };

  const handleSaveAllocation = async () => {
    if (!selectedDriverId) {
      alert("Please select a driver!");
      return;
    }

    try {
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/order/allocate`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          driver_id: Number(selectedDriverId),
          delivery_ids: selectedRowKeys,
        }),
      });

      const result = await response.json();

      if (result.success) {
        setIsModalVisible(false);
        setSelectedDriverId("");
        alert("Deliveries allocated to the driver successfully.");

        setRefreshKey((k) => k + 1);
      } else {
        alert("Failed to allocate deliveries.");
      }
    } catch (error) {
      console.error("Error allocating deliveries:", error);
    }
  };

  const toggleRow = (id: number) => {
    setSelectedRowKeys((prev) => (prev.includes(id) ? prev.filter((k) => k !== id) : [...prev, id]));
  };

  return (
    <div className="pb-28">
      <div className="mb-4 flex items-center justify-between">
        <h1 className="text-2xl font-bold">Татан авалт</h1>
        {hasPermission("order:create_order") && (
          <Button onClick={() => setIsDrawerVisible(true)}>
            + Захиалга үүсгэх
          </Button>
        )}
      </div>

      <FilterBar
        actions={
          <>
            <div className="flex min-w-0 flex-1 flex-wrap items-center gap-1.5">
              <span className="mr-1 text-[11px] font-medium uppercase tracking-wide text-muted-foreground">
                Төлөв
              </span>
              {statusList.map((status) => (
                <FilterChip
                  key={status.id}
                  active={selectedStatuses.includes(status.id)}
                  onClick={() => toggleStatus(status.id)}
                  style={{ background: status.color, color: "#fff" }}
                >
                  {status.label}
                </FilterChip>
              ))}
            </div>
            {(phoneFilter || startDate || endDate || selectedStatuses.length > 0) && (
              <FilterClearButton
                onClick={() => {
                  setPhoneFilter("");
                  setStartDate("");
                  setEndDate("");
                  setSelectedStatuses([]);
                  setPagination((p) => ({ ...p, current: 1 }));
                }}
              />
            )}
          </>
        }
      >
        <FilterField label="Утас" className="w-40">
          <FilterInput
            icon="phone"
            placeholder="Утас хайх..."
            value={phoneFilter}
            onChange={(e) => setPhoneFilter(e.target.value)}
          />
        </FilterField>
        <FilterField label="Эхлэх" className="w-36">
          <FilterDate value={startDate} onChange={(e) => setStartDate(e.target.value)} />
        </FilterField>
        <FilterField label="Дуусах" className="w-36">
          <FilterDate value={endDate} onChange={(e) => setEndDate(e.target.value)} />
        </FilterField>
      </FilterBar>

      <div className="overflow-hidden rounded-xl border border-border/80 bg-card shadow-sm">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead className="w-10">
                <Checkbox
                  checked={orderData.length > 0 && selectedRowKeys.length === orderData.length}
                  onCheckedChange={() => {
                    if (selectedRowKeys.length === orderData.length) setSelectedRowKeys([]);
                    else setSelectedRowKeys(orderData.map((o) => o.id));
                  }}
                />
              </TableHead>
              <TableHead>Үүссэн огноо</TableHead>
              <TableHead>Мерчанд нэр</TableHead>
              <TableHead>Утас</TableHead>
              <TableHead>Хаяг</TableHead>
              <TableHead>Төлөв</TableHead>
              <TableHead>Тайлбар</TableHead>
              <TableHead>Жолооч нэр</TableHead>
              <TableHead>Үйлдэл</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {orderData.map((record) => {
              const found = statusList.find((s) => s.id === record.status);
              return (
                <TableRow key={record.id}>
                  <TableCell>
                    <Checkbox checked={selectedRowKeys.includes(record.id)} onCheckedChange={() => toggleRow(record.id)} />
                  </TableCell>
                  <TableCell>{dayjs(record.createdAt).format("YYYY-MM-DD hh:mm A")}</TableCell>
                  <TableCell>{record.merchant?.username || "-"}</TableCell>
                  <TableCell>{record.phone}</TableCell>
                  <TableCell>{record.address}</TableCell>
                  <TableCell>
                    <Badge style={{ backgroundColor: found?.color || "gray", color: "#fff" }}>
                      {found?.label || "Unknown"}
                    </Badge>
                  </TableCell>
                  <TableCell>{record.comment}</TableCell>
                  <TableCell>{record.driver?.username || "-"}</TableCell>
                  <TableCell>
                    <TableActions>
                      <TableEditButton onClick={() => alert(`Edit ${record.merchant?.username}`)} />
                      <TableDeleteButton onClick={() => alert(`Delete ${record.merchant?.username}`)} />
                    </TableActions>
                  </TableCell>
                </TableRow>
              );
            })}
          </TableBody>
        </Table>
        <div className="px-3 pb-2">
          <TablePagination
            current={pagination.current}
            pageSize={pagination.pageSize}
            total={pagination.total}
            pageSizeOptions={[10, 20, 50]}
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
            <SheetTitle>Захиалга үүсгэх</SheetTitle>
          </SheetHeader>
          <div className="mt-4 space-y-3">
            <div className="space-y-2">
              <Label>Дэлгүүрийн нэр</Label>
              {isMerchant ? (
                <p className="rounded-md border bg-muted px-3 py-2 text-sm">{username}</p>
              ) : (
                <Select value={createForm.merchantId} onValueChange={(v) => setCreateForm((p) => ({ ...p, merchantId: v }))}>
                  <SelectTrigger><SelectValue placeholder="Select a merchant" /></SelectTrigger>
                  <SelectContent>
                    {merchants.map((merchant) => (
                      <SelectItem key={merchant.id} value={String(merchant.id)}>{merchant.username}</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              )}
            </div>
            <div className="space-y-2">
              <Label>Утас</Label>
              <Input placeholder="Enter phone number" value={createForm.phone} onChange={(e) => setCreateForm((p) => ({ ...p, phone: e.target.value }))} />
            </div>
            <div className="space-y-2">
              <Label>Хаяг</Label>
              <Input placeholder="Enter address" value={createForm.address} onChange={(e) => setCreateForm((p) => ({ ...p, address: e.target.value }))} />
            </div>
            <div className="space-y-2">
              <Label>Тайлбар</Label>
              <Input placeholder="Enter comment" value={createForm.comment} onChange={(e) => setCreateForm((p) => ({ ...p, comment: e.target.value }))} />
            </div>
            <Button className="w-full" onClick={handleOk}>Үүсгэх</Button>
          </div>
        </SheetContent>
      </Sheet>

      {hasPermission("order:allocate_order") && (
        <div className="fixed bottom-0 left-64 right-0 z-[999] flex items-center gap-4 border-t bg-background p-4">
          <div>{selectedRowKeys.length} item(s) selected</div>
          <Button onClick={handleAllocateToDriver} disabled={selectedRowKeys.length === 0}>
            Allocate to Driver
          </Button>
        </div>
      )}

      <Dialog open={isModalVisible} onOpenChange={setIsModalVisible}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Select Driver</DialogTitle>
          </DialogHeader>
          <Select value={selectedDriverId} onValueChange={setSelectedDriverId}>
            <SelectTrigger><SelectValue placeholder="Select a driver" /></SelectTrigger>
            <SelectContent>
              {drivers.map((driver) => (
                <SelectItem key={driver.id} value={String(driver.id)}>{driver.username}</SelectItem>
              ))}
            </SelectContent>
          </Select>
          <DialogFooter>
            <Button variant="outline" onClick={() => setIsModalVisible(false)}>Cancel</Button>
            <Button onClick={handleSaveAllocation}>Save</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
