'use client';

import React, { useEffect, useState } from 'react';
import { Card, Row, Col, Typography, Space, Spin, Alert, message, Table, Input, Button } from 'antd';
import { FolderOutlined, UserOutlined, CloseOutlined, SaveOutlined } from '@ant-design/icons';

const { Title, Text } = Typography;

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
  const [saving, setSaving] = useState<{ id: number; type: 'amount' | 'diff' } | null>(null);

  // Fetch all drivers
  useEffect(() => {
    const fetchDrivers = async () => {
      try {
        const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/user/driver`);
        if (!response.ok) throw new Error(`Failed to fetch drivers: ${response.status}`);
        const data = await response.json();
        if (data.success) setDrivers(data.data);
        else throw new Error('API returned unsuccessful response');
      } catch (err) {
        setError(err instanceof Error ? err.message : 'An error occurred');
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
        message.warning(data.message || 'No bulk report found for this driver.');
        setBulks([]);
      }
      setSelectedDriver(driver);
      setPanelVisible(true);
    } catch (err) {
      message.error(err instanceof Error ? err.message : 'Error fetching bulk report');
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
    setSaving({ id: bulkId, type: 'amount' });
    try {
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/delivery/bulk/${bulkId}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          amount: editingAmounts[bulkId],
        }),
      });

      if (!response.ok) throw new Error(`Failed to update amount: ${response.status}`);
      const data = await response.json();
      if (data.success) {
        setBulks((prev) =>
          prev.map((bulk) =>
            bulk.id === bulkId ? { ...bulk, amount: editingAmounts[bulkId] } : bulk
          )
        );
        message.success('Amount updated successfully');
      } else {
        throw new Error(data.message || 'Failed to update amount');
      }
    } catch (err) {
      message.error(err instanceof Error ? err.message : 'Error updating amount');
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
  setSaving({ id: bulkId, type: 'diff' });
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
        prev.map((bulk) =>
          bulk.id === bulkId ? { ...bulk, diff: editingDiffs[bulkId] } : bulk
        )
      );
      message.success('Зөрүү updated successfully');
    } else {
      throw new Error(data.message || 'Failed to update diff');
    }
  } catch (err) {
    message.error(err instanceof Error ? err.message : 'Error updating diff');
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

  const bulkColumns = [
{ 
      title: 'Тайлангйин огноо', 
      dataIndex: 'report_date', 
      key: 'report_date',
      width: 140,
      render: (date: string) => (
        <Text>{date ? new Date(date).toISOString().slice(0, 10) : '-'}</Text>
      ),
    },
    { title: 'Тоо', dataIndex: 'count', key: 'count', width: 80 },
    { title: 'Хүргэгдсэн', dataIndex: 'deliveredCount', key: 'deliveredCount', width: 100 },
    { 
      title: 'Дүн', 
      dataIndex: 'amount', 
      key: 'amount',
      width: 200,
      render: (amount: number, record: Bulk) => (
        <Space size="small">
          <Input
            type="number"
            value={editingAmounts[record.id]}
            onChange={(e) => handleAmountChange(record.id, e.target.value)}
            style={{ width: 120, fontSize: '13px', textAlign: 'right' }}
            size="small"
          />
          <Button
            type="primary"
            icon={<SaveOutlined />}
            size="small"
            loading={saving?.id === record.id && saving?.type === 'amount'}
            onClick={() => updateBulkAmount(record.id)}
          />
        </Space>
      ),
    },
    { 
      title: 'Зөрүү', 
      dataIndex: 'diff', 
      key: 'diff',
      width: 200,
      render: (diff: number, record: Bulk) => (
        <Space size="small">
          <Input
            type="number"
            value={editingDiffs[record.id]}
            onChange={(e) => handleDiffChange(record.id, e.target.value)}
            style={{ width: 120, fontSize: '13px', textAlign: 'right' }}
            size="small"
          />
          <Button
            type="primary"
            icon={<SaveOutlined />}
            size="small"
            loading={saving?.id === record.id && saving?.type === 'diff'}
            onClick={() => updateBulkDiff(record.id)}
          />
        </Space>
      ),
    },
    { title: 'Хүргэлтэнд гарса', dataIndex: 'paid', key: 'paid', width: 80 },
    
  ];

  if (error) {
    return (
      <div style={{ padding: '24px' }}>
        <Alert message="Error Loading Drivers" description={error} type="error" showIcon />
      </div>
    );
  }

  if (loading) {
    return (
      <div style={{ padding: '24px', textAlign: 'center' }}>
        <Spin size="large" />
        <div style={{ marginTop: 16 }}>
          <Text>Loading drivers...</Text>
        </div>
      </div>
    );
  }

  return (
    <div style={{ padding: '24px', minHeight: '100vh', background: '#f5f5f5' }}>
      <Space direction="vertical" size="large" style={{ width: '100%' }}>
        {/* Page Header */}
        <div>
          <Title level={2} style={{ margin: 0, color: '#1890ff' }}>
            <UserOutlined /> Жолоочийн тайлан
          </Title>
          <Text type="secondary">
            Total {drivers.length} driver{drivers.length !== 1 ? 's' : ''} found
          </Text>
        </div>

        {/* Drivers Grid */}
        <Row gutter={[24, 24]}>
          {drivers.map((driver) => (
            <Col key={driver.id} xs={24} sm={12} md={8} lg={6}>
              <Card
                hoverable
                style={{
                  textAlign: 'center',
                  borderRadius: '12px',
                  minHeight: '140px',
                  border: '2px solid #f0f0f0',
                  cursor: 'pointer',
                }}
                bodyStyle={{ padding: '16px 8px' }}
                onClick={() => fetchBulkReport(driver)}
              >
                <FolderOutlined style={{ fontSize: '42px', color: '#1890ff', marginBottom: '12px' }} />
                <Text strong style={{ fontSize: '14px' }}>{driver.username}</Text>
                <Text type="secondary" style={{ fontSize: '12px', marginTop: '4px' }}>ID: {driver.id}</Text>
              </Card>
            </Col>
          ))}
        </Row>
      </Space>

      {/* Bottom Fixed Panel */}
      {panelVisible && (
        <div style={{
          position: 'fixed',
          bottom: 0,
          left: 0,
          right: 0,
          background: 'white',
          borderTop: '2px solid #1890ff',
          boxShadow: '0 -4px 12px rgba(0, 0, 0, 0.1)',
          zIndex: 1000,
          maxHeight: '65vh',
          display: 'flex',
          flexDirection: 'column'
        }}>
          {/* Header */}
          <div style={{
            padding: '16px 24px',
            background: '#1890ff',
            color: 'white',
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center'
          }}>
            <Title level={4} style={{ margin: 0, color: 'white' }}>
              Bulk Report - {selectedDriver?.username} (ID: {selectedDriver?.id})
            </Title>
            <Button type="text" icon={<CloseOutlined />} onClick={handleClosePanel} style={{ color: 'white' }} />
          </div>

          {/* Table */}
          <div style={{ padding: '16px 24px', flex: 1, overflow: 'auto' }}>
            {bulkLoading ? (
              <div style={{ textAlign: 'center', padding: '20px' }}>
                <Spin tip="Loading bulk report..." />
              </div>
            ) : bulks.length === 0 ? (
              <div style={{ textAlign: 'center', padding: '20px' }}>
                <Text type="secondary">No bulk records found.</Text>
              </div>
            ) : (
              <Table
                dataSource={bulks}
                columns={bulkColumns}
                rowKey="id"
                pagination={{ pageSize: 5 }}
                size="small"
                scroll={{ x: 1000 }}
                style={{ marginBottom: '16px' }}
              />
            )}
          </div>

          {/* Footer */}
          <div style={{
            padding: '12px 24px',
            borderTop: '1px solid #f0f0f0',
            background: '#fafafa',
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center'
          }}>
            <Text type="secondary">Total Records: {bulks.length}</Text>
            <Button onClick={handleClosePanel}>Close</Button>
          </div>
        </div>
      )}
    </div>
  );
}