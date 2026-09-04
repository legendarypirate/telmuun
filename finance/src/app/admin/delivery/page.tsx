"use client";

import React, { useEffect, useMemo, useRef, useState } from "react";
import dayjs from "dayjs";
import * as XLSX from "xlsx";
import { toast } from "sonner";
import { Edit, Eye, Plus, Trash2 } from "lucide-react";
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
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import {
  Dialog,
  DialogContent,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Sheet, SheetContent, SheetHeader, SheetTitle } from "@/components/ui/sheet";
import { formatDateLocal } from "@/lib/utils";
import { useQuery } from "@tanstack/react-query";
import { useDrivers, useMerchants, useStatuses } from "@/hooks/use-lookups";
import { queryKeys } from "@/lib/api";

const API = process.env.NEXT_PUBLIC_API_URL || "";

interface Item {
  id: number;
  good_id: number;
  quantity: number;
  good?: { name: string };
}

interface Delivery {
  id: number;
  phone: string;
  address: string;
  status: number | string;
  price: number;
  comment: string;
  driver_comment?: string;
  driver?: { username: string };
  createdAt: string;
  delivered_at?: string | null;
  merchant?: { username: string };
  status_name?: { status: string; color: string };
  postponed_number?: number;
  items?: Item[];
  image?: string;
}

interface DeliveryStatus {
  id: number;
  status: string;
  color: string;
}

export default function DeliveryPage() {
  const [selectedRowKeys, setSelectedRowKeys] = useState<number[]>([]);
  const [merchantFilter, setMerchantFilter] = useState<string>("all");
  const [driverFilter, setDriverFilter] = useState<string>("all");
  const [phoneFilter, setPhoneFilter] = useState("");
  const [debouncedPhone, setDebouncedPhone] = useState("");
  const [startDate, setStartDate] = useState(formatDateLocal(new Date()));
  const [endDate, setEndDate] = useState(formatDateLocal(new Date()));
  const [selectedStatuses, setSelectedStatuses] = useState<number[]>([]);
  const [pagination, setPagination] = useState({ current: 1, pageSize: 50, total: 0 });
  const [refreshKey, setRefreshKey] = useState(0);
  const { data: merchants = [] } = useMerchants();
  const { data: drivers = [] } = useDrivers();
  const { data: statusList = [] } = useStatuses();
  const [permissions, setPermissions] = useState<string[]>([]);
  const [expandedId, setExpandedId] = useState<number | null>(null);
  const [expandedItems, setExpandedItems] = useState<Record<number, Item[]>>({});

  const [isDrawerOpen, setIsDrawerOpen] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);
  const [isAllocateOpen, setIsAllocateOpen] = useState(false);
  const [isStatusOpen, setIsStatusOpen] = useState(false);
  const [isImageOpen, setIsImageOpen] = useState(false);
  const [selectedImageUrl, setSelectedImageUrl] = useState<string | null>(null);
  const [selectedDelivery, setSelectedDelivery] = useState<Delivery | null>(null);
  const [selectedDriverId, setSelectedDriverId] = useState<string>("");
  const [selectStatusId, setSelectedStatusId] = useState<string>("");
  const [statusOptions, setStatusOptions] = useState<{ id: number; status: string }[]>([]);

  const [createForm, setCreateForm] = useState({
    merchantId: "",
    phone: "",
    address: "",
    price: "",
    comment: "",
  });
  const [editForm, setEditForm] = useState({ phone: "", address: "", price: "" });
  const [pullFromWarehouse, setPullFromWarehouse] = useState(false);
  const [products, setProducts] = useState<{ id: string; name: string }[]>([]);
  const [productList, setProductList] = useState<
    { productId: string; productName: string; quantity: number; price: number }[]
  >([]);
  const [selectedProduct, setSelectedProduct] = useState("");
  const [quantity, setQuantity] = useState(1);
  const [productPrice, setProductPrice] = useState(0);

  const fileInputRef = useRef<HTMLInputElement | null>(null);
  const userData = typeof window !== "undefined" ? localStorage.getItem("user") : null;
  const user = userData ? JSON.parse(userData) : null;
  const isMerchant = user?.role === 2;
  const username = typeof window !== "undefined" ? localStorage.getItem("username") : null;
  const canUseExcelImport =
    permissions.includes("delivery:excel_import_delivery") ||
    username === "Nippon clean tech home care LLC" ||
    username === "admin";

  useEffect(() => {
    const t = setTimeout(() => {
      setDebouncedPhone((prev) => {
        if (prev !== phoneFilter.trim()) {
          setPagination((p) => (p.current === 1 ? p : { ...p, current: 1 }));
        }
        return phoneFilter.trim();
      });
    }, 350);
    return () => clearTimeout(t);
  }, [phoneFilter]);

  useEffect(() => {
    document.title = "Хүргэлт";
    const storedPermissions = localStorage.getItem("permissions");
    if (storedPermissions) {
      try {
        setPermissions(JSON.parse(storedPermissions));
      } catch {
        /* ignore */
      }
    }
  }, []);

  const deliveryFilters = {
    page: pagination.current,
    pageSize: pagination.pageSize,
    merchantFilter,
    driverFilter,
    debouncedPhone,
    selectedStatuses,
    startDate,
    endDate,
    refreshKey,
  };

  const { data: deliveryResult, isFetching: tableLoading } = useQuery({
    queryKey: queryKeys.deliveries(deliveryFilters),
    queryFn: async () => {
      const parsedUser = localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")!) : null;
      const userIsMerchant = parsedUser?.role === 2;
      let url = `${API}/api/delivery?page=${pagination.current}&limit=${pagination.pageSize}`;
      if (userIsMerchant && parsedUser?.id) url += `&merchant_id=${parsedUser.id}`;
      else if (merchantFilter !== "all") url += `&merchant_id=${merchantFilter}`;
      if (debouncedPhone) url += `&phone=${encodeURIComponent(debouncedPhone)}`;
      if (driverFilter !== "all") url += `&driver_id=${driverFilter}`;
      if (selectedStatuses.length) url += `&status_ids=${selectedStatuses.join(",")}`;
      if (startDate && endDate) url += `&start_date=${startDate}&end_date=${endDate}`;
      const res = await fetch(url);
      const result = await res.json();
      if (!result.success) throw new Error(result.message || "Хүргэлт ачааллахад алдаа гарлаа");
      return { data: (result.data || []) as Delivery[], total: result.pagination?.total || 0 };
    },
    staleTime: 20_000,
    placeholderData: (prev) => prev,
  });

  const deliveryData = deliveryResult?.data || [];

  useEffect(() => {
    if (deliveryResult?.total != null) {
      setPagination((prev) => (prev.total === deliveryResult.total ? prev : { ...prev, total: deliveryResult.total }));
    }
  }, [deliveryResult?.total]);

  useEffect(() => {
    if (!pullFromWarehouse) return;
    const merchantId = isMerchant ? user?.id : createForm.merchantId;
    if (!merchantId) {
      toast.warning("Дэлгүүрийг эхлээд сонгоно уу!");
      setPullFromWarehouse(false);
      return;
    }
    fetch(`${API}/api/good?merchant_id=${merchantId}`)
      .then((r) => r.json())
      .then((json) => {
        if (json.success) {
          setProducts((json.data || []).map((item: any) => ({ id: String(item.id), name: item.name })));
        }
      })
      .catch(() => toast.error("Бараа ачааллахад алдаа гарлаа"));
  }, [pullFromWarehouse, createForm.merchantId, isMerchant, user?.id]);

  const toggleStatus = (id: number) => {
    setSelectedStatuses((prev) => (prev.includes(id) ? prev.filter((s) => s !== id) : [...prev, id]));
    setPagination((p) => ({ ...p, current: 1 }));
  };

  const toggleRow = (id: number) => {
    setSelectedRowKeys((prev) => (prev.includes(id) ? prev.filter((k) => k !== id) : [...prev, id]));
  };

  const toggleAll = () => {
    if (selectedRowKeys.length === deliveryData.length) setSelectedRowKeys([]);
    else setSelectedRowKeys(deliveryData.map((d) => d.id));
  };

  const fetchItems = async (deliveryId: number) => {
    const res = await fetch(`${API}/api/delivery/${deliveryId}/items`);
    const data = await res.json();
    return data.success && Array.isArray(data.data) ? data.data : [];
  };

  const handleExpand = async (id: number) => {
    if (expandedId === id) {
      setExpandedId(null);
      return;
    }
    setExpandedId(id);
    if (!expandedItems[id]) {
      const items = await fetchItems(id);
      setExpandedItems((prev) => ({ ...prev, [id]: items }));
    }
  };

  const handleCreate = async () => {
    const token = localStorage.getItem("token");
    if (!token) {
      toast.error("Токен олдсонгүй. Та дахин нэвтэрнэ үү.");
      return;
    }
    if (!createForm.phone || !createForm.address || (!isMerchant && !createForm.merchantId)) {
      toast.error("Формыг шалгана уу.");
      return;
    }
    const payload = {
      merchant_id: isMerchant ? user.id : Number(createForm.merchantId),
      phone: createForm.phone,
      address: createForm.address,
      status: 1,
      price: createForm.price ? Number(createForm.price) : 0,
      comment: createForm.comment || "",
      items: productList.map((item) => ({ good_id: item.productId, quantity: item.quantity })),
    };
    const res = await fetch(`${API}/api/delivery`, {
      method: "POST",
      headers: { "Content-Type": "application/json", Authorization: `Bearer ${token}` },
      body: JSON.stringify(payload),
    });
    const result = await res.json();
    if (result.success) {
      toast.success("Амжилттай бүртгэгдлээ");
      setIsDrawerOpen(false);
      setCreateForm({ merchantId: "", phone: "", address: "", price: "", comment: "" });
      setProductList([]);
      setRefreshKey((k) => k + 1);
    } else {
      toast.error(result.message || "Хадгалахад алдаа гарлаа");
    }
  };

  const handleEditSave = async () => {
    if (!selectedDelivery) return;
    const res = await fetch(`${API}/api/delivery/${selectedDelivery.id}`, {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        phone: editForm.phone,
        address: editForm.address,
        price: Number(editForm.price) || 0,
      }),
    });
    const result = await res.json();
    if (res.ok && result.success) {
      toast.success("Амжилттай шинэчлэгдлээ");
      setIsEditOpen(false);
      setRefreshKey((k) => k + 1);
    } else {
      toast.error(result.message || "Шинэчлэхэд алдаа гарлаа");
    }
  };

  const handleDelete = async () => {
    const selected = deliveryData.filter((item) => selectedRowKeys.includes(item.id));
    if (selected.some((item) => Number(item.status) !== 1)) {
      toast.warning("Устгах боломжгүй хүргэлт байна.");
      return;
    }
    const res = await fetch(`${API}/api/delivery/delete-multiple`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ ids: selectedRowKeys }),
    });
    if (!res.ok) {
      toast.error("Устгахад алдаа гарлаа");
      return;
    }
    toast.success("Амжилттай устгагдлаа");
    setIsDeleteOpen(false);
    setSelectedRowKeys([]);
    setRefreshKey((k) => k + 1);
  };

  const handleAllocate = async () => {
    if (!selectedDriverId) {
      toast.error("Жолооч сонгоно уу");
      return;
    }
    const res = await fetch(`${API}/api/delivery/allocate`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ driver_id: Number(selectedDriverId), delivery_ids: selectedRowKeys }),
    });
    const result = await res.json();
    if (result.success) {
      toast.success("Жолоочид хуваариллаа");
      setIsAllocateOpen(false);
      setSelectedDriverId("");
      setSelectedRowKeys([]);
      setRefreshKey((k) => k + 1);
    } else {
      toast.error(result.message || "Хуваарилахад алдаа гарлаа");
    }
  };

  const handleStatusChange = async () => {
    if (!selectStatusId) {
      toast.error("Төлөв сонгоно уу");
      return;
    }
    const res = await fetch(`${API}/api/delivery/status`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ status_id: Number(selectStatusId), delivery_ids: selectedRowKeys }),
    });
    const result = await res.json();
    if (result.success) {
      toast.success("Төлөв солигдлоо");
      setIsStatusOpen(false);
      setSelectedStatusId("");
      setSelectedRowKeys([]);
      setRefreshKey((k) => k + 1);
    } else {
      toast.error(result.message || "Төлөв солиход алдаа гарлаа");
    }
  };

  const processExcelFile = async (file: File) => {
    const reader = new FileReader();
    reader.onload = async (e) => {
      const data = new Uint8Array(e.target?.result as ArrayBuffer);
      const workbook = XLSX.read(data, { type: "array" });
      const sheet = workbook.Sheets[workbook.SheetNames[0]];
      const json = XLSX.utils.sheet_to_json(sheet, { header: 1 }) as any[];
      const rows = json.slice(1);
      const isNippon = username === "Nippon clean tech home care LLC";
      const formatted = isNippon
        ? rows.map((row) => ({
            merchant_id: user?.id,
            merchantName: username,
            phone: row[0],
            address: row[1],
            price: 0,
            comment: row[2] ?? "",
            status: 1,
          }))
        : rows.map((row) => ({
            merchantName: row[0],
            phone: row[1],
            address: row[2],
            price: row[3],
            comment: row[4],
            status: 1,
          }));
      const res = await fetch(`${API}/api/delivery/import`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ deliveries: formatted }),
      });
      const result = await res.json();
      if (result.success) {
        toast.success(`${result.inserted || formatted.length} хүргэлт импорт хийгдлээ`);
        setRefreshKey((k) => k + 1);
      } else toast.error("Импорт амжилтгүй");
    };
    reader.readAsArrayBuffer(file);
  };

  const selectedTotal = useMemo(
    () =>
      deliveryData
        .filter((item) => selectedRowKeys.includes(item.id))
        .reduce((sum, item) => sum + Number(item.price || 0), 0),
    [deliveryData, selectedRowKeys]
  );

  const hasPermission = (perm: string) => permissions.includes(perm);
  const pageCount = Math.max(1, Math.ceil(pagination.total / pagination.pageSize));

  return (
    <div className="pb-28">
      <div className="mb-6 flex items-center justify-between">
        <h1 className="text-3xl font-bold">Хүргэлт</h1>
        <Button onClick={() => setIsDrawerOpen(true)}>
          <Plus className="h-4 w-4" /> Хүргэлт нэмэх
        </Button>
      </div>

      <div className="mb-4 flex flex-wrap items-center gap-3">
        <Input
          placeholder="Утас"
          value={phoneFilter}
          onChange={(e) => setPhoneFilter(e.target.value)}
          className="w-48"
        />
        <Input type="date" value={startDate} onChange={(e) => { setStartDate(e.target.value); setPagination((p) => ({ ...p, current: 1 })); }} className="w-40" />
        <Input type="date" value={endDate} onChange={(e) => { setEndDate(e.target.value); setPagination((p) => ({ ...p, current: 1 })); }} className="w-40" />
        {statusList.map((status) => (
          <button
            key={status.id}
            onClick={() => toggleStatus(status.id)}
            className={`rounded-md border px-3 py-1 text-sm ${selectedStatuses.includes(status.id) ? "border-green-600 ring-2 ring-green-200" : "border-border"}`}
            style={{ background: status.color || undefined, color: status.color ? "#fff" : undefined }}
          >
            {status.status}
          </button>
        ))}
        {!isMerchant && (
          <>
            <Select value={driverFilter} onValueChange={(v) => { setDriverFilter(v); setPagination((p) => ({ ...p, current: 1 })); }}>
              <SelectTrigger className="w-48"><SelectValue placeholder="Жолооч" /></SelectTrigger>
              <SelectContent>
                <SelectItem value="all">Бүх жолооч</SelectItem>
                {drivers.map((d) => <SelectItem key={d.id} value={String(d.id)}>{d.username}</SelectItem>)}
              </SelectContent>
            </Select>
            <Select value={merchantFilter} onValueChange={(v) => { setMerchantFilter(v); setPagination((p) => ({ ...p, current: 1 })); }}>
              <SelectTrigger className="w-48"><SelectValue placeholder="Дэлгүүр" /></SelectTrigger>
              <SelectContent>
                <SelectItem value="all">Бүх дэлгүүр</SelectItem>
                {merchants.map((m) => <SelectItem key={m.id} value={String(m.id)}>{m.username}</SelectItem>)}
              </SelectContent>
            </Select>
          </>
        )}
        {canUseExcelImport && (
          <>
            <Button variant="outline" onClick={() => fileInputRef.current?.click()}>Excel импорт</Button>
            <input ref={fileInputRef} type="file" accept=".xlsx,.xls" className="hidden" onChange={(e) => {
              const file = e.target.files?.[0];
              if (file) processExcelFile(file);
            }} />
          </>
        )}
      </div>

      <div className="border rounded-md overflow-x-auto">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead className="w-10"><Checkbox checked={deliveryData.length > 0 && selectedRowKeys.length === deliveryData.length} onCheckedChange={toggleAll} /></TableHead>
              <TableHead>Үүссэн огноо</TableHead>
              <TableHead>Хүргэсэн огноо</TableHead>
              {!isMerchant && <TableHead>Дэлгүүр</TableHead>}
              <TableHead>Хаяг / Утас</TableHead>
              <TableHead>Төлөв</TableHead>
              <TableHead>Үнэ</TableHead>
              <TableHead>Тайлбар</TableHead>
              <TableHead>Ж/тайлбар</TableHead>
              {!isMerchant && <TableHead>Жолооч</TableHead>}
              {!isMerchant && <TableHead>Үйлдэл</TableHead>}
            </TableRow>
          </TableHeader>
          <TableBody>
            {tableLoading ? (
              <TableRow><TableCell colSpan={11} className="py-10 text-center text-muted-foreground">Ачааллаж байна...</TableCell></TableRow>
            ) : deliveryData.length === 0 ? (
              <TableRow><TableCell colSpan={11} className="py-10 text-center text-muted-foreground">Хүргэлт олдсонгүй</TableCell></TableRow>
            ) : deliveryData.map((record) => (
              <React.Fragment key={record.id}>
                <TableRow>
                  <TableCell><Checkbox checked={selectedRowKeys.includes(record.id)} onCheckedChange={() => toggleRow(record.id)} /></TableCell>
                  <TableCell className="text-xs">{dayjs(record.createdAt).format("YYYY-MM-DD HH:mm")}</TableCell>
                  <TableCell className="text-xs">{record.delivered_at ? dayjs(record.delivered_at).format("YYYY-MM-DD HH:mm") : "-"}</TableCell>
                  {!isMerchant && <TableCell>{record.merchant?.username || "-"}</TableCell>}
                  <TableCell>
                    <button className="text-left" onClick={() => handleExpand(record.id)}>
                      <div className="font-medium">{record.phone}</div>
                      <div className="text-xs text-muted-foreground">{record.address}</div>
                    </button>
                  </TableCell>
                  <TableCell>
                    <Badge style={{ backgroundColor: record.status_name?.color || "#999", color: "#fff" }}>
                      {record.status_name?.status || record.status}
                      {(record.status === 10 || record.status === "10") && record.postponed_number ? ` (${record.postponed_number})` : ""}
                    </Badge>
                  </TableCell>
                  <TableCell>{Number(record.price || 0).toLocaleString()} ₮</TableCell>
                  <TableCell>{record.comment}</TableCell>
                  <TableCell>{record.driver_comment || "-"}</TableCell>
                  {!isMerchant && <TableCell>{record.driver?.username || "-"}</TableCell>}
                  {!isMerchant && (
                    <TableCell>
                      <div className="flex gap-1">
                        <Button variant="ghost" size="sm" onClick={() => {
                          setSelectedDelivery(record);
                          setEditForm({ phone: record.phone, address: record.address, price: String(record.price ?? "") });
                          setIsEditOpen(true);
                        }}><Edit className="h-4 w-4" /></Button>
                        {record.image && (
                          <Button variant="ghost" size="sm" onClick={() => { setSelectedImageUrl(record.image!); setIsImageOpen(true); }}>
                            <Eye className="h-4 w-4" />
                          </Button>
                        )}
                      </div>
                    </TableCell>
                  )}
                </TableRow>
                {expandedId === record.id && (
                  <TableRow>
                    <TableCell colSpan={11} className="bg-muted/30">
                      {(expandedItems[record.id] || []).length === 0 ? (
                        <p className="text-sm text-muted-foreground">Бараа олдсонгүй</p>
                      ) : (
                        <div className="space-y-1 text-sm">
                          {expandedItems[record.id].map((item) => (
                            <div key={item.id}>{item.good?.name || "-"} × {item.quantity}</div>
                          ))}
                        </div>
                      )}
                    </TableCell>
                  </TableRow>
                )}
              </React.Fragment>
            ))}
          </TableBody>
        </Table>
      </div>

      <div className="mt-4 flex flex-wrap items-center justify-between gap-3">
        <div className="flex items-center gap-2">
          <span className="text-sm text-muted-foreground">Хуудас:</span>
          <Select value={String(pagination.pageSize)} onValueChange={(v) => setPagination((p) => ({ ...p, pageSize: Number(v), current: 1 }))}>
            <SelectTrigger className="w-24"><SelectValue /></SelectTrigger>
            <SelectContent>
              {["10", "50", "100", "500", "1000"].map((n) => <SelectItem key={n} value={n}>{n}</SelectItem>)}
            </SelectContent>
          </Select>
          <Button variant="outline" size="sm" disabled={pagination.current <= 1} onClick={() => setPagination((p) => ({ ...p, current: p.current - 1 }))}>Өмнөх</Button>
          <span className="text-sm">{pagination.current} / {pageCount}</span>
          <Button variant="outline" size="sm" disabled={pagination.current >= pageCount} onClick={() => setPagination((p) => ({ ...p, current: p.current + 1 }))}>Дараах</Button>
          <span className="text-sm text-muted-foreground">Нийт {pagination.total}</span>
        </div>
      </div>

      {selectedRowKeys.length > 0 && (
        <div className="fixed bottom-0 left-64 right-0 border-t bg-background p-4 flex flex-wrap items-center gap-3">
          <span className="text-sm font-medium">{selectedRowKeys.length} сонгосон · {selectedTotal.toLocaleString()} ₮</span>
          {hasPermission("delivery:excel_import_delivery") && (
            <>
              <Button onClick={() => setIsAllocateOpen(true)}>Жолоочид хуваарилах</Button>
              <Button variant="destructive" onClick={() => setIsDeleteOpen(true)}><Trash2 className="h-4 w-4" /> Устгах</Button>
              <Button variant="outline" onClick={async () => {
                const res = await fetch(`${API}/api/status`);
                const result = await res.json();
                if (result.success) { setStatusOptions(result.data); setIsStatusOpen(true); }
              }}>Төлөв солих</Button>
              <Button variant="outline" onClick={() => {
                const selectedRows = deliveryData.filter((item) => selectedRowKeys.includes(item.id));
                const excelData = selectedRows.map((row) => ({
                  ID: row.id,
                  Дэлгүүр: row.merchant?.username ?? "-",
                  Хаяг: row.address,
                  Утас: row.phone,
                  Үнэ: Number(row.price) || 0,
                  Тайлбар: row.comment ?? "-",
                  Статус: row.status_name?.status ?? row.status,
                }));
                const ws = XLSX.utils.json_to_sheet(excelData);
                const wb = XLSX.utils.book_new();
                XLSX.utils.book_append_sheet(wb, ws, "Selected");
                XLSX.writeFile(wb, "selected_deliveries.xlsx");
              }}>Export Excel</Button>
            </>
          )}
        </div>
      )}

      <Sheet open={isDrawerOpen} onOpenChange={setIsDrawerOpen}>
        <SheetContent className="overflow-y-auto sm:max-w-md">
          <SheetHeader><SheetTitle>Хүргэлт үүсгэх</SheetTitle></SheetHeader>
          <div className="space-y-4 mt-4">
            {!isMerchant && (
              <div className="space-y-2">
                <Label>Дэлгүүр</Label>
                <Select value={createForm.merchantId} onValueChange={(v) => setCreateForm((p) => ({ ...p, merchantId: v }))}>
                  <SelectTrigger><SelectValue placeholder="Дэлгүүр сонгох" /></SelectTrigger>
                  <SelectContent>
                    {merchants.map((m) => <SelectItem key={m.id} value={String(m.id)}>{m.username}</SelectItem>)}
                  </SelectContent>
                </Select>
              </div>
            )}
            <div className="space-y-2"><Label>Утас</Label><Input value={createForm.phone} onChange={(e) => setCreateForm((p) => ({ ...p, phone: e.target.value }))} /></div>
            <div className="space-y-2"><Label>Хаяг</Label><Input value={createForm.address} onChange={(e) => setCreateForm((p) => ({ ...p, address: e.target.value }))} /></div>
            <div className="space-y-2"><Label>Үнэ</Label><Input type="number" value={createForm.price} onChange={(e) => setCreateForm((p) => ({ ...p, price: e.target.value }))} /></div>
            <div className="space-y-2"><Label>Тайлбар</Label><Input value={createForm.comment} onChange={(e) => setCreateForm((p) => ({ ...p, comment: e.target.value }))} /></div>
            <label className="flex items-center gap-2 text-sm">
              <Checkbox checked={pullFromWarehouse} onCheckedChange={(v) => setPullFromWarehouse(!!v)} />
              Агуулахаас бараа татах?
            </label>
            {pullFromWarehouse && (
              <div className="space-y-2">
                <div className="flex gap-2">
                  <Select value={selectedProduct} onValueChange={setSelectedProduct}>
                    <SelectTrigger><SelectValue placeholder="Бараа" /></SelectTrigger>
                    <SelectContent>
                      {products.map((p) => <SelectItem key={p.id} value={p.id}>{p.name}</SelectItem>)}
                    </SelectContent>
                  </Select>
                  <Input type="number" className="w-20" value={quantity} onChange={(e) => setQuantity(Number(e.target.value))} />
                  <Button type="button" onClick={() => {
                    const product = products.find((p) => p.id === selectedProduct);
                    if (!product || quantity < 1) return toast.warning("Бараа болон тоо оруулна уу");
                    const next = [...productList, { productId: product.id, productName: product.name, quantity, price: productPrice || 0 }];
                    setProductList(next);
                    setCreateForm((p) => ({ ...p, price: String(next.reduce((s, i) => s + i.price * i.quantity, 0) || "") }));
                    setSelectedProduct("");
                    setQuantity(1);
                  }}>Нэмэх</Button>
                </div>
                {productList.map((item) => (
                  <div key={item.productId} className="flex justify-between text-sm">
                    <span>{item.productName} × {item.quantity}</span>
                    <button className="text-destructive" onClick={() => setProductList((p) => p.filter((x) => x.productId !== item.productId))}>Устгах</button>
                  </div>
                ))}
              </div>
            )}
            <Button className="w-full" onClick={handleCreate}>Үүсгэх</Button>
          </div>
        </SheetContent>
      </Sheet>

      <Dialog open={isEditOpen} onOpenChange={setIsEditOpen}>
        <DialogContent>
          <DialogHeader><DialogTitle>Хүргэлт засах</DialogTitle></DialogHeader>
          <div className="space-y-3">
            <div className="space-y-2"><Label>Утас</Label><Input value={editForm.phone} onChange={(e) => setEditForm((p) => ({ ...p, phone: e.target.value }))} /></div>
            <div className="space-y-2"><Label>Хаяг</Label><Input value={editForm.address} onChange={(e) => setEditForm((p) => ({ ...p, address: e.target.value }))} /></div>
            <div className="space-y-2"><Label>Үнэ</Label><Input type="number" value={editForm.price} onChange={(e) => setEditForm((p) => ({ ...p, price: e.target.value }))} /></div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setIsEditOpen(false)}>Цуцлах</Button>
            <Button onClick={handleEditSave}>Хадгалах</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      <Dialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen}>
        <DialogContent>
          <DialogHeader><DialogTitle>Та {selectedRowKeys.length} хүргэлтийг устгахдаа итгэлтэй байна уу?</DialogTitle></DialogHeader>
          <DialogFooter>
            <Button variant="outline" onClick={() => setIsDeleteOpen(false)}>Үгүй</Button>
            <Button variant="destructive" onClick={handleDelete}>Тийм</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      <Dialog open={isAllocateOpen} onOpenChange={setIsAllocateOpen}>
        <DialogContent>
          <DialogHeader><DialogTitle>Жолооч сонгох</DialogTitle></DialogHeader>
          <Select value={selectedDriverId} onValueChange={setSelectedDriverId}>
            <SelectTrigger><SelectValue placeholder="Жолооч" /></SelectTrigger>
            <SelectContent>
              {drivers.map((d) => <SelectItem key={d.id} value={String(d.id)}>{d.username}</SelectItem>)}
            </SelectContent>
          </Select>
          <DialogFooter>
            <Button variant="outline" onClick={() => setIsAllocateOpen(false)}>Цуцлах</Button>
            <Button onClick={handleAllocate}>Хадгалах</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      <Dialog open={isStatusOpen} onOpenChange={setIsStatusOpen}>
        <DialogContent>
          <DialogHeader><DialogTitle>Төлөв сонгох</DialogTitle></DialogHeader>
          <Select value={selectStatusId} onValueChange={setSelectedStatusId}>
            <SelectTrigger><SelectValue placeholder="Төлөв" /></SelectTrigger>
            <SelectContent>
              {statusOptions.map((s) => <SelectItem key={s.id} value={String(s.id)}>{s.status}</SelectItem>)}
            </SelectContent>
          </Select>
          <DialogFooter>
            <Button variant="outline" onClick={() => setIsStatusOpen(false)}>Цуцлах</Button>
            <Button onClick={handleStatusChange}>Хадгалах</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      <Dialog open={isImageOpen} onOpenChange={setIsImageOpen}>
        <DialogContent className="max-w-2xl">
          <DialogHeader><DialogTitle>Зураг</DialogTitle></DialogHeader>
          {selectedImageUrl && <img src={selectedImageUrl} alt="delivery" className="max-h-[70vh] w-full object-contain" />}
        </DialogContent>
      </Dialog>
    </div>
  );
}
