"use client";

import { useState, useEffect, useMemo } from 'react';
import { toast } from 'sonner';
import { useQueryClient } from '@tanstack/react-query';
import { useGoods, useGoodRequests, useMerchants, useWares } from '@/hooks/use-lookups';
import { queryKeys } from '@/lib/api';
import GoodRequestTable from './components/GoodRequestTable';
import GoodRequestForm from './components/GoodRequestForm';
import ApproveRequestModal from './components/ApproveRequestModal';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { SearchableSelect } from '@/components/ui/searchable-select';
import { GoodRequest } from './types/good-request';
import {
  createGoodRequest,
  approveRequest,
  declineRequest,
} from './services/good-request.service';
import { formatDateLocal } from '@/lib/utils';

const PAGE_SIZE = 100;

export default function GoodRequestPage() {
  // State
  const [statusFilter, setStatusFilter] = useState<number | null>(null);
  const [typeFilter, setTypeFilter] = useState<number | null>(null);
  const [merchantFilter, setMerchantFilter] = useState<number | null>(null);
  const [searchTerm, setSearchTerm] = useState<string>('');
  const [dateRange, setDateRange] = useState<[Date | null, Date | null]>([null, null]);
  const [pagination, setPagination] = useState({ current: 1, total: 0 });

  // Form/Drawer
  const [isDrawerOpen, setIsDrawerOpen] = useState(false);
  const [isApproveModalOpen, setIsApproveModalOpen] = useState(false);
  const [selectedRequest, setSelectedRequest] = useState<GoodRequest | null>(null);

  const queryClient = useQueryClient();

  // User info
  const [user, setUser] = useState<any>(null);
  const isMerchant = user ? (user?.role === 2 || user?.role_id === 2) : false;
  const merchantId = isMerchant ? (user?.id || user?.user_id || null) : null;

  useEffect(() => {
    const storedUser = typeof window !== 'undefined' ? localStorage.getItem('user') : null;
    if (storedUser) {
      try {
        setUser(JSON.parse(storedUser));
      } catch (e) {
        console.error('Failed to parse user:', e);
      }
    }
  }, []);

  const requestMerchantId = isMerchant ? merchantId || undefined : undefined;
  const { data: requests = [], isFetching: loading } = useGoodRequests(requestMerchantId, !!user);
  const { data: goods = [] } = useGoods(isMerchant ? merchantId || undefined : undefined);
  const { data: wares = [] } = useWares();
  const { data: merchants = [] } = useMerchants();

  const filteredRequests = useMemo(() => {
    let filtered = requests as GoodRequest[];
    if (statusFilter !== null) {
      filtered = filtered.filter((request) => request.status === statusFilter);
    }
    if (typeFilter !== null) {
      filtered = filtered.filter((request) => request.type === typeFilter);
    }
    if (merchantFilter !== null) {
      filtered = filtered.filter((request) => request.merchant_id === merchantFilter);
    }
    if (searchTerm.trim()) {
      const searchLower = searchTerm.toLowerCase().trim();
      filtered = filtered.filter((request) => {
        const goodName = request.good?.name || request.name || '';
        return goodName.toLowerCase().includes(searchLower);
      });
    }
    const [startDate, endDate] = dateRange;
    if (startDate || endDate) {
      const startStr = startDate ? formatDateLocal(startDate) : null;
      const endStr = endDate ? formatDateLocal(endDate) : null;
      filtered = filtered.filter((request) => {
        const requestDate = formatDateLocal(new Date(request.createdAt));
        if (startStr && requestDate < startStr) return false;
        if (endStr && requestDate > endStr) return false;
        return true;
      });
    }
    return filtered;
  }, [requests, statusFilter, typeFilter, merchantFilter, searchTerm, dateRange]);

  useEffect(() => {
    setPagination({ current: 1, total: filteredRequests.length });
  }, [filteredRequests.length, statusFilter, typeFilter, merchantFilter, searchTerm, dateRange]);

  const invalidateRequests = () =>
    queryClient.invalidateQueries({ queryKey: queryKeys.requests(requestMerchantId) });

  // Handlers
  const handleCreateRequest = async (payload: any) => {
    try {
      await createGoodRequest(payload);
      toast.success('Хүсэлт амжилттай үүсгэгдлээ');
      setIsDrawerOpen(false);
      await invalidateRequests();
    } catch (error: any) {
      toast.error(error.message || 'Хүсэлт үүсгэхэд алдаа гарлаа');
    }
  };

  const handleApprove = (request: GoodRequest) => {
    setSelectedRequest(request);
    setIsApproveModalOpen(true);
  };

  const handleApproveConfirm = async (stock: number) => {
    if (!selectedRequest) return;

    try {
      await approveRequest(selectedRequest.id, stock);
      toast.success('Хүсэлт амжилттай зөвшөөрөгдлөө');
      setIsApproveModalOpen(false);
      setSelectedRequest(null);
      await invalidateRequests();
      queryClient.invalidateQueries({ queryKey: ["goods"] });
    } catch (error: any) {
      toast.error(error.message || 'Зөвшөөрөхөд алдаа гарлаа');
      throw error; // Re-throw to let modal handle it
    }
  };

  const handleDecline = async (request: GoodRequest) => {
    if (!confirm(`Та энэ хүсэлтийг татгалзахдаа итгэлтэй байна уу?`)) {
      return;
    }

    try {
      await declineRequest(request.id);
      toast.success('Хүсэлт амжилттай татгалзсан');
      await invalidateRequests();
    } catch (error: any) {
      toast.error(error.message || 'Татгалзахдаа алдаа гарлаа');
    }
  };

  return (
    <div className="w-full mt-6 px-4 pb-32">
      <div className="mb-6 flex items-center justify-between">
        <h1 className="text-3xl font-bold text-gray-900">Барааны хүсэлт</h1>
        {isMerchant && (
          <Button onClick={() => setIsDrawerOpen(true)}>+ Хүсэлт үүсгэх</Button>
        )}
      </div>

      <div className="mb-4 flex items-center gap-4 flex-wrap">
        {!isMerchant && (
          <Select
            value={statusFilter?.toString() || 'all'}
            onValueChange={(value) => setStatusFilter(value === 'all' ? null : parseInt(value))}
          >
            <SelectTrigger className="w-48">
              <SelectValue placeholder="Төлөвөөр шүүх" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">Бүх төлөв</SelectItem>
              <SelectItem value="1">Хүлээгдэж байна</SelectItem>
              <SelectItem value="2">Зөвшөөрөгдсөн</SelectItem>
              <SelectItem value="3">Татгалзсан</SelectItem>
            </SelectContent>
          </Select>
        )}

        {!isMerchant && (
          <SearchableSelect
            options={[
              { value: 'all', label: 'Дэлгүүр' },
              ...merchants.map((merchant) => ({
                value: merchant.id.toString(),
                label: merchant.username,
              })),
            ]}
            value={merchantFilter?.toString() || 'all'}
            onValueChange={(value) =>
              setMerchantFilter(!value || value === 'all' ? null : parseInt(value, 10))
            }
            placeholder="Мерчандаар шүүх"
            className="w-48"
          />
        )}

        <Select
          value={typeFilter?.toString() || 'all'}
          onValueChange={(value) => setTypeFilter(value === 'all' ? null : parseInt(value))}
        >
          <SelectTrigger className="w-48">
            <SelectValue placeholder="Төрлөөр шүүх" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">Бүх төрөл</SelectItem>
            <SelectItem value="1">Шинэ бараа үүсгэх</SelectItem>
            <SelectItem value="2">Нэмэх</SelectItem>
            <SelectItem value="3">Хасах</SelectItem>
          </SelectContent>
        </Select>

        <Input
          type="text"
          placeholder="Барааны нэрээр хайх..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="w-64"
        />

        <div className="flex items-center gap-2">
          <Input
            type="date"
            value={dateRange[0] ? formatDateLocal(dateRange[0]) : ''}
            onChange={(e) => {
              const start = e.target.value ? new Date(e.target.value) : null;
              setDateRange([start, dateRange[1]]);
            }}
            className="w-40"
            title="Эхлэх огноо"
          />
          <span className="text-gray-500">-</span>
          <Input
            type="date"
            value={dateRange[1] ? formatDateLocal(dateRange[1]) : ''}
            onChange={(e) => {
              const end = e.target.value ? new Date(e.target.value) : null;
              setDateRange([dateRange[0], end]);
            }}
            className="w-40"
            title="Дуусах огноо"
          />
        </div>
      </div>

      <GoodRequestTable
        requests={filteredRequests.slice(
          (pagination.current - 1) * PAGE_SIZE,
          pagination.current * PAGE_SIZE
        )}
        loading={loading}
        onApprove={!isMerchant ? handleApprove : undefined}
        onDecline={!isMerchant ? handleDecline : undefined}
        isMerchant={isMerchant}
      />

      {pagination.total > 0 && (
        <div className="mt-4 flex justify-between items-center">
          <div className="text-sm text-gray-600">
            Нийт: {pagination.total} | Хуудас: {pagination.current} /{' '}
            {Math.max(1, Math.ceil(pagination.total / PAGE_SIZE))}
          </div>
          <div className="flex gap-2">
            <Button
              variant="outline"
              onClick={() =>
                setPagination((prev) => ({ ...prev, current: Math.max(1, prev.current - 1) }))
              }
              disabled={pagination.current === 1}
            >
              Өмнөх
            </Button>
            <Button
              variant="outline"
              onClick={() =>
                setPagination((prev) => ({
                  ...prev,
                  current: Math.min(
                    Math.ceil(pagination.total / PAGE_SIZE),
                    prev.current + 1
                  ),
                }))
              }
              disabled={pagination.current >= Math.ceil(pagination.total / PAGE_SIZE)}
            >
              Дараах
            </Button>
          </div>
        </div>
      )}

      {/* Create Request Drawer (only for merchants) */}
      {isMerchant && merchantId && (
        <GoodRequestForm
          isOpen={isDrawerOpen}
          onClose={() => setIsDrawerOpen(false)}
          onSubmit={handleCreateRequest}
          goods={goods}
          wares={wares}
          merchantId={merchantId}
        />
      )}

      {/* Approve Request Modal (only for admin) */}
      {!isMerchant && (
        <ApproveRequestModal
          isOpen={isApproveModalOpen}
          onClose={() => {
            setIsApproveModalOpen(false);
            setSelectedRequest(null);
          }}
          onApprove={handleApproveConfirm}
          request={selectedRequest}
        />
      )}
    </div>
  );
}

