'use client';

import React, { useEffect, useState } from 'react';
import { Card, Row, Col, Typography, Space, Spin, Alert, message, Table, Modal } from 'antd';
import { FolderOutlined, UserOutlined } from '@ant-design/icons';

const { Title, Text } = Typography;

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

  // Fetch all merchants
  useEffect(() => {
    const fetchMerchants = async () => {
      try {
        const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/user/merchant`);
        if (!response.ok) throw new Error(`Failed to fetch merchants: ${response.status}`);
        const data = await response.json();
        if (data.success) setMerchants(data.data);
        else throw new Error('API returned unsuccessful response');
      } catch (err) {
        setError(err instanceof Error ? err.message : 'An error occurred');
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
        message.warning(data.message || 'No bulk report found for this merchant.');
        setBulks([]);
        setSelectedMerchant(merchant);
        setModalVisible(true);
      }
    } catch (err) {
      message.error(err instanceof Error ? err.message : 'Error fetching bulk report');
    } finally {
      setBulkLoading(false);
    }
  };

  const bulkColumns = [
    { title: 'ID', dataIndex: 'id', key: 'id' },
    { title: 'Merchant ID', dataIndex: 'merchant_id', key: 'merchant_id' },
    { title: 'Driver ID', dataIndex: 'driver_id', key: 'driver_id' },
    { title: 'Count', dataIndex: 'count', key: 'count' },
    { title: 'Delivered Count', dataIndex: 'deliveredCount', key: 'deliveredCount' },
    { title: 'Amount', dataIndex: 'amount', key: 'amount' },
    { title: 'Diff', dataIndex: 'diff', key: 'diff' },
    { title: 'Paid', dataIndex: 'paid', key: 'paid' },
  ];

  if (error) {
    return (
      <div style={{ padding: '24px' }}>
        <Alert message="Error Loading Merchants" description={error} type="error" showIcon />
      </div>
    );
  }

  if (loading) {
    return (
      <div style={{ padding: '24px', textAlign: 'center' }}>
        <Spin size="large" />
        <div style={{ marginTop: 16 }}>
          <Text>Loading merchants...</Text>
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
            <UserOutlined /> Харилцагчийн тайлан
          </Title>
          <Text type="secondary">
            Total {merchants.length} merchant{merchants.length !== 1 ? 's' : ''} found
          </Text>
        </div>

        {/* Merchants Grid */}
        <Row gutter={[24, 24]}>
          {merchants.map((merchant) => (
            <Col key={merchant.id} xs={24} sm={12} md={8} lg={6}>
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
                onClick={() => fetchBulkReport(merchant)}
              >
                <FolderOutlined style={{ fontSize: '42px', color: '#1890ff', marginBottom: '12px' }} />
                <Text strong style={{ fontSize: '14px' }}>{merchant.username}</Text>
                <Text type="secondary" style={{ fontSize: '12px', marginTop: '4px' }}>ID: {merchant.id}</Text>
              </Card>
            </Col>
          ))}
        </Row>
      </Space>

      {/* Bulk Report Modal */}
      <Modal
        title={`Bulk Report - ${selectedMerchant?.username || ''}`}
        visible={modalVisible}
        onCancel={() => setModalVisible(false)}
        footer={null}
        width={900}
        bodyStyle={{ maxHeight: '70vh', overflowY: 'auto' }}
      >
        {bulkLoading ? (
          <Spin tip="Loading bulk report..." style={{ width: '100%', textAlign: 'center' }} />
        ) : bulks.length === 0 ? (
          <Text type="secondary">No bulk records found.</Text>
        ) : (
          <Table
            dataSource={bulks}
            columns={bulkColumns}
            rowKey="id"
            pagination={{ pageSize: 10 }}
            size="small"
          />
        )}
      </Modal>
    </div>
  );
}
