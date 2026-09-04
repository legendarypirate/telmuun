"use client";

import { useState, useEffect, useMemo } from 'react';
import { toast } from 'sonner';
import { useQueryClient } from '@tanstack/react-query';
import { useGoods, useMerchants, useWares } from '@/hooks/use-lookups';
import { queryKeys } from '@/lib/api';
import GoodTable from './components/GoodTable';
import GoodForm from './components/GoodForm';
import { StockUpdateModal, EditGoodNameModal } from './components/GoodModals';
import { GoodHistoryModal } from './components/GoodHistoryModal';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { Good } from './types/good';
import {
  createGood,
  deleteGood,
  updateStock,
  updateGood,
} from './services/good.service';

export default function GoodPage() {
  // State
  const [merchantFilter, setMerchantFilter] = useState<number | null>(null);
  const [searchTerm, setSearchTerm] = useState<string>('');
  const queryClient = useQueryClient();

  // Form/Drawer
  const [isDrawerOpen, setIsDrawerOpen] = useState(false);

  // Modals
  const [isStockModalOpen, setIsStockModalOpen] = useState(false);
  const [isEditNameModalOpen, setIsEditNameModalOpen] = useState(false);
  const [isHistoryModalOpen, setIsHistoryModalOpen] = useState(false);
  const [selectedGood, setSelectedGood] = useState<Good | null>(null);

  const { data: merchants = [] } = useMerchants();
  const { data: wares = [] } = useWares();

  // User info
  const [user, setUser] = useState<any>(null);
  const [username, setUsername] = useState<string | null>(null);
  const isMerchant = user ? (user?.role === 2 || user?.role_id === 2) : false;
  const merchantId = isMerchant ? (user?.id || user?.user_id || null) : null;

  // Load initial data
  useEffect(() => {
    document.title = 'Агуулахын бараа';

    const storedUser = typeof window !== 'undefined' ? localStorage.getItem('user') : null;
    const storedUsername =
      typeof window !== 'undefined' ? localStorage.getItem('username') : null;

    if (storedUser) {
      try {
        setUser(JSON.parse(storedUser));
      } catch (e) {
        console.error('Failed to parse user:', e);
      }
    }
    if (storedUsername) setUsername(storedUsername);
  }, []);

  const currentMerchantId = isMerchant ? merchantId : undefined;
  const { data: goods = [], isFetching: loading } = useGoods(currentMerchantId || undefined);

  const filteredGoods = useMemo(() => {
    let filtered = goods as Good[];
    if (merchantFilter != null) {
      filtered = filtered.filter(
        (good) => (good.merchant_id ?? good.merchant?.id) === merchantFilter
      );
    }
    if (searchTerm.trim()) {
      const searchLower = searchTerm.toLowerCase().trim();
      filtered = filtered.filter((good) =>
        (good.name || '').toLowerCase().includes(searchLower)
      );
    }
    return filtered;
  }, [goods, merchantFilter, searchTerm]);

  const invalidateGoods = () => queryClient.invalidateQueries({ queryKey: queryKeys.goods(currentMerchantId || undefined) });

  // Handlers
  const handleCreateGood = async (payload: any) => {
    try {
      await createGood(payload);
      await invalidateGoods();
      toast.success('Бараа амжилттай үүсгэгдлээ');
      setIsDrawerOpen(false);
    } catch (error: any) {
      toast.error(error.message || 'Бараа үүсгэхэд алдаа гарлаа');
    }
  };

  const handleDeleteGood = (good: Good) => {
    if (!confirm(`Та "${good.name}" барааг устгахдаа итгэлтэй байна уу?`)) {
      return;
    }

    const deleteGoodAsync = async () => {
      try {
        await deleteGood(good.id);
        await invalidateGoods();
        toast.success(`"${good.name}" бараа амжилттай устгагдлаа`);
      } catch (error: any) {
        toast.error(error.message || 'Устгахад алдаа гарлаа');
      }
    };

    deleteGoodAsync();
  };

  const handleEditClick = (good: Good) => {
    setSelectedGood(good);
    setIsStockModalOpen(true);
  };

  const handleEditNameClick = (good: Good) => {
    setSelectedGood(good);
    setIsEditNameModalOpen(true);
  };

  const handleSaveGoodName = async (name: string) => {
    if (!selectedGood) return;
    try {
      await updateGood(selectedGood.id, { name });
      await invalidateGoods();
      setIsEditNameModalOpen(false);
      setSelectedGood(null);
      toast.success('Барааны нэр амжилттай шинэчлэгдлээ');
    } catch (error: any) {
      toast.error(error.message || 'Хадгалахад алдаа гарлаа');
      throw error;
    }
  };

  const handleHistoryClick = (good: Good) => {
    setSelectedGood(good);
    setIsHistoryModalOpen(true);
  };

  const handleStockUpdate = async (values: { type: number; amount: number }) => {
    if (!selectedGood) return;

    try {
      await updateStock({
        id: selectedGood.id,
        type: values.type,
        amount: values.amount,
      });
      await invalidateGoods();
      setIsStockModalOpen(false);
      setSelectedGood(null);

      if (values.type === 1) {
        toast.success('Амжилттай орлогодолоо');
      } else if (values.type === 2) {
        toast.warning('Амжилттай зарлагадлаа');
      }
    } catch (error: any) {
      toast.error(error.message || 'Үлдэгдэл шинэчлэхэд алдаа гарлаа');
    }
  };

  return (
    <div className="w-full mt-6 px-4 pb-32">
      <div className="mb-6 flex items-center justify-between">
        <h1 className="text-3xl font-bold text-gray-900">Агуулахын бараа</h1>
        {!isMerchant && (
          <Button onClick={() => setIsDrawerOpen(true)}>+ Бараа үүсгэх</Button>
        )}
      </div>

      {!isMerchant && (
        <div className="mb-4 flex items-center gap-4">
          <Select
            value={merchantFilter?.toString() || 'all'}
            onValueChange={(value) => setMerchantFilter(value === 'all' ? null : parseInt(value))}
          >
            <SelectTrigger className="w-48">
              <SelectValue placeholder="Дэлгүүрээр шүүх" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">Бүгд</SelectItem>
              {merchants
                .filter((merchant) => merchant?.id != null)
                .map((merchant) => (
                  <SelectItem key={merchant.id} value={String(merchant.id)}>
                    {merchant.username || `ID ${merchant.id}`}
                  </SelectItem>
                ))}
            </SelectContent>
          </Select>
          <Input
            type="text"
            placeholder="Барааны нэрээр хайх..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="w-64"
          />
        </div>
      )}
      {isMerchant && (
        <div className="mb-4">
          <Input
            type="text"
            placeholder="Барааны нэрээр хайх..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="w-64"
          />
        </div>
      )}

      <GoodTable
        goods={filteredGoods}
        loading={loading}
        onEdit={handleEditClick}
        onEditName={!isMerchant ? handleEditNameClick : undefined}
        onDelete={handleDeleteGood}
        onHistory={handleHistoryClick}
        isMerchant={isMerchant}
      />

      {/* Drawer */}
      <GoodForm
        isOpen={isDrawerOpen}
        onClose={() => setIsDrawerOpen(false)}
        onSubmit={handleCreateGood}
        merchants={merchants}
        wares={wares}
        isMerchant={isMerchant}
        merchantId={merchantId || undefined}
        username={username || undefined}
      />

      {/* Stock Update Modal */}
      <StockUpdateModal
        isOpen={isStockModalOpen}
        onClose={() => {
          setIsStockModalOpen(false);
          setSelectedGood(null);
        }}
        onSave={handleStockUpdate}
        good={selectedGood}
      />

      <EditGoodNameModal
        isOpen={isEditNameModalOpen}
        onClose={() => {
          setIsEditNameModalOpen(false);
          setSelectedGood(null);
        }}
        onSave={handleSaveGoodName}
        good={selectedGood}
      />

      {/* History Modal */}
      <GoodHistoryModal
        isOpen={isHistoryModalOpen}
        onClose={() => {
          setIsHistoryModalOpen(false);
          setSelectedGood(null);
        }}
        good={selectedGood}
      />
    </div>
  );
}

