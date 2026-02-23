'use client';

import React, { useEffect, useState } from 'react';
import { Table, Spin, message, Tag, Button, DatePicker, Select, Space } from 'antd';
import type { ColumnsType } from 'antd/es/table';
import type { RangePickerProps } from 'antd/es/date-picker';
import dayjs from 'dayjs';
import utc from 'dayjs/plugin/utc';
import timezone from 'dayjs/plugin/timezone';
import * as XLSX from 'xlsx';

dayjs.extend(utc);
dayjs.extend(timezone);
const { RangePicker } = DatePicker;
const { Option } = Select;

interface ReportData {
  id: number;
  merchant_id: number;
  phone: string;
  address: string;
  image: string | null;
  status: number;
  price: string;
  comment: string;
  driver_id: number;
  report_stage: number;
  is_reported: boolean;
  is_deleted: boolean;
  report_id: number;
  delivery_id: string;
  createdAt: string;
  updatedAt: string;
  merchant?: { username: string };
  status_name?: { status: string; color: string | null };
  driver?: { username: string };
}

interface Driver {
  id: number;
  username: string;
}

export default function MergeReportPage() {
  const [loading, setLoading] = useState<boolean>(false);
  const [data, setData] = useState<ReportData[]>([]);
  const [selectedRowKeys, setSelectedRowKeys] = useState<React.Key[]>([]);
  const [driverId, setDriverId] = useState<number | undefined>();
  const [dateRange, setDateRange] = useState<[string, string] | undefined>();
  const [drivers, setDrivers] = useState<Driver[]>([]);

  const handlePriceChange = async (id: number, newPrice: string) => {
    try {
      // Optimistic update in frontend
      setData((prev) =>
        prev.map((item) => (item.id === id ? { ...item, price: newPrice } : item))
      );
  
      // Send update to backend
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/delivery/update_price/${id}`, {
        method: 'PATCH', // or PUT depending on your API
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ price: parseFloat(newPrice) }),
      });
  
      const result = await res.json();
      if (!result.success) {
        message.error('Failed to update price');
      }
    } catch (err) {
      message.error('Error updating price');
    }
  };
  
  // 🔹 Fetch drivers once
  useEffect(() => {
    const fetchDrivers = async () => {
      try {
        const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/user/drivers`);
        const result = await res.json();
        if (result.success) {
          setDrivers(result.data);
        } else {
          message.error('Failed to fetch drivers');
        }
      } catch (err) {
        message.error('Error fetching drivers');
      }
    };
    fetchDrivers();
  }, []);

  const fetchData = async () => {
    try {
      setLoading(true);
  
      const params = new URLSearchParams();
      if (driverId) params.append('driverId', driverId.toString());
      if (dateRange) {
        params.append('startDate', dateRange[0]);
        params.append('endDate', dateRange[1]);
      }
  
      const res = await fetch(
        `${process.env.NEXT_PUBLIC_API_URL}/api/merge_report/driver?${params.toString()}`
      );
      const result = await res.json();
  
      if (result.success) {
        setData(result.data);
      } else {
        // ✅ Instead of showing error, just clear table
        setData([]);
      }
    } catch (err) {
      message.error('Error fetching data');
      setData([]);
    } finally {
      setLoading(false);
    }
  };
  

  useEffect(() => {
    fetchData();
  }, [driverId, dateRange]);

const handleCommentChange = async (id: number, newComment: string) => {
  try {
    // Optimistic update in frontend
    setData((prev) =>
      prev.map((item) => (item.id === id ? { ...item, comment: newComment } : item))
    );

    // Send update to backend
    const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/delivery/update_comment/${id}`, {
      method: 'PATCH',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ comment: newComment }),
    });

    const result = await res.json();
    if (!result.success) {
      message.error('Failed to update comment');
    }
  } catch (err) {
    message.error('Error updating comment');
  }
};

  const handleMergeReport = async () => {
    if (!driverId) {
      message.warning('Please select a driver');
      return;
    }
  
    const selectedRows = data.filter((item) => selectedRowKeys.includes(item.id));
    if (selectedRows.length === 0) {
      message.warning('No deliveries selected');
      return;
    }
  
    const totalPrice = selectedRows.reduce(
      (sum, item) => sum + parseFloat(item.price || '0'),
      0
    );
  
    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/general/merge_driver`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          driver_id: driverId,
          delivery_ids: selectedRows.map((item) => item.id),
          count: selectedRows.length,
          sum: totalPrice,
          status: 1,
          type: 1,
        }),
      });
  
      const result = await res.json();
      if (result.success) {
        message.success('Deliveries merged successfully');
  
        // Update frontend to reflect report_stage = 2
        setData((prev) =>
          prev.map((item) =>
            selectedRowKeys.includes(item.id) ? { ...item, report_stage: 2 } : item
          )
        );
        setSelectedRowKeys([]);
      } else {
        message.error(result.message || 'Failed to merge deliveries');
      }
    } catch (err) {
      console.error(err);
      message.error('Error merging deliveries');
    }
  };
  
  const columns: ColumnsType<ReportData> = [
    { title: 'ID', dataIndex: 'id', key: 'id' },
    {
      title: 'Хүргэсэн цаг',
      dataIndex: 'delivered_at',
      key: 'delivered_at',
      render: (text: string) =>
        text ? dayjs(text).tz('Asia/Ulaanbaatar').format('YYYY-MM-DD HH:mm:ss') : '-',
    },
    { title: 'Merchant', dataIndex: ['merchant', 'username'], key: 'merchant' },
    { title: 'Phone', dataIndex: 'phone', key: 'phone' },
    { title: 'Address', dataIndex: 'address', key: 'address' },
    {
      title: 'Price',
      dataIndex: 'price',
      key: 'price',
      render: (text: string, record: ReportData) => (
        <input
          type="number"
          value={text}
          style={{ width: 100 }}
          onChange={(e) => handlePriceChange(record.id, e.target.value)}
        />
      ),
    },
{
  title: 'Comment',
  dataIndex: 'comment',
  key: 'comment',
  render: (text: string, record: ReportData) => (
    <input
      type="text"
      value={text || ''}
      style={{ width: 200 }}
      onChange={(e) => handleCommentChange(record.id, e.target.value)}
    />
  ),
},
    { title: 'Driver', dataIndex: ['driver', 'username'], key: 'driver' },
    {
      title: 'Status',
      dataIndex: ['status_name', 'status'],
      key: 'status',
      render: (_: string, record) => (
        <Tag color={record.status_name?.color || 'blue'}>
          {record.status_name?.status}
        </Tag>
      ),
    },
    { title: 'Delivery ID', dataIndex: 'delivery_id', key: 'delivery_id' },
    {
      title: 'Created At',
      dataIndex: 'createdAt',
      key: 'createdAt',
      render: (text: string) => new Date(text).toLocaleString(),
    },
  ];

  const rowSelection = {
    selectedRowKeys,
    onChange: (newSelectedKeys: React.Key[]) => {
      setSelectedRowKeys(newSelectedKeys);
    },
  };

  const selectedItems = data.filter((item) => selectedRowKeys.includes(item.id));
  const totalCount = selectedItems.length;
  const totalPrice = selectedItems.reduce(
    (sum, item) => sum + parseFloat(item.price || '0'),
    0
  );

  return (
    <div style={{ padding: 20 }}>
      <h4 className="text-xl font-bold mb-4">Жолоочийн тайлан</h4>

      {/* Filters */}
      <Space style={{ marginBottom: 16 }}>
        <Select
          placeholder="Select Driver"
          style={{ width: 200 }}
          allowClear
          value={driverId}
          onChange={(value) => setDriverId(value)}
        >
          {drivers.map((driver) => (
            <Option key={driver.id} value={driver.id}>
              {driver.username}
            </Option>
          ))}
        </Select>

        <RangePicker
          onChange={(dates: RangePickerProps['value']) => {
            if (dates) {
              setDateRange([
                dayjs(dates[0]).startOf('day').toISOString(),
                dayjs(dates[1]).endOf('day').toISOString(),
              ]);
            } else {
              setDateRange(undefined);
            }
          }}
        />

        <Button onClick={fetchData}>Apply Filters</Button>
      </Space>

      {loading ? (
        <Spin />
      ) : (
        <Table
  rowSelection={rowSelection}
  rowKey="id"
  dataSource={data}
  columns={columns}
  pagination={{
    pageSize: 100, // default page size
    showSizeChanger: true, // allow user to change page size
    pageSizeOptions: ['100', '200', '300', '500'], // selectable options
  }}
/>

      )}

      {/* Fixed Footer */}
      <div
        style={{
          position: 'fixed',
          bottom: 0,
          left: 0,
          width: '100%',
          background: '#fff',
          padding: '16px 24px',
          borderTop: '1px solid #ddd',
          zIndex: 999,
          display: 'flex',
          gap: '16px',
          alignItems: 'center',
        }}
      >
        <span>
          ✅ Selected Items: <b>{totalCount}</b>
        </span>
        <span>
          💰 Total Price: <b>{totalPrice.toLocaleString()}₮</b>
        </span>
        <Button type="primary" onClick={handleMergeReport}>
          Тайлан нийлэх
        </Button>
        
        <Button
          type="default"
          disabled={selectedRowKeys.length === 0}
          onClick={() => {
            const selectedRows = data.filter(item =>
              selectedRowKeys.includes(item.id)
            );

            // Prepare data for Excel
            const excelData = selectedRows.map(row => ({
              'Дэлгүүр': row.merchant?.username ?? '-',
              'Хаяг': row.address,
              'Утас': row.phone,
              'Үнэ': row.price,
              'Тайлбар': row.comment ?? '-',
            }));

            // Convert to worksheet
            const worksheet = XLSX.utils.json_to_sheet(excelData);

            // Create workbook and add worksheet
            const workbook = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(workbook, worksheet, 'Selected Deliveries');

            // Export Excel file
            XLSX.writeFile(workbook, 'selected_deliveries.xlsx');
          }}
          style={{ marginLeft: 8 }}
        >
          Export Excel
        </Button>
      </div>
    </div>
  );
}