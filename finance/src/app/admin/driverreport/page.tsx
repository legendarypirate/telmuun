"use client";

import React, { useEffect, useState } from "react";
import { toast } from "sonner";
import { Folder, User, X, Save } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent } from "@/components/ui/card";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";

interface Driver {
  id: number;
  username: string;
}

interface Bulk {
  id: number;
  driver_id: number | null;
  merchant_id: number | null;
  count: number;
  amount: number;
  diff: number;
  paid: number;
  deliveredCount: number;
  report_date?: string;
}

export default function DriversPage() {
  const [drivers, setDrivers] = useState<Driver[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [panelVisible, setPanelVisible] = useState(false);
  const [selectedDriver, setSelectedDriver] = useState<Driver | null>(null);
  const [bulks, setBulks] = useState<Bulk[]>([]);
  const [bulkLoading, setBulkLoading] = useState(false);
  const [editingAmounts, setEditingAmounts] = useState<{ [key: number]: number }>({});
  const [editingDiffs, setEditingDiffs] = useState<{ [key: number]: number }>({});
  const [saving, setSaving] = useState<{ id: number; type: "amount" | "diff" } | null>(null);
  const [searchTerm, setSearchTerm] = useState("");
  const [page, setPage] = useState(1);
  const pageSize = 5;

  useEffect(() => {
    const fetchDrivers = async () => {
      try {
        const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/user/driver`);
        if (!response.ok) throw new Error(`Failed to fetch drivers: ${response.status}`);
        const data = await response.json();
        if (data.success) setDrivers(data.data);
        else throw new Error("API returned unsuccessful response");
      } catch (err) {
        setError(err instanceof Error ? err.message : "An error occurred");
      } finally {
        setLoading(false);
      }
    };
    fetchDrivers();
  }, []);

  const fetchBulkReport = async (driver: Driver) => {
    setBulkLoading(true);
    try {
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/delivery/bulkreport?driver_id=${driver.id}`);
      if (!response.ok) throw new Error(`Failed to fetch bulk report: ${response.status}`);
      const data = await response.json();
      if (data.success) {
        setBulks(data.data);
        const initialAmounts: { [key: number]: number } = {};
        const initialDiffs: { [key: number]: number } = {};
        data.data.forEach((bulk: Bulk) => {
          initialAmounts[bulk.id] = bulk.amount;
          initialDiffs[bulk.id] = bulk.diff;
        });
        setEditingAmounts(initialAmounts);
        setEditingDiffs(initialDiffs);
      } else {
        toast.error(data.message || "No bulk report found for this driver.");
        setBulks([]);
      }
      setSelectedDriver(driver);
      setPanelVisible(true);
      setPage(1);
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Error fetching bulk report");
    } finally {
      setBulkLoading(false);
    }
  };

  const handleAmountChange = (bulkId: number, value: string) => {
    const numValue = parseFloat(value) || 0;
    setEditingAmounts((prev) => ({
      ...prev,
      [bulkId]: numValue,
    }));
  };

  const handleDiffChange = (bulkId: number, value: string) => {
    const numValue = parseFloat(value) || 0;
    setEditingDiffs((prev) => ({
      ...prev,
      [bulkId]: numValue,
    }));
  };

  const updateBulkAmount = async (bulkId: number) => {
    setSaving({ id: bulkId, type: "amount" });
    try {
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/delivery/bulk/${bulkId}`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          amount: editingAmounts[bulkId],
        }),
      });

      if (!response.ok) throw new Error(`Failed to update amount: ${response.status}`);
      const data = await response.json();
      if (data.success) {
        setBulks((prev) =>
          prev.map((bulk) => (bulk.id === bulkId ? { ...bulk, amount: editingAmounts[bulkId] } : bulk))
        );
        toast.success("Amount updated successfully");
      } else {
        throw new Error(data.message || "Failed to update amount");
      }
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Error updating amount");
      const originalAmount = bulks.find((b) => b.id === bulkId)?.amount || 0;
      setEditingAmounts((prev) => ({
        ...prev,
        [bulkId]: originalAmount,
      }));
    } finally {
      setSaving(null);
    }
  };

  const updateBulkDiff = async (bulkId: number) => {
    setSaving({ id: bulkId, type: "diff" });
    try {
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/delivery/bulk/${bulkId}/diff`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          diff: editingDiffs[bulkId],
        }),
      });

      if (!response.ok) throw new Error(`Failed to update diff: ${response.status}`);
      const data = await response.json();
      if (data.success) {
        setBulks((prev) =>
          prev.map((bulk) => (bulk.id === bulkId ? { ...bulk, diff: editingDiffs[bulkId] } : bulk))
        );
        toast.success("Зөрүү updated successfully");
      } else {
        throw new Error(data.message || "Failed to update diff");
      }
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Error updating diff");
      const originalDiff = bulks.find((b) => b.id === bulkId)?.diff || 0;
      setEditingDiffs((prev) => ({
        ...prev,
        [bulkId]: originalDiff,
      }));
    } finally {
      setSaving(null);
    }
  };

  const handleClosePanel = () => {
    setPanelVisible(false);
    setSelectedDriver(null);
    setBulks([]);
    setEditingAmounts({});
    setEditingDiffs({});
  };

  if (error) {
    return (
      <div className="p-6">
        <p className="font-semibold">Error Loading Drivers</p>
        <p className="text-sm text-muted-foreground">{error}</p>
      </div>
    );
  }

  if (loading) {
    return (
      <div className="p-6 text-center">
        <p>Loading drivers...</p>
      </div>
    );
  }

  const paged = bulks.slice((page - 1) * pageSize, page * pageSize);
  const pageCount = Math.max(1, Math.ceil(bulks.length / pageSize));

  return (
    <div className="min-h-full">
      <div className="space-y-6">
        <div>
          <h2 className="flex items-center gap-2 text-2xl font-bold text-gray-900">
            <User className="h-6 w-6" /> Жолоочийн тайлан
          </h2>
          <p className="text-sm text-muted-foreground">{drivers.length} жолооч</p>
        </div>
        <Input
          placeholder="Жолоочийн нэрээр хайх..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="max-w-xs"
        />

        <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4">
          {drivers
            .filter((driver) => (driver.username || "").toLowerCase().includes(searchTerm.toLowerCase().trim()))
            .map((driver) => (
              <Card
                key={driver.id}
                className="min-h-[140px] cursor-pointer text-center"
                onClick={() => fetchBulkReport(driver)}
              >
                <CardContent className="flex flex-col items-center px-2 py-4">
                  <Folder className="mb-3 h-10 w-10 text-gray-900" />
                  <p className="text-sm font-semibold">{driver.username}</p>
                  <p className="mt-1 text-xs text-muted-foreground">ID: {driver.id}</p>
                </CardContent>
              </Card>
            ))}
        </div>
      </div>

      {panelVisible && (
        <div className="fixed bottom-0 left-0 right-0 z-[1000] flex max-h-[65vh] flex-col border-t bg-white shadow-lg">
          <div className="flex items-center justify-between bg-gray-900 px-6 py-4 text-white">
            <h4 className="text-lg font-semibold">
              Bulk Report - {selectedDriver?.username} (ID: {selectedDriver?.id})
            </h4>
            <Button variant="ghost" size="sm" className="text-white" onClick={handleClosePanel}>
              <X className="h-4 w-4" />
            </Button>
          </div>

          <div className="flex-1 overflow-auto px-6 py-4">
            {bulkLoading ? (
              <p className="py-5 text-center text-muted-foreground">Loading bulk report...</p>
            ) : bulks.length === 0 ? (
              <p className="py-5 text-center text-muted-foreground">No bulk records found.</p>
            ) : (
              <>
                <div className="border rounded-md">
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead>Тайлангйин огноо</TableHead>
                        <TableHead>Тоо</TableHead>
                        <TableHead>Хүргэгдсэн</TableHead>
                        <TableHead>Дүн</TableHead>
                        <TableHead>Зөрүү</TableHead>
                        <TableHead>Хүргэлтэнд гарса</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {paged.map((record) => (
                        <TableRow key={record.id}>
                          <TableCell>{record.report_date ? new Date(record.report_date).toISOString().slice(0, 10) : "-"}</TableCell>
                          <TableCell>{record.count}</TableCell>
                          <TableCell>{record.deliveredCount}</TableCell>
                          <TableCell>
                            <div className="flex items-center gap-2">
                              <Input
                                type="number"
                                className="w-[120px] text-right text-sm"
                                value={editingAmounts[record.id]}
                                onChange={(e) => handleAmountChange(record.id, e.target.value)}
                              />
                              <Button size="sm" disabled={saving?.id === record.id && saving?.type === "amount"} onClick={() => updateBulkAmount(record.id)}>
                                <Save className="h-4 w-4" />
                              </Button>
                            </div>
                          </TableCell>
                          <TableCell>
                            <div className="flex items-center gap-2">
                              <Input
                                type="number"
                                className="w-[120px] text-right text-sm"
                                value={editingDiffs[record.id]}
                                onChange={(e) => handleDiffChange(record.id, e.target.value)}
                              />
                              <Button size="sm" disabled={saving?.id === record.id && saving?.type === "diff"} onClick={() => updateBulkDiff(record.id)}>
                                <Save className="h-4 w-4" />
                              </Button>
                            </div>
                          </TableCell>
                          <TableCell>{record.paid}</TableCell>
                        </TableRow>
                      ))}
                    </TableBody>
                  </Table>
                </div>
                <div className="mt-3 flex items-center gap-2">
                  <Button variant="outline" size="sm" disabled={page <= 1} onClick={() => setPage((p) => p - 1)}>Өмнөх</Button>
                  <span className="text-sm">{page} / {pageCount}</span>
                  <Button variant="outline" size="sm" disabled={page >= pageCount} onClick={() => setPage((p) => p + 1)}>Дараах</Button>
                </div>
              </>
            )}
          </div>

          <div className="flex items-center justify-between border-t bg-muted/40 px-6 py-3">
            <span className="text-sm text-muted-foreground">Total Records: {bulks.length}</span>
            <Button variant="outline" onClick={handleClosePanel}>Close</Button>
          </div>
        </div>
      )}
    </div>
  );
}
