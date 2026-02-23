'use client';

import React, { useEffect, useState } from 'react';
import { Table, Button, Space, Drawer, Form, Input, Select, Modal, notification, Radio,InputNumber,Tag } from 'antd';
import type { ColumnsType } from 'antd/es/table';
import { EditOutlined, DeleteOutlined, CloseOutlined ,CheckCircleOutlined, CloseCircleOutlined } from '@ant-design/icons';

const { Option } = Select;

interface Request {
  id: number;
  stock: number;
  name: string;
  merchant_id: number;
  ware_id: number;
  status: number;
  type: number;
  createdAt: string;
  updatedAt: string;
  good: {
    id: number;
    name: string;
  };
  merchant: {
    id: number;
    username: string;
  };
  ware: {
    id: number;
    name: string;
  };
}

interface Good {
  id: number;
  stock: number;
  name: string;
  merchant_id: number;
  ware_id: number;
  createdAt: string;
  updatedAt: string;
  merchant: {
    id: number;
    username: string;
  };
  ware: {
    id: number;
    name: string;
  };
}

export default function UsersPage() {
  const [request, setRequest] = useState<Request[]>([]);
  const [loading, setLoading] = useState(false);
  const [drawerVisible, setDrawerVisible] = useState(false);
  const [form] = Form.useForm();
  const [merchants, setMerchants] = useState([]);
  const [wares, setWares] = useState([]);
  const [selectedGood, setSelectedGood] = useState<Request | null>(null);
  const [modalVisible, setModalVisible] = useState(false);
  const [user, setUser] = useState<any>(null);
  const [username, setUsername] = useState<string | null>(null);
  const [drawerType, setDrawerType] = useState<'create' | 'in' | 'out'>('create');
  const [goods, setGood] = useState<Good[]>([]);

  const isMerchant = user?.role === 2;
  const merchantId = isMerchant ? user?.id : null;

  useEffect(() => {
    document.title = 'Агуулахын барааны хүсэлт';

    const fetchInitialData = async () => {
      setLoading(true);
      try {
        const userData = typeof window !== 'undefined' ? localStorage.getItem('user') : null;
        const parsedUser = userData ? JSON.parse(userData) : null;
        setUser(parsedUser);
        setUsername(typeof window !== 'undefined' ? localStorage.getItem('username') : null);

        let goodsUrl = `${process.env.NEXT_PUBLIC_API_URL}/api/request`;
        if (parsedUser?.role === 2) {
          goodsUrl += `?merchant_id=${parsedUser.id}`;
        }

        const goodsRes = await fetch(goodsUrl);
        const goodsResult = await goodsRes.json();
        if (goodsResult.success) {
          setRequest(goodsResult.data);
        }

        const userRes = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/user`);
        const userResult = await userRes.json();
        if (userResult.success) {
          setMerchants(userResult.data.filter((u: any) => u.role_id === 2));
        }

        const wareRes = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/ware`);
        const wareResult = await wareRes.json();
        if (wareResult.success) {
          setWares(wareResult.data);
        }
      } catch (err) {
        console.error('Fetch error:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchInitialData();
  }, []);

  const fetchGoods = async () => {
    try {
      let url = `${process.env.NEXT_PUBLIC_API_URL}/api/good`;
      if (user?.role === 2) {
        url += `?merchant_id=${user.id}`;
      }
  
      const res = await fetch(url);
      const result = await res.json();
      if (result.success) {
        setGood(result.data);
      }
    } catch (err) {
      console.error('Failed to fetch goods:', err);
    }
  };
  

  const handleCreateGood = async () => {
    setDrawerVisible(true);
    setDrawerType('create');
    form.setFieldsValue({ type: 1 });
    await fetchGoods();
  };

  const handleDrawerClose = () => {
    setDrawerVisible(false);
    form.resetFields();
  };

  const openNotification = (type: 'success' | 'error' | 'warning', messageText: string) => {
    let backgroundColor = '#52c41a';
    if (type === 'error') backgroundColor = '#ff4d4f';
    else if (type === 'warning') backgroundColor = '#fa8c16';

    notification.open({
      message: null,
      description: <div style={{ color: 'white' }}>{messageText}</div>,
      duration: 4,
      style: { backgroundColor, borderRadius: '4px' },
      closeIcon: <CloseOutlined style={{ color: '#fff' }} />,
    });
  };

 
  const handleFormSubmit = async () => {
    try {
      const values = await form.validateFields();
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/request/stock`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(values),
      });

      const result = await response.json();
      if (response.ok) {
        setRequest((prev) => [...prev, result.data]);
        handleDrawerClose();
      } else {
        console.error('Failed to create good:', result.message);
      }
    } catch (error) {
      console.error('Validation or request failed:', error);
    }
  };

  const baseColumns: ColumnsType<Request> = [
    {
      title: 'Агуулах',
      dataIndex: ['ware', 'name'],
    },
    {
      title: 'Дэлгүүр',
      dataIndex: ['merchant', 'username'],
    },
    {
      title: 'Барааны нэр',
      render: (_: any, record: Request) => {
        if (record.type === 1) {
          return record.name;
        } else if ((record.type === 2 || record.type === 3) && record.good) {
          return record.good.name;
        } else {
          return '-';
        }
      },
    },
    {
      title: 'Тоо',
      dataIndex: 'stock',
    },
    {
      title: 'Төрөл',
      dataIndex: 'type',
      render: (value: number) => {
        switch (value) {
          case 1:
            return <Tag color="green">Бараа үүсгэх</Tag>;
          case 2:
            return <Tag color="blue">Орлогдох</Tag>;
          case 3:
            return <Tag color="volcano">Зарлагадах</Tag>;
          default:
            return <Tag color="default">Төрөл ({value})</Tag>;
        }
      },
    },
    {
      title: 'Төлөв',
      dataIndex: 'status',
      render: (value: number) => {
        switch (value) {
          case 1: return <Tag color="gold">Шинэ</Tag>;
          case 2: return <Tag color="success">Зөвшөөрсөн</Tag>;
          case 3: return <Tag color="red">Цуцалсан</Tag>;
          default: return <Tag color="default">Төлөв ({value})</Tag>;
        }
      },
    },
  ];
  
  // 👇 Conditionally add the action column for admin role (role === 1)
  const columns: ColumnsType<Request> = [
    ...baseColumns,
    ...(user?.role === 1
      ? [{
        title: 'Үйлдэл',
        key: 'action',
        render: (_: any, record: Request) => (
          record.status === 1 ? (
            <Space>
              <Button
                type="link"
                icon={<CheckCircleOutlined style={{ color: 'green' }} />}
                onClick={() => handleApprove(record.id)}
              >
                Зөвшөөрөх
              </Button>
              <Button
                type="link"
                danger
                icon={<CloseCircleOutlined />}
                onClick={() => handleDecline(record.id)}
              >
                Цуцлах
              </Button>
            </Space>
          ) : null
        ),
      }
      ]
      : [])
  ];
  
  const handleApprove = async (id: number) => {
    try {
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/request/approve/${id}`, {
        method: 'PUT',
      });
      const result = await response.json();
      if (result.success) {
        openNotification('success', 'Амжилттай зөвшөөрлөө');
        setRequest((prev) =>
          prev.map((req) => (req.id === id ? { ...req, status: 2 } : req))
        );
      } else {
        openNotification('error', result.message || 'Амжилтгүй');
      }
    } catch (error) {
      console.error(error);
      openNotification('error', 'Алдаа гарлаа');
    }
  };
  
  const handleDecline = async (id: number) => {
    try {
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/request/decline/${id}`, {
        method: 'PUT',
      });
      const result = await response.json();
      if (result.success) {
        openNotification('error', 'Амжилттай цуцаллаа');
      } else {
        openNotification('error', result.message || 'Амжилтгүй');
      }
    } catch (error) {
      console.error(error);
      openNotification('error', 'Алдаа гарлаа');
    }
  };
  
  return (
    <div>
      <h1 style={{ marginBottom: 24 }}>Агуулахын бараа</h1>
      <Space style={{ marginBottom: 16, width: '100%' }} wrap>
        <Button type="primary" style={{ marginLeft: 'auto' }} onClick={handleCreateGood}>
          + Хүсэлт үүсгэх
        </Button>
      </Space>

      <Table columns={columns} dataSource={request} rowKey="id" loading={loading} />

      <Drawer
        title={drawerType === 'create' ? 'Бараа үүсгэх' : drawerType === 'in' ? 'Орлого нэмэх' : 'Зарлага хасах'}
        width={400}
        onClose={handleDrawerClose}
        visible={drawerVisible}
        bodyStyle={{ paddingBottom: 80 }}
      >
        <Form
          layout="vertical"
          form={form}
          onFinish={handleFormSubmit}
          initialValues={{ type: 1 }}
          onValuesChange={(changedValues) => {
            if (changedValues.type) {
              switch (changedValues.type) {
                case 1: setDrawerType('create'); break;
                case 2: setDrawerType('in'); fetchGoods(); break;
                case 3: setDrawerType('out'); fetchGoods(); break;
              }
            }
          }}
        >
          <Form.Item name="type" label="Үйлдэл" rules={[{ required: true }]}>
            <Radio.Group>
              <Radio value={1}>Бараа үүсгэх</Radio>
              <Radio value={2}>Орлого</Radio>
              <Radio value={3}>Зарлага</Radio>
            </Radio.Group>
          </Form.Item>

          {drawerType === 'create' && (
            <>
              <Form.Item name="name" label="Барааны нэр" rules={[{ required: true }]}>
                <Input />
              </Form.Item>
              <Form.Item
  name="amount"
  label="Үлдэгдэл"
  rules={[
    { required: true, message: 'Үлдэгдэл оруулна уу' },
    { type: 'number', min: 0, message: 'Үлдэгдэл 0-с их тоо байх ёстой' },
  ]}
>
  <InputNumber style={{ width: '100%' }} min={0} />
</Form.Item>
            </>
          )}

          {(drawerType === 'in' || drawerType === 'out') && (
            <>
              <Form.Item name="good_id" label="Бараа" rules={[{ required: true }]}>
                <Select placeholder="Бараа сонгох">
                  {goods.map((good: any) => (
                    <Option key={good.id} value={good.id}>{good.name}</Option>
                  ))}
                </Select>
              </Form.Item>
              <Form.Item
  name="amount"
  label="Тоо хэмжээ"
  rules={[
    { required: true, message: 'Тоо хэмжээ оруулна уу' },
    {
      type: 'number',
      min: 1,
      message: 'Тоо хэмжээ эерэг тоо байх ёстой',
    },
  ]}
>
  <InputNumber style={{ width: '100%' }} min={1} />
</Form.Item>
            </>
          )}

          {isMerchant ? (
            <>
              <Form.Item label="Дэлгүүр">
                <div style={{ padding: '4px 11px', border: '1px solid #d9d9d9', borderRadius: 2, backgroundColor: '#f5f5f5' }}>
                  {username}
                </div>
              </Form.Item>
              <Form.Item name="merchant_id" initialValue={merchantId} hidden>
                <Input />
              </Form.Item>
            </>
          ) : (
            <Form.Item name="merchant_id" label="Дэлгүүр" rules={[{ required: true }]}>
              <Select placeholder="Дэлгүүр сонгох">
                {merchants.map((merchant: any) => (
                  <Option key={merchant.id} value={merchant.id}>{merchant.username}</Option>
                ))}
              </Select>
            </Form.Item>
          )}

          <Form.Item name="ware_id" label="Агуулах" rules={[{ required: true }]}>
            <Select placeholder="Агуулах сонгох">
              {wares.map((ware: any) => (
                <Option key={ware.id} value={ware.id}>{ware.name}</Option>
              ))}
            </Select>
          </Form.Item>

          <Form.Item>
            <Button type="primary" htmlType="submit" block>
              Хадгалах
            </Button>
          </Form.Item>
        </Form>
      </Drawer>

      
    </div>
  );
}
