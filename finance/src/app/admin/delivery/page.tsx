"use client";

import React, { useEffect, useMemo, useRef, useState } from "react";
import dayjs from "dayjs";
import * as XLSX from "xlsx";
import { toast } from "sonner";
import { Plus, Trash2, ShoppingCart, PackagePlus } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import { Checkbox } from "@/components/ui/checkbox";
import { SearchableSelect } from "@/components/ui/searchable-select";
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
  TableViewButton,
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
import { formatDateLocal, getTodayLocal } from "@/lib/utils";
import { useQuery } from "@tanstack/react-query";
import { useDrivers, useMerchants, useStatuses } from "@/hooks/use-lookups";
import { queryKeys } from "@/lib/api";

const API = process.env.NEXT_PUBLIC_API_URL || "";

const DISTRICTS = [
  { id: 1, name: "Баянзүрх" },
  { id: 2, name: "Сүхбаатар" },
  { id: 3, name: "Хан Уул" },
  { id: 4, name: "Баянгол" },
  { id: 5, name: "Чингэлтэй" },
  { id: 6, name: "Сонгинохайрхан" },
  { id: 7, name: "Ороннутаг" },
] as const;

function districtName(id?: number | null) {
  if (id == null) return "-";
  return DISTRICTS.find((d) => d.id === Number(id))?.name || "-";
}

type CreateDeliveryPayload = {
  merchant_id: number;
  phone: string;
  address: string;
  status: number;
  price: number;
  comment: string;
  district_id: number;
  delivery_date: string;
  items: Array<{ good_id: string; quantity: number }>;
};

type CartDraft = {
  id: string;
  payload: CreateDeliveryPayload;
  display: {
    merchantName: string;
    phone: string;
    address: string;
    price: number;
    districtName: string;
    itemCount: number;
  };
};

const DELIVERY_CART_STORAGE_KEY = "admin-delivery-create-cart";

function getCartStorageKey(scopeId: string | number) {
  return `${DELIVERY_CART_STORAGE_KEY}:${scopeId}`;
}

function loadCartFromStorage(scopeId: string | number): CartDraft[] {
  try {
    const raw = localStorage.getItem(getCartStorageKey(scopeId));
    if (!raw) return [];
    const parsed = JSON.parse(raw);
    return Array.isArray(parsed) ? parsed : [];
  } catch {
    return [];
  }
}

function saveCartToStorage(cart: CartDraft[], scopeId: string | number) {
  try {
    const key = getCartStorageKey(scopeId);
    if (cart.length === 0) localStorage.removeItem(key);
    else localStorage.setItem(key, JSON.stringify(cart));
  } catch {
    /* ignore */
  }
}

function clearCartStorage(scopeId: string | number) {
  try {
    localStorage.removeItem(getCartStorageKey(scopeId));
  } catch {
    /* ignore */
  }
}

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
  delivery_date?: string | null;
  merchant?: { username: string };
  status_name?: { status: string; color: string };
  postponed_number?: number;
  items?: Item[];
  image?: string;
  district_id?: number | null;
}

interface DeliveryStatus {
  id: number;
  status: string;
  color: string;
}

function statusChipStyle(status?: string, color?: string | null) {
  const name = (status || "").toLowerCase();
  const bg = (color || "").toLowerCase();
  const isNew = name === "шинэ" || bg === "yellow" || bg === "#ffff00" || bg === "#ff0";
  if (isNew) {
    return { backgroundColor: "orange", color: "#111" };
  }
  return {
    backgroundColor: color || "#999",
    color: "#fff",
  };
}

export default function DeliveryPage() {
  const [selectedRowKeys, setSelectedRowKeys] = useState<number[]>([]);
  const [merchantFilter, setMerchantFilter] = useState<string>("all");
  const [driverFilter, setDriverFilter] = useState<string>("all");
  const [districtFilter, setDistrictFilter] = useState<string>("all");
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
  const [isDeliveryDateOpen, setIsDeliveryDateOpen] = useState(false);
  const [bulkDeliveryDate, setBulkDeliveryDate] = useState(getTodayLocal());
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
    districtId: "",
    deliveryDate: getTodayLocal(),
  });
  const [editForm, setEditForm] = useState({ phone: "", address: "", price: "", districtId: "", deliveryDate: "" });
  const [pullFromWarehouse, setPullFromWarehouse] = useState(false);
  const [products, setProducts] = useState<{ id: string; name: string }[]>([]);
  const [productList, setProductList] = useState<
    { productId: string; productName: string; quantity: number; price: number }[]
  >([]);
  const [selectedProduct, setSelectedProduct] = useState("");
  const [quantity, setQuantity] = useState(1);
  const [productPrice, setProductPrice] = useState(0);
  const [createCart, setCreateCart] = useState<CartDraft[]>([]);
  const [cartHydrated, setCartHydrated] = useState(false);
  const [isCreatingBulk, setIsCreatingBulk] = useState(false);

  const fileInputRef = useRef<HTMLInputElement | null>(null);
  const userData = typeof window !== "undefined" ? localStorage.getItem("user") : null;
  const user = userData ? JSON.parse(userData) : null;
  const isMerchant = user?.role === 2;
  const username = typeof window !== "undefined" ? localStorage.getItem("username") : null;
  const cartScopeId = isMerchant && user?.id ? user.id : "admin";
  const canUseExcelImport =
    permissions.includes("delivery:excel_import_delivery") ||
    username === "Nippon clean tech home care LLC" ||
    username === "admin";

  useEffect(() => {
    setCreateCart(loadCartFromStorage(cartScopeId));
    setCartHydrated(true);
  }, [cartScopeId]);

  useEffect(() => {
    if (!cartHydrated) return;
    saveCartToStorage(createCart, cartScopeId);
  }, [createCart, cartScopeId, cartHydrated]);

  useEffect(() => {
    if (!isDrawerOpen || !cartHydrated) return;
    const saved = loadCartFromStorage(cartScopeId);
    setCreateCart(saved);
    if (saved.length > 0) {
      toast.message(`Сагсанд ${saved.length} хүргэлт хадгалагдсан байна`);
    }
  }, [isDrawerOpen]); // eslint-disable-line react-hooks/exhaustive-deps

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
    districtFilter,
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
      if (districtFilter !== "all") url += `&district_id=${districtFilter}`;
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

  const handlePrint = async () => {
    if (selectedRowKeys.length === 0) return;

    try {
      const selectedRows = deliveryData.filter((item) => selectedRowKeys.includes(item.id));
      const uniqueDrivers = [
        ...new Set(selectedRows.map((row) => row.driver?.username).filter(Boolean)),
      ].join(", ");

      const printWindow = window.open("", "_blank");
      if (!printWindow) {
        toast.error("Хэвлэх цонх нээгдсэнгүй. Popup-ыг зөвшөөрнө үү.");
        return;
      }

      printWindow.document.write(`
        <html>
          <head>
            <title>Print</title>
            <style>
              body { font-family: Arial, sans-serif; margin: 0; padding: 20px; font-size: 18px; }
              .header { text-align: center; margin-bottom: 20px; border-bottom: 2px solid #333; padding-bottom: 10px; font-size: 20px; }
              table { width: 100%; border-collapse: collapse; margin-top: 20px; font-size: 15px; table-layout: fixed; }
              th, td { border: 1px solid #ccc; padding: 8px 10px; text-align: left; vertical-align: top; }
              th { background-color: #f5f5f5; font-weight: bold; font-size: 15px; }
              .num { width: 4%; white-space: nowrap; }
              .merchant { width: 13%; word-break: break-word; }
              .phone { width: 12%; white-space: nowrap; word-break: keep-all; overflow-wrap: normal; }
              .addr { width: 30%; word-break: break-word; }
              .price { width: 10%; white-space: nowrap; }
              .comment { width: 16%; word-break: break-word; }
              .created { width: 15%; white-space: nowrap; font-size: 15px; }
              @page { size: A4 landscape; margin: 8mm; }
            </style>
          </head>
          <body>
            <div class="header" style="display: flex; justify-content: space-between; align-items: flex-start;">
              ${uniqueDrivers ? `<div style="flex: 1; text-align: left; font-size: 18px;"><div style="font-weight: bold;">Жолооч:</div><div>${uniqueDrivers}</div></div>` : ""}
            </div>
            <table>
              <thead>
                <tr>
                  <th class="num">№</th>
                  <th class="merchant">Дэлгүүр</th>
                  <th class="phone">Утас</th>
                  <th class="addr">Хаяг</th>
                  <th class="comment">Тайлбар</th>
                  <th class="price">Үнэ</th>
                  <th class="created">Шивсэн огноо</th>
                </tr>
              </thead>
              <tbody>
                ${selectedRows
                  .map(
                    (row, rowIndex) => `
                      <tr>
                        <td class="num">${rowIndex + 1}</td>
                        <td class="merchant">${row.merchant?.username ?? "-"}</td>
                        <td class="phone">${row.phone ?? "-"}</td>
                        <td class="addr">${row.address ?? "-"}</td>
                        <td class="comment">${row.comment || "-"}</td>
                        <td class="price">${Number(row.price || 0).toLocaleString()}₮</td>
                        <td class="created">${dayjs(row.createdAt).format("YYYY-MM-DD HH:mm")}</td>
                      </tr>
                    `
                  )
                  .join("")}
              </tbody>
            </table>
            <div style="margin-top: 20px; text-align: right; font-size: 18px; font-weight: bold;">
              Нийт: ${selectedRows.length} хүргэлт
            </div>
          </body>
        </html>
      `);
      printWindow.document.close();
      printWindow.print();
    } catch (error) {
      console.error(error);
      toast.error("Хэвлэхэд алдаа гарлаа");
    }
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

  const buildCreatePayload = (): CreateDeliveryPayload | null => {
    if (!createForm.phone || !createForm.address || !createForm.districtId || (!isMerchant && !createForm.merchantId)) {
      toast.error("Формыг шалгана уу. Дүүрэг сонгоно уу.");
      return null;
    }
    return {
      merchant_id: isMerchant ? user.id : Number(createForm.merchantId),
      phone: createForm.phone,
      address: createForm.address,
      status: 1,
      price: createForm.price ? Number(createForm.price) : 0,
      comment: createForm.comment || "",
      district_id: Number(createForm.districtId),
      delivery_date: createForm.deliveryDate || getTodayLocal(),
      items: productList.map((item) => ({ good_id: item.productId, quantity: item.quantity })),
    };
  };

  const resetEntryFields = () => {
    setCreateForm((prev) => ({
      merchantId: prev.merchantId,
      phone: "",
      address: "",
      price: "",
      comment: "",
      districtId: prev.districtId,
      deliveryDate: prev.deliveryDate || getTodayLocal(),
    }));
    setProductList([]);
    setSelectedProduct("");
    setQuantity(1);
    setProductPrice(0);
  };

  const postDelivery = async (payload: CreateDeliveryPayload) => {
    const token = localStorage.getItem("token");
    if (!token) throw new Error("Токен олдсонгүй. Та дахин нэвтэрнэ үү.");
    const res = await fetch(`${API}/api/delivery`, {
      method: "POST",
      headers: { "Content-Type": "application/json", Authorization: `Bearer ${token}` },
      body: JSON.stringify(payload),
    });
    const result = await res.json();
    if (!result.success) throw new Error(result.message || "Хадгалахад алдаа гарлаа");
    return result;
  };

  const handleAddToCart = () => {
    const payload = buildCreatePayload();
    if (!payload) return;
    const merchantName = isMerchant
      ? username || "Дэлгүүр"
      : merchants.find((m) => String(m.id) === createForm.merchantId)?.username || "Дэлгүүр";
    const draft: CartDraft = {
      id: `${Date.now()}-${Math.random().toString(36).slice(2, 8)}`,
      payload,
      display: {
        merchantName,
        phone: payload.phone,
        address: payload.address,
        price: payload.price,
        districtName: districtName(payload.district_id),
        itemCount: payload.items.length,
      },
    };
    setCreateCart((prev) => [...prev, draft]);
    resetEntryFields();
    toast.success(`Сагсанд нэмэгдлээ (${createCart.length + 1})`);
  };

  const handleCreate = async () => {
    if (isCreatingBulk) return;
    const payload = buildCreatePayload();
    if (!payload) return;
    try {
      await postDelivery(payload);
      toast.success("Амжилттай бүртгэгдлээ");
      setIsDrawerOpen(false);
      resetEntryFields();
      setRefreshKey((k) => k + 1);
    } catch (error: any) {
      toast.error(error?.message || "Хадгалахад алдаа гарлаа");
    }
  };

  const handleCreateCart = async () => {
    if (createCart.length === 0 || isCreatingBulk) return;
    setIsCreatingBulk(true);
    try {
      let successCount = 0;
      for (const draft of createCart) {
        await postDelivery(draft.payload);
        successCount += 1;
      }
      toast.success(`${successCount} хүргэлт амжилттай бүртгэгдлээ`);
      setCreateCart([]);
      clearCartStorage(cartScopeId);
      setIsDrawerOpen(false);
      resetEntryFields();
      setRefreshKey((k) => k + 1);
    } catch (error: any) {
      toast.error(error?.message || "Сагсан дахь хүргэлтүүдийг үүсгэхэд алдаа гарлаа");
      setRefreshKey((k) => k + 1);
    } finally {
      setIsCreatingBulk(false);
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
        district_id: editForm.districtId ? Number(editForm.districtId) : null,
        delivery_date: editForm.deliveryDate || null,
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

  const handleSaveDeliveryDate = async () => {
    if (!bulkDeliveryDate) {
      toast.warning("Огноо сонгоно уу!");
      return;
    }
    const res = await fetch(`${API}/api/delivery/update-delivery-dates`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ delivery_date: bulkDeliveryDate, delivery_ids: selectedRowKeys }),
    });
    const result = await res.json();
    if (result.success) {
      toast.success("Хүргэх огноо шинэчлэгдлээ");
      setIsDeliveryDateOpen(false);
      setSelectedRowKeys([]);
      setRefreshKey((k) => k + 1);
    } else {
      toast.error(result.message || "Огноо өөрчлөхөд алдаа гарлаа");
    }
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

  const openCreateDrawer = () => {
    setCreateForm((p) => ({ ...p, deliveryDate: p.deliveryDate || getTodayLocal() }));
    setIsDrawerOpen(true);
  };

  useEffect(() => {
    const onKeyDown = (e: KeyboardEvent) => {
      if (e.key !== "Enter" || e.shiftKey || e.metaKey || e.ctrlKey || e.altKey) return;
      if (isDrawerOpen || isEditOpen || isDeleteOpen || isAllocateOpen || isDeliveryDateOpen || isStatusOpen || isImageOpen) {
        return;
      }
      const target = e.target as HTMLElement | null;
      if (!target) return;
      const tag = target.tagName;
      if (
        tag === "INPUT" ||
        tag === "TEXTAREA" ||
        tag === "SELECT" ||
        tag === "BUTTON" ||
        target.isContentEditable ||
        target.closest('[role="dialog"]') ||
        target.closest("[data-radix-popper-content-wrapper]")
      ) {
        return;
      }
      e.preventDefault();
      openCreateDrawer();
    };
    window.addEventListener("keydown", onKeyDown);
    return () => window.removeEventListener("keydown", onKeyDown);
  }, [
    isDrawerOpen,
    isEditOpen,
    isDeleteOpen,
    isAllocateOpen,
    isDeliveryDateOpen,
    isStatusOpen,
    isImageOpen,
  ]);

  return (
    <div className="pb-28">
      <div className="mb-4 flex items-center justify-between">
        <h1 className="text-2xl font-bold">Хүргэлт</h1>
        <Button onClick={openCreateDrawer}>
          <Plus className="h-4 w-4" /> Хүргэлт нэмэх
        </Button>
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
                  style={statusChipStyle(status.status, status.color)}
                >
                  {status.status}
                </FilterChip>
              ))}
            </div>
            {(phoneFilter ||
              districtFilter !== "all" ||
              driverFilter !== "all" ||
              merchantFilter !== "all" ||
              selectedStatuses.length > 0) && (
              <FilterClearButton
                onClick={() => {
                  setPhoneFilter("");
                  setDistrictFilter("all");
                  setDriverFilter("all");
                  setMerchantFilter("all");
                  setSelectedStatuses([]);
                  setStartDate(formatDateLocal(new Date()));
                  setEndDate(formatDateLocal(new Date()));
                  setPagination((p) => ({ ...p, current: 1 }));
                }}
              />
            )}
            {canUseExcelImport && (
              <>
                <Button
                  variant="outline"
                  size="sm"
                  className="h-8"
                  onClick={() => fileInputRef.current?.click()}
                >
                  Excel импорт
                </Button>
                <input
                  ref={fileInputRef}
                  type="file"
                  accept=".xlsx,.xls"
                  className="hidden"
                  onChange={(e) => {
                    const file = e.target.files?.[0];
                    if (file) processExcelFile(file);
                  }}
                />
              </>
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
          <FilterDate
            value={startDate}
            onChange={(e) => {
              setStartDate(e.target.value);
              setPagination((p) => ({ ...p, current: 1 }));
            }}
          />
        </FilterField>
        <FilterField label="Дуусах" className="w-36">
          <FilterDate
            value={endDate}
            onChange={(e) => {
              setEndDate(e.target.value);
              setPagination((p) => ({ ...p, current: 1 }));
            }}
          />
        </FilterField>
        <FilterField label="Дүүрэг" className="w-44">
          <SearchableSelect
            size="sm"
            value={districtFilter}
            onValueChange={(v) => {
              setDistrictFilter(v || "all");
              setPagination((p) => ({ ...p, current: 1 }));
            }}
            placeholder="Дүүрэг"
            searchPlaceholder="Дүүрэг хайх..."
            options={[
              { value: "all", label: "Бүх дүүрэг" },
              ...DISTRICTS.map((d) => ({ value: String(d.id), label: d.name })),
            ]}
          />
        </FilterField>
        {!isMerchant && (
          <>
            <FilterField label="Жолооч" className="w-44">
              <SearchableSelect
                size="sm"
                value={driverFilter}
                onValueChange={(v) => {
                  setDriverFilter(v || "all");
                  setPagination((p) => ({ ...p, current: 1 }));
                }}
                placeholder="Жолооч"
                searchPlaceholder="Жолооч хайх..."
                options={[
                  { value: "all", label: "Бүх жолооч" },
                  ...drivers.map((d) => ({
                    value: String(d.id),
                    label: d.username,
                  })),
                ]}
              />
            </FilterField>
            <FilterField label="Дэлгүүр" className="w-48">
              <SearchableSelect
                size="sm"
                value={merchantFilter}
                onValueChange={(v) => {
                  setMerchantFilter(v || "all");
                  setPagination((p) => ({ ...p, current: 1 }));
                }}
                placeholder="Дэлгүүр"
                searchPlaceholder="Дэлгүүр хайх..."
                options={[
                  { value: "all", label: "Бүх дэлгүүр" },
                  ...merchants.map((m) => ({
                    value: String(m.id),
                    label: m.username,
                  })),
                ]}
              />
            </FilterField>
          </>
        )}
      </FilterBar>

      <div className="overflow-hidden rounded-xl border border-border/80 bg-card shadow-sm">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead className="w-10"><Checkbox checked={deliveryData.length > 0 && selectedRowKeys.length === deliveryData.length} onCheckedChange={toggleAll} /></TableHead>
              <TableHead>Шивсэн огноо</TableHead>
              <TableHead>Хүргэх огноо</TableHead>
              {!isMerchant && <TableHead>Дэлгүүр</TableHead>}
              <TableHead>Дүүрэг</TableHead>
              <TableHead className="min-w-[180px] max-w-[280px] whitespace-normal">Хаяг / Утас</TableHead>
              <TableHead>Төлөв</TableHead>
              <TableHead>Үнэ</TableHead>
              <TableHead className="min-w-[140px] max-w-[240px] whitespace-normal">Тайлбар</TableHead>
              <TableHead className="min-w-[140px] max-w-[240px] whitespace-normal">Ж/тайлбар</TableHead>
                  {!isMerchant && <TableHead>Жолооч</TableHead>}
                  {!isMerchant && <TableHead className="text-right">Үйлдэл</TableHead>}
                </TableRow>
              </TableHeader>
              <TableBody>
                {tableLoading ? (
                  <TableRow><TableCell colSpan={12} className="py-10 text-center text-muted-foreground">Ачааллаж байна...</TableCell></TableRow>
                ) : deliveryData.length === 0 ? (
                  <TableRow><TableCell colSpan={12} className="py-10 text-center text-muted-foreground">Хүргэлт олдсонгүй</TableCell></TableRow>
                ) : deliveryData.map((record) => (
                  <React.Fragment key={record.id}>
                    <TableRow>
                      <TableCell><Checkbox checked={selectedRowKeys.includes(record.id)} onCheckedChange={() => toggleRow(record.id)} /></TableCell>
                      <TableCell>{dayjs(record.createdAt).format("YYYY-MM-DD HH:mm")}</TableCell>
                      <TableCell>
                        {record.delivery_date
                          ? dayjs(record.delivery_date).format("YYYY-MM-DD")
                          : dayjs(record.createdAt).format("YYYY-MM-DD")}
                      </TableCell>
                      {!isMerchant && <TableCell>{record.merchant?.username || "-"}</TableCell>}
                      <TableCell>{districtName(record.district_id)}</TableCell>
                      <TableCell className="max-w-[280px] whitespace-normal align-top">
                        <button className="text-left w-full" onClick={() => handleExpand(record.id)}>
                          <div className="break-words">{record.phone}</div>
                          <div className="whitespace-normal break-words">
                            {record.address}
                          </div>
                        </button>
                      </TableCell>
                      <TableCell>
                        <Badge style={statusChipStyle(record.status_name?.status, record.status_name?.color)}>
                          {record.status_name?.status || record.status}
                          {(record.status === 10 || record.status === "10") && record.postponed_number ? ` (${record.postponed_number})` : ""}
                        </Badge>
                      </TableCell>
                      <TableCell>{Number(record.price || 0).toLocaleString()} ₮</TableCell>
                      <TableCell className="max-w-[240px] whitespace-normal align-top break-words">
                        {record.comment}
                      </TableCell>
                      <TableCell className="max-w-[240px] whitespace-normal align-top break-words">
                        {record.driver_comment || "-"}
                      </TableCell>
                      {!isMerchant && <TableCell>{record.driver?.username || "-"}</TableCell>}
                      {!isMerchant && (
                        <TableCell>
                          <TableActions>
                            <TableEditButton
                              onClick={() => {
                                setSelectedDelivery(record);
                                setEditForm({
                                  phone: record.phone,
                                  address: record.address,
                                  price: String(record.price ?? ""),
                                  districtId: record.district_id ? String(record.district_id) : "",
                                  deliveryDate: record.delivery_date
                                    ? dayjs(record.delivery_date).format("YYYY-MM-DD")
                                    : dayjs(record.createdAt).format("YYYY-MM-DD"),
                                });
                                setIsEditOpen(true);
                              }}
                            />
                            {record.image && (
                              <TableViewButton
                                onClick={() => {
                                  setSelectedImageUrl(record.image!);
                                  setIsImageOpen(true);
                                }}
                              />
                            )}
                          </TableActions>
                        </TableCell>
                      )}
                    </TableRow>
                    {expandedId === record.id && (
                      <TableRow>
                        <TableCell colSpan={12} className="bg-muted/40 px-6 py-4">
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
          <div className="px-3 pb-2">
            <TablePagination
              current={pagination.current}
              pageSize={pagination.pageSize}
              total={pagination.total}
              pageSizeOptions={[10, 50, 100, 500, 1000]}
              onPageChange={(page) => setPagination((p) => ({ ...p, current: page }))}
              onPageSizeChange={(pageSize) =>
                setPagination((p) => ({ ...p, pageSize, current: 1 }))
              }
            />
          </div>
      </div>
      {selectedRowKeys.length > 0 && (
        <div className="fixed bottom-0 left-64 right-0 border-t bg-background p-4 flex flex-wrap items-center gap-3">
          <span className="text-sm font-medium">{selectedRowKeys.length} сонгосон · {selectedTotal.toLocaleString()} ₮</span>
          <Button variant="outline" onClick={handlePrint}>Хэвлэх</Button>
          {hasPermission("delivery:excel_import_delivery") && (
            <>
              <Button onClick={() => setIsAllocateOpen(true)}>Жолоочид хуваарилах</Button>
              <Button variant="destructive" onClick={() => setIsDeleteOpen(true)}><Trash2 className="h-4 w-4" /> Устгах</Button>
              <Button variant="outline" onClick={() => {
                setBulkDeliveryDate(getTodayLocal());
                setIsDeliveryDateOpen(true);
              }}>Хүргэх огноо тохируулах</Button>
              <Button variant="outline" onClick={async () => {
                const res = await fetch(`${API}/api/status`);
                const result = await res.json();
                if (result.success) { setStatusOptions(result.data); setIsStatusOpen(true); }
              }}>Төлөв солих</Button>
              <Button variant="outline" onClick={() => {
                const selectedRows = deliveryData.filter((item) => selectedRowKeys.includes(item.id));
                const excelData = selectedRows.map((row) => ({
                  ID: row.id,
                  "Шивсэн огноо": dayjs(row.createdAt).format("YYYY-MM-DD HH:mm"),
                  "Хүргэх огноо": row.delivery_date
                    ? dayjs(row.delivery_date).format("YYYY-MM-DD")
                    : dayjs(row.createdAt).format("YYYY-MM-DD"),
                  Дэлгүүр: row.merchant?.username ?? "-",
                  Дүүрэг: districtName(row.district_id),
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
        <SheetContent className="overflow-y-auto overflow-x-visible sm:max-w-md px-6 flex flex-col">
          <SheetHeader className="px-0 pb-2">
            <SheetTitle>Хүргэлт үүсгэх</SheetTitle>
            <p className="text-xs text-muted-foreground">
              Ганцаар үүсгэх эсвэл сагсанд овоолж бөөнөөр үүсгэх
            </p>
          </SheetHeader>

          {createCart.length > 0 && (
            <div className="mb-3 rounded-lg border border-emerald-200 bg-emerald-50/80 p-3 space-y-2 shrink-0">
              <div className="flex items-center justify-between gap-2">
                <div className="flex items-center gap-2 text-sm font-semibold text-emerald-900">
                  <ShoppingCart className="h-4 w-4" />
                  Сагс ({createCart.length})
                </div>
                <Button
                  type="button"
                  size="sm"
                  className="bg-emerald-700 hover:bg-emerald-800"
                  disabled={isCreatingBulk}
                  onClick={() => void handleCreateCart()}
                >
                  {isCreatingBulk ? "Үүсгэж байна..." : `${createCart.length} хүргэлт үүсгэх`}
                </Button>
              </div>
              <div className="max-h-40 overflow-y-auto space-y-2">
                {createCart.map((item, index) => (
                  <div
                    key={item.id}
                    className="flex items-start justify-between gap-2 rounded-md border border-emerald-200 bg-white px-3 py-2"
                  >
                    <div className="min-w-0 text-sm">
                      <div className="font-medium truncate">
                        #{index + 1} · {item.display.phone}
                      </div>
                      <div className="text-xs text-muted-foreground truncate">
                        {item.display.address}
                      </div>
                      <div className="text-xs text-muted-foreground mt-0.5">
                        {item.display.merchantName} · {item.display.districtName} ·{" "}
                        {item.display.price.toLocaleString()} ₮
                        {item.display.itemCount > 0 ? ` · ${item.display.itemCount} бараа` : ""}
                      </div>
                    </div>
                    <Button
                      type="button"
                      variant="ghost"
                      size="icon"
                      className="h-7 w-7 shrink-0 text-destructive"
                      disabled={isCreatingBulk}
                      onClick={() => setCreateCart((prev) => prev.filter((x) => x.id !== item.id))}
                    >
                      <Trash2 className="h-3.5 w-3.5" />
                    </Button>
                  </div>
                ))}
              </div>
            </div>
          )}

          <form
            className="space-y-5 mt-2 flex-1"
            onSubmit={(e) => {
              e.preventDefault();
              if (createCart.length > 0) void handleCreateCart();
              else void handleCreate();
            }}
          >
            {!isMerchant && (
              <div className="space-y-2">
                <Label>Дэлгүүр</Label>
                <SearchableSelect
                  value={createForm.merchantId}
                  onValueChange={(v) => setCreateForm((p) => ({ ...p, merchantId: v }))}
                  placeholder="Дэлгүүр сонгох"
                  searchPlaceholder="Дэлгүүр хайх..."
                  options={merchants.map((m) => ({ value: String(m.id), label: m.username }))}
                />
              </div>
            )}
            <div className="space-y-2"><Label>Утас</Label><Input value={createForm.phone} onChange={(e) => setCreateForm((p) => ({ ...p, phone: e.target.value }))} /></div>
            <div className="space-y-2">
              <Label>Дүүрэг</Label>
              <select
                value={createForm.districtId}
                onChange={(e) => setCreateForm((p) => ({ ...p, districtId: e.target.value }))}
                onKeyDown={(e) => {
                  if (e.key !== "Tab") return;
                  e.preventDefault();
                  const ids = DISTRICTS.map((d) => String(d.id));
                  const current = createForm.districtId;
                  const idx = ids.indexOf(current);
                  let nextIdx: number;
                  if (e.shiftKey) {
                    nextIdx = idx <= 0 ? ids.length - 1 : idx - 1;
                  } else if (idx < 0) {
                    nextIdx = 0;
                  } else {
                    nextIdx = idx >= ids.length - 1 ? 0 : idx + 1;
                  }
                  setCreateForm((p) => ({ ...p, districtId: ids[nextIdx] }));
                }}
                className="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2"
              >
                <option value="" disabled>
                  Дүүрэг сонгох
                </option>
                {DISTRICTS.map((d) => (
                  <option key={d.id} value={String(d.id)}>
                    {d.name}
                  </option>
                ))}
              </select>
              <p className="text-[11px] text-muted-foreground">Tab / Shift+Tab — дүүрэг солих</p>
            </div>
            <div className="space-y-2">
              <Label>Хүргэх огноо</Label>
              <Input type="date" value={createForm.deliveryDate} onChange={(e) => setCreateForm((p) => ({ ...p, deliveryDate: e.target.value }))} />
            </div>
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
                  <SearchableSelect
                    className="flex-1"
                    value={selectedProduct}
                    onValueChange={setSelectedProduct}
                    placeholder="Бараа"
                    searchPlaceholder="Бараа хайх..."
                    options={products.map((p) => ({ value: p.id, label: p.name }))}
                  />
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
                    <button type="button" className="text-destructive" onClick={() => setProductList((p) => p.filter((x) => x.productId !== item.productId))}>Устгах</button>
                  </div>
                ))}
              </div>
            )}
            <div className="sticky bottom-0 -mx-1 pt-3 pb-1 space-y-2 border-t bg-background">
              <Button
                type="button"
                variant="outline"
                className="w-full border-emerald-700 text-emerald-800 hover:bg-emerald-50"
                onClick={handleAddToCart}
                disabled={isCreatingBulk}
              >
                <PackagePlus className="h-4 w-4" />
                Сагсанд нэмэх
              </Button>
              {createCart.length === 0 ? (
                <Button type="submit" className="w-full" disabled={isCreatingBulk}>
                  Үүсгэх
                </Button>
              ) : (
                <Button
                  type="button"
                  className="w-full bg-emerald-700 hover:bg-emerald-800"
                  disabled={isCreatingBulk}
                  onClick={() => void handleCreateCart()}
                >
                  {isCreatingBulk
                    ? "Үүсгэж байна..."
                    : `Хадгалсан ${createCart.length} хүргэлтийг үүсгэх`}
                </Button>
              )}
            </div>
          </form>
        </SheetContent>
      </Sheet>

      <Dialog open={isEditOpen} onOpenChange={setIsEditOpen}>
        <DialogContent>
          <DialogHeader><DialogTitle>Хүргэлт засах</DialogTitle></DialogHeader>
          <div className="space-y-4 py-2">
            <div className="space-y-2"><Label>Утас</Label><Input value={editForm.phone} onChange={(e) => setEditForm((p) => ({ ...p, phone: e.target.value }))} /></div>
            <div className="space-y-2">
              <Label>Дүүрэг</Label>
              <SearchableSelect
                value={editForm.districtId}
                onValueChange={(v) => setEditForm((p) => ({ ...p, districtId: v }))}
                placeholder="Дүүрэг сонгох"
                searchPlaceholder="Дүүрэг хайх..."
                options={DISTRICTS.map((d) => ({ value: String(d.id), label: d.name }))}
              />
            </div>
            <div className="space-y-2"><Label>Хаяг</Label><Input value={editForm.address} onChange={(e) => setEditForm((p) => ({ ...p, address: e.target.value }))} /></div>
            <div className="space-y-2">
              <Label>Хүргэх огноо</Label>
              <Input type="date" value={editForm.deliveryDate} onChange={(e) => setEditForm((p) => ({ ...p, deliveryDate: e.target.value }))} />
            </div>
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

      <Dialog open={isDeliveryDateOpen} onOpenChange={setIsDeliveryDateOpen}>
        <DialogContent>
          <DialogHeader><DialogTitle>Хүргэх огноо тохируулах</DialogTitle></DialogHeader>
          <div className="space-y-2">
            <Label htmlFor="bulk-delivery_date">Хүргэх огноо *</Label>
            <Input
              id="bulk-delivery_date"
              type="date"
              value={bulkDeliveryDate}
              onChange={(e) => setBulkDeliveryDate(e.target.value)}
            />
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setIsDeliveryDateOpen(false)}>Цуцлах</Button>
            <Button onClick={handleSaveDeliveryDate}>Хадгалах</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      <Dialog open={isAllocateOpen} onOpenChange={setIsAllocateOpen}>
        <DialogContent>
          <DialogHeader><DialogTitle>Жолооч сонгох</DialogTitle></DialogHeader>
          <SearchableSelect
            value={selectedDriverId}
            onValueChange={setSelectedDriverId}
            placeholder="Жолооч"
            searchPlaceholder="Жолооч хайх..."
            options={drivers.map((d) => ({ value: String(d.id), label: d.username }))}
          />
          <DialogFooter>
            <Button variant="outline" onClick={() => setIsAllocateOpen(false)}>Цуцлах</Button>
            <Button onClick={handleAllocate}>Хадгалах</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      <Dialog open={isStatusOpen} onOpenChange={setIsStatusOpen}>
        <DialogContent>
          <DialogHeader><DialogTitle>Төлөв сонгох</DialogTitle></DialogHeader>
          <SearchableSelect
            value={selectStatusId}
            onValueChange={setSelectedStatusId}
            placeholder="Төлөв"
            searchPlaceholder="Төлөв хайх..."
            options={statusOptions.map((s) => ({ value: String(s.id), label: s.status }))}
          />
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
