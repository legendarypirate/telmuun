"use client";

import React, { useEffect, useState } from "react";
import { toast } from "sonner";
import { Folder, User } from "lucide-react";
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
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";

interface Merchant {
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
}

export default function MerchantsPage() {
  const [merchants, setMerchants] = useState<Merchant[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [modalVisible, setModalVisible] = useState(false);
  const [selectedMerchant, setSelectedMerchant] = useState<Merchant | null>(null);
  const [bulks, setBulks] = useState<Bulk[]>([]);
  const [bulkLoading, setBulkLoading] = useState(false);
  const [searchTerm, setSearchTerm] = useState("");
  const [page, setPage] = useState(1);
  const pageSize = 10;

  useEffect(() => {
    const fetchMerchants = async () => {
      try {
        const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/user/merchant`);
        if (!response.ok) throw new Error(`Failed to fetch merchants: ${response.status}`);
        const data = await response.json();
        if (data.success) setMerchants(data.data);
        else throw new Error("API returned unsuccessful response");
      } catch (err) {
        setError(err instanceof Error ? err.message : "An error occurred");
      } finally {
        setLoading(false);
      }
    };
    fetchMerchants();
  }, []);

  const fetchBulkReport = async (merchant: Merchant) => {
    setBulkLoading(true);
    try {
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/delivery/bulkreport?merchant_id=${merchant.id}`);
      if (!response.ok) throw new Error(`Failed to fetch bulk report: ${response.status}`);
      const data = await response.json();
      if (data.success) {
        setBulks(data.data);
        setSelectedMerchant(merchant);
        setModalVisible(true);
      } else {
        toast.error(data.message || "No bulk report found for this merchant.");
        setBulks([]);
        setSelectedMerchant(merchant);
        setModalVisible(true);
      }
      setPage(1);
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Error fetching bulk report");
    } finally {
      setBulkLoading(false);
    }
  };

  if (error) {
    return (
      <div className="p-6">
        <p className="font-semibold">Error Loading Merchants</p>
        <p className="text-sm text-muted-foreground">{error}</p>
      </div>
    );
  }

  if (loading) {
    return (
      <div className="p-6 text-center">
        <p>Loading merchants...</p>
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
            <User className="h-6 w-6" /> Харилцагчийн тайлан
          </h2>
          <p className="text-sm text-muted-foreground">{merchants.length} харилцагч</p>
        </div>
        <Input
          placeholder="Харилцагчийн нэрээр хайх..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="max-w-xs"
        />

        <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4">
          {merchants
            .filter((merchant) => (merchant.username || "").toLowerCase().includes(searchTerm.toLowerCase().trim()))
            .map((merchant) => (
              <Card
                key={merchant.id}
                className="min-h-[140px] cursor-pointer text-center"
                onClick={() => fetchBulkReport(merchant)}
              >
                <CardContent className="flex flex-col items-center px-2 py-4">
                  <Folder className="mb-3 h-10 w-10 text-gray-900" />
                  <p className="text-sm font-semibold">{merchant.username}</p>
                  <p className="mt-1 text-xs text-muted-foreground">ID: {merchant.id}</p>
                </CardContent>
              </Card>
            ))}
        </div>
      </div>

      <Dialog open={modalVisible} onOpenChange={setModalVisible}>
        <DialogContent className="sm:max-w-[900px] max-h-[70vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle>Bulk Report - {selectedMerchant?.username || ""}</DialogTitle>
          </DialogHeader>
          {bulkLoading ? (
            <p className="py-6 text-center text-muted-foreground">Loading bulk report...</p>
          ) : bulks.length === 0 ? (
            <p className="text-muted-foreground">No bulk records found.</p>
          ) : (
            <>
              <div className="border rounded-md">
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>ID</TableHead>
                      <TableHead>Merchant ID</TableHead>
                      <TableHead>Driver ID</TableHead>
                      <TableHead>Count</TableHead>
                      <TableHead>Delivered Count</TableHead>
                      <TableHead>Amount</TableHead>
                      <TableHead>Diff</TableHead>
                      <TableHead>Paid</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {paged.map((record) => (
                      <TableRow key={record.id}>
                        <TableCell>{record.id}</TableCell>
                        <TableCell>{record.merchant_id}</TableCell>
                        <TableCell>{record.driver_id}</TableCell>
                        <TableCell>{record.count}</TableCell>
                        <TableCell>{record.deliveredCount}</TableCell>
                        <TableCell>{record.amount}</TableCell>
                        <TableCell>{record.diff}</TableCell>
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
        </DialogContent>
      </Dialog>
    </div>
  );
}
