"use client";

import { useState, useEffect } from "react";
import { toast } from "sonner";
import { useQueryClient } from "@tanstack/react-query";
import { useWares } from "@/hooks/use-lookups";
import { queryKeys } from "@/lib/api";
import WarehouseTable from "./components/WarehouseTable";
import WarehouseForm from "./components/WarehouseForm";
import { Button } from "@/components/ui/button";
import { Warehouse } from "./types/warehouse";
import { createWarehouse, deleteWarehouse } from "./services/warehouse.service";

export default function WarehousePage() {
  const queryClient = useQueryClient();
  const { data: warehouses = [], isFetching: loading } = useWares();
  const [isDrawerOpen, setIsDrawerOpen] = useState(false);

  useEffect(() => {
    document.title = "Агуулах";
  }, []);

  const invalidate = () => queryClient.invalidateQueries({ queryKey: queryKeys.wares });

  const handleCreateWarehouse = async (payload: { name: string }) => {
    try {
      await createWarehouse(payload);
      await invalidate();
      toast.success("Агуулах амжилттай үүсгэгдлээ");
      setIsDrawerOpen(false);
    } catch (error: any) {
      toast.error(error.message || "Агуулах үүсгэхэд алдаа гарлаа");
    }
  };

  const handleDeleteWarehouse = (warehouse: Warehouse) => {
    if (!confirm(`Та "${warehouse.name}" агуулхыг устгахдаа итгэлтэй байна уу?`)) {
      return;
    }

    const deleteWarehouseAsync = async () => {
      try {
        await deleteWarehouse(warehouse.id);
        await invalidate();
        toast.success(`"${warehouse.name}" агуулах амжилттай устгагдлаа`);
      } catch (error: any) {
        toast.error(error.message || "Устгахад алдаа гарлаа");
      }
    };

    deleteWarehouseAsync();
  };

  return (
    <div className="w-full mt-6 px-4 pb-32">
      <div className="mb-6 flex items-center justify-between">
        <h1 className="text-3xl font-bold text-gray-900">Агуулах</h1>
        <Button onClick={() => setIsDrawerOpen(true)}>+ Агуулах үүсгэх</Button>
      </div>

      <WarehouseTable
        warehouses={warehouses as Warehouse[]}
        loading={loading}
        onDelete={handleDeleteWarehouse}
      />

      <WarehouseForm
        isOpen={isDrawerOpen}
        onClose={() => setIsDrawerOpen(false)}
        onSubmit={handleCreateWarehouse}
      />
    </div>
  );
}
