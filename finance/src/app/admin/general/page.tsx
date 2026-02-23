'use client';

import React, { useEffect, useState } from 'react';
import { Table, Spin, message, Tag, Input, Select, Space, Button } from 'antd';
import type { ColumnsType } from 'antd/es/table';
import dayjs from 'dayjs';

interface General {
  id: number;
  user_id: number;
  type: number;
  count: number;
  sum: number;      // sum as number
  account: number;  // account as number
  cash: number;     // cash as number
  status: number;
  createdAt: string;
  updatedAt: string;
  user?: {
    username: string;
  };
}

interface User {
  id: number;
  username: string;
}

export default function GeneralReportPage() {
  const [loading, setLoading] = useState(false);
  const [data, setData] = useState<General[]>([]);
  const [merchantId, setMerchantId] = useState<number | undefined>();
  const [merchants, setMerchants] = useState<User[]>([]);
  const [user, setUser] = useState<any>(null);
  const [isMerchant, setIsMerchant] = useState<boolean>(false);

  // Get user data from localStorage
  useEffect(() => {
    const userData = typeof window !== 'undefined' ? localStorage.getItem('user') : null;
    const userObj = userData ? JSON.parse(userData) : null;
    setUser(userObj);
    setIsMerchant(userObj?.role === 2);
    
    // If user is merchant, set merchantId to their ID
    if (userObj?.role === 2) {
      setMerchantId(userObj.id);
    }
  }, []);

  // Fetch merchants (only for non-merchant users)
  useEffect(() => {
    const fetchMerchants = async () => {
      // Don't fetch merchants if user is merchant
      if (isMerchant) return;
      
      try {
        const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/user/merchant`);
        const result = await res.json();
        if (result.success) {
          setMerchants(result.data);
        } else {
          message.error('Failed to fetch merchants');
        }
      } catch (err) {
        message.error('Error fetching merchants');
      }
    };
    fetchMerchants();
  }, [isMerchant]);

  const fetchData = async () => {
    try {
      setLoading(true);
      
      const params = new URLSearchParams();
      
      // If user is merchant, always use their ID
      if (isMerchant && user?.id) {
        params.append('merchantId', user.id.toString());
      } else if (merchantId) {
        // For non-merchant users, use the selected merchantId
        params.append('merchantId', merchantId.toString());
      }

      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/general?${params.toString()}`);
      const result = await res.json();
      
      if (result.success) {
        // Ensure account + cash = sum on load
        const formattedData = result.data.map((item: any) => ({
          ...item,
          sum: parseFloat(item.sum),
          account: parseFloat(item.account),
          cash: parseFloat(item.cash),
        }));
        setData(formattedData);
      } else {
        message.error('Failed to fetch generals');
        setData([]);
      }
    } catch (err) {
      message.error('Error fetching generals');
      setData([]);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (user) { // Only fetch data when user data is available
      fetchData();
    }
  }, [merchantId, isMerchant, user]);

  // Handle account change
  const handleAccountChange = async (id: number, value: number) => {
    setData((prev) =>
      prev.map((item) => {
        if (item.id === id) {
          const newAccount = Math.min(value, item.sum);
          const newCash = item.sum - newAccount;
          return { ...item, account: newAccount, cash: newCash };
        }
        return item;
      })
    );

    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/general/update_account/${id}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ account: value }),
      });

      const result = await res.json();
      if (!result.success) {
        message.error("Failed to update account");
      }
    } catch (err) {
      message.error("Error updating account");
    }
  };

  const columns: ColumnsType<General> = [
    { 
      title: 'Хэрэглэгч', 
      dataIndex: ['user', 'username'], 
      key: 'user', 
      render: (_, record) => record.user?.username ?? '-' 
    },
    { 
      title: 'Төрөл', 
      dataIndex: 'type', 
      key: 'type',
      render: (val: number) => (val === 1 ? 'Driver' : 'Merchant'),
    },
    { title: 'Count', dataIndex: 'count', key: 'count' },
    { 
      title: 'Дүн (₮)', 
      dataIndex: 'sum', 
      key: 'sum',
      render: (val: number) => val.toLocaleString(),
    },
    { 
        title: 'Данс (₮)', 
        dataIndex: 'account', 
        key: 'account',
        render: (val: number, record) => (
          isMerchant ? (
            <span>{val.toLocaleString()}</span>
          ) : (
            <Input
              type="number"
              value={val}
              min={0}
              max={record.sum}
              onChange={(e) => handleAccountChange(record.id, parseFloat(e.target.value))}
              style={{ width: 120 }}
            />
          )
        ),
      },
    { 
      title: 'Бэлэн (₮)', 
      dataIndex: 'cash', 
      key: 'cash',
      render: (val: number) => val.toLocaleString(),
    },
    { 
      title: 'Төлөв', 
      dataIndex: 'status', 
      key: 'status',
      render: (val: number) => (
        <Tag color={val === 1 ? 'red' : 'green'}>
          {val === 1 ? 'Тооцоо нийлээгүй' : 'Тооцоо нийлсэн'}
        </Tag>
      ),
    },
    { 
      title: 'Үүссэн огноо', 
      dataIndex: 'createdAt', 
      key: 'createdAt',
      render: (text: string) => dayjs(text).format('YYYY-MM-DD HH:mm:ss'),
    },
  ];

  return (
    <div style={{ padding: 20 }}>
      <h4 className="text-xl font-bold mb-4">Ерөнхий тайлан</h4>

      {/* Filters - Only show for non-merchant users */}
      {!isMerchant && (
        <Space style={{ marginBottom: 16 }}>
          <Select
            placeholder="Select Merchant"
            style={{ width: 200 }}
            allowClear
            value={merchantId}
            onChange={(value) => setMerchantId(value)}
          >
            {merchants.map((merchant) => (
              <Select.Option key={merchant.id} value={merchant.id}>
                {merchant.username}
              </Select.Option>
            ))}
          </Select>

          <Button onClick={fetchData}>Apply Filters</Button>
        </Space>
      )}

      {loading ? (
        <Spin />
      ) : (
        <Table
          rowKey="id"
          dataSource={data}
          columns={columns}
          pagination={{ pageSize: 20 }}
        />
      )}
    </div>
  );
}