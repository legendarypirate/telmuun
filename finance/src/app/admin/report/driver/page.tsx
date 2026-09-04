"use client";

import { useState } from 'react';
import { toast } from 'sonner';
import dayjs from 'dayjs';
import { Button } from '@/components/ui/button';
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';
import { Input } from '@/components/ui/input';
import { SearchableSelect } from '@/components/ui/searchable-select';
import { Badge } from '@/components/ui/badge';
import { useQuery } from '@tanstack/react-query';
import { useDrivers } from '@/hooks/use-lookups';
import { queryKeys } from '@/lib/api';
import { fetchDriverStatusReport } from '../services/report.service';
import { formatDateLocal } from '@/lib/utils';

export default function DriverReportPage() {
  const [selectedDriverId, setSelectedDriverId] = useState<number | null>(null);
  const [dateRange, setDateRange] = useState<[Date, Date]>([new Date(), new Date()]);
  const [applied, setApplied] = useState({
    startDate: dayjs().format('YYYY-MM-DD'),
    endDate: dayjs().format('YYYY-MM-DD'),
    driverId: undefined as number | undefined,
  });
  const { data: drivers = [] } = useDrivers();

  const { data: reportResult, isFetching: loading } = useQuery({
    queryKey: queryKeys.driverReport(applied),
    queryFn: () => fetchDriverStatusReport(applied),
    staleTime: 30_000,
    placeholderData: (prev) => prev,
  });

  const reportRows = reportResult?.data || [];
  const statuses = reportResult?.statuses || [];

  const loadReportData = () => {
    if (!dateRange[0] || !dateRange[1]) {
      toast.error('Огноо сонгоно уу');
      return;
    }
    setApplied({
      startDate: dayjs(dateRange[0]).format('YYYY-MM-DD'),
      endDate: dayjs(dateRange[1]).format('YYYY-MM-DD'),
      driverId: selectedDriverId ?? undefined,
    });
  };

  return (
    <div className="w-full mt-6 px-4 pb-32">
      <div className="mb-6">
        <h1 className="text-3xl font-bold text-gray-900">Жолоочийн тайлан</h1>
      </div>

      <div className="mb-6 flex flex-wrap items-center gap-4">
        <SearchableSelect
          options={[
            { value: 'all', label: 'Бүх жолооч' },
            ...drivers.map((driver) => ({
              value: driver.id.toString(),
              label: driver.username,
            })),
          ]}
          value={selectedDriverId?.toString() || 'all'}
          onValueChange={(value) =>
            setSelectedDriverId(!value || value === 'all' ? null : parseInt(value, 10))
          }
          placeholder="Жолооч сонгох"
          className="w-56"
        />

        <div className="flex items-center gap-2">
          <Input
            type="date"
            value={formatDateLocal(dateRange[0])}
            onChange={(e) => {
              const start = e.target.value ? new Date(e.target.value) : dateRange[0];
              setDateRange([start, dateRange[1]]);
            }}
            className="w-40"
          />
          <span className="text-gray-500">-</span>
          <Input
            type="date"
            value={formatDateLocal(dateRange[1])}
            onChange={(e) => {
              const end = e.target.value ? new Date(e.target.value) : dateRange[1];
              setDateRange([dateRange[0], end]);
            }}
            className="w-40"
          />
        </div>

        <Button onClick={loadReportData} disabled={loading}>
          {loading ? 'Ачаалж байна...' : 'Хайх'}
        </Button>
      </div>

      <div className="border rounded-md overflow-x-auto">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead className="min-w-[140px]">Жолооч</TableHead>
              {statuses.map((status) => (
                <TableHead key={status.id} className="text-center min-w-[100px]">
                  <Badge
                    style={{
                      backgroundColor: status.color,
                      color: 'white',
                    }}
                  >
                    {status.status}
                  </Badge>
                </TableHead>
              ))}
              <TableHead className="text-center">Нийт</TableHead>
              <TableHead className="text-center min-w-[120px]">Хүргэсэн %</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {loading ? (
              <TableRow>
                <TableCell colSpan={statuses.length + 3} className="text-center py-8 text-gray-500">
                  Ачаалж байна...
                </TableCell>
              </TableRow>
            ) : reportRows.length === 0 ? (
              <TableRow>
                <TableCell colSpan={Math.max(statuses.length + 3, 4)} className="text-center py-8 text-gray-500">
                  Өгөгдөл олдсонгүй
                </TableCell>
              </TableRow>
            ) : (
              reportRows.map((row) => (
                <TableRow key={row.driver_id}>
                  <TableCell className="font-medium">{row.driver_name}</TableCell>
                  {statuses.map((status) => (
                    <TableCell key={status.id} className="text-center">
                      {row.status_counts[String(status.id)] || 0}
                    </TableCell>
                  ))}
                  <TableCell className="text-center font-semibold">{row.total}</TableCell>
                  <TableCell className="text-center">
                    <span className="font-semibold text-green-600">
                      {row.delivered_percentage}%
                    </span>
                    <span className="text-xs text-gray-500 block">
                      ({row.delivered_count}/{row.total})
                    </span>
                  </TableCell>
                </TableRow>
              ))
            )}
          </TableBody>
        </Table>
      </div>
    </div>
  );
}
