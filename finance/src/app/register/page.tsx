'use client';

import React, { useState, useEffect } from 'react';
import Head from 'next/head';
import { Form, Input, Button, Card, notification, Row, Col, Radio } from 'antd';
import {
    CloseOutlined,
    CheckCircleOutlined,
    UserOutlined,
    MailOutlined,
    LockOutlined,
    PhoneOutlined,
    ShopOutlined,
    IdcardOutlined,
    BankOutlined,
  } from '@ant-design/icons';
import { useRouter } from 'next/navigation';

export default function RegisterPage() {
  const [loading, setLoading] = useState(false);
  const [title, setTitle] = useState('');
  const [success, setSuccess] = useState(false);
  const [userType, setUserType] = useState<'individual' | 'organization'>('individual');
  const router = useRouter();

  useEffect(() => {
    setTitle('Бүртгүүлэх');
    document.title = 'Бүртгүүлэх';
  }, []);

  const openNotification = (type: 'success' | 'error', messageText: string) => {
    notification.open({
      message: null,
      description: <div style={{ color: 'white' }}>{messageText}</div>,
      duration: 4,
      style: {
        backgroundColor: type === 'success' ? '#52c41a' : '#ff4d4f',
        borderRadius: '4px',
      },
      closeIcon: <CloseOutlined style={{ color: '#fff' }} />,
    });
  };

  const onFinish = async (values: any) => {
    setLoading(true);
  
    if (values.password !== values.confirmPassword) {
      openNotification('error', 'Нууц үг тохирохгүй байна!');
      setLoading(false);
      return;
    }
  
    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/auth/register`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ ...values, userType }),
      });
  
      const data = await res.json();
  
      if (res.ok && data.success) {
        openNotification('success', 'Таны хүсэлт амжилттай илгээгдлээ, бид тантай 72 цагийн дотор холбогдох болно.');
        setSuccess(true);

      } else if (res.status === 400 && data.message?.includes('аль хэдийн бүртгэгдсэн')) {
        openNotification('error', 'Хэрэглэгч бүртгэлтэй байна');
      } else {
        openNotification('error', data.message || 'Бүртгэл амжилтгүй боллоо!');
      }
    } catch (error) {
      openNotification('error', 'Сервертэй холбогдож чадсангүй!');
    } finally {
      setLoading(false);
    }
  };
  
  const onFinishFailed = () => {
    openNotification('error', 'Та бүх талбарыг зөв бөглөнө үү!');
  };

  return (
    <>
      <Head>
        <title>{title}</title>
      </Head>

      <div style={{ minHeight: '100vh', position: 'relative' }}>
  {/* Top half: Light gray-blue background */}
  <div
    style={{
      height: '100vh',
      backgroundColor: '#dfeaf5', // light gray-blue
    }}
  />

  <div
    style={{
      position: 'absolute',
      top: '50%',
      left: '50%',
      transform: 'translate(-50%, -50%)',
      width: '100%',
      maxWidth: 700,
      padding: '0 16px',
    }}
  >
          <Card title={<div style={{ textAlign: 'center', fontWeight: 'bold' }}>{title}</div>} bordered={false}>
            {success ? (
             <div
             style={{
               display: 'flex',
               flexDirection: 'column',
               alignItems: 'center',
               gap: 16,
               padding: 24,
               color: '#52c41a',
             }}
           >
             <CheckCircleOutlined style={{ fontSize: 64 }} />
             <div style={{ fontSize: 16, textAlign: 'center' }}>
               Таны хүсэлт амжилттай илгээгдлээ, <br />
               бид тантай 72 цагийн дотор холбогдох болно
             </div>
             <Button
               type="primary"
               size="large"
               onClick={() => router.push('/')}
               style={{
                 marginTop: 16,
                 borderRadius: 8,
                 padding: '0 24px',
               }}
             >
               Нүүр хуудас руу очих
             </Button>
           </div>
           
            ) : (
              <Form
                name="register"
                onFinish={onFinish}
                onFinishFailed={onFinishFailed}
                autoComplete="off"
                layout="vertical"
                scrollToFirstError
              >
                <Form.Item label="Бүртгүүлэгчийн төрөл" name="userType" initialValue="individual">
                  <Radio.Group onChange={(e) => setUserType(e.target.value)} value={userType}>
                    <Radio value="individual">Хувь хүн</Radio>
                    <Radio value="organization">Байгууллага</Radio>
                  </Radio.Group>
                </Form.Item>

                <Row gutter={16}>
                  <Col span={12}>
                    {userType === 'individual' ? (
                      <>
                        <Form.Item
                          label="Овог"
                          name="lastName"
                          rules={[{ required: true, message: 'Овог оруулна уу!' }]}
                        >
                          <Input prefix={<UserOutlined />} placeholder="Энд бичих"/>
                        </Form.Item>

                        <Form.Item
                          label="Регистр"
                          name="registrationNumber"
                          rules={[
                            { required: true, message: 'Регистр оруулна уу!' },
                            {
                              pattern: /^[А-ЯӨҮЁа-яөүё]{2}\d{8}$/,
                              message: 'Регистрийн дугаар РД12345678 форматаар байх ёстой!',
                            },
                          ]}
                        >
                          <Input prefix={<IdcardOutlined />} placeholder="Энд бичих"/>
                        </Form.Item>
                      </>
                    ) : (
                      <>
                        <Form.Item
                          label="Байгууллагын нэр"
                          name="companyName"
                          rules={[{ required: true, message: 'Байгууллагын нэр оруулна уу!' }]}
                        >
                          <Input prefix={<IdcardOutlined />} placeholder="Энд бичих"/>
                        </Form.Item>

                        <Form.Item
                          label="Регистр"
                          name="registrationNumber"
                          rules={[
                            { required: true, message: 'Регистр оруулна уу!' },
                            {
                              pattern: /^\d{7}$/,
                              message: 'Регистрийн дугаар 7 оронтой тоо байх ёстой!',
                            },
                          ]}
                        >
                          <Input prefix={<BankOutlined />} placeholder="Энд бичих"/>
                        </Form.Item>
                      </>
                    )}

                    <Form.Item
                      label="Имэйл"
                      name="email"
                      rules={[
                        { required: true, message: 'Имэйл оруулна уу!' },
                        { type: 'email', message: 'Зөв имэйл хаяг оруулна уу!' },
                      ]}
                    >
                      <Input prefix={<MailOutlined />} placeholder="Энд бичих"/>
                    </Form.Item>

                    <Form.Item
                      label="Нууц үг"
                      name="password"
                      rules={[{ required: true, message: 'Нууц үг оруулна уу!' }]}
                      hasFeedback
                    >
                      <Input.Password prefix={<LockOutlined />} placeholder="Энд бичих"/>
                    </Form.Item>
                  </Col>

                  <Col span={12}>
                    {userType === 'individual' && (
                      <Form.Item
                        label="Нэр"
                        name="firstName"
                        rules={[{ required: true, message: 'Нэр оруулна уу!' }]}
                      >
                        <Input prefix={<UserOutlined />} placeholder="Энд бичих"/>
                      </Form.Item>
                    )}

                    <Form.Item
                      label="Дэлгүүрийн нэр"
                      name="username"
                      rules={[{ required: true, message: 'Дэлгүүрийн нэр оруулна уу!' }]}
                    >
                      <Input prefix={<ShopOutlined />} placeholder="Энд бичих"/>
                    </Form.Item>

                    <Form.Item
                      label="Утасны дугаар"
                      name="phone"
                      rules={[
                        { required: true, message: 'Утасны дугаар оруулна уу!' },
                        { pattern: /^\+?\d{8,15}$/, message: 'Зөв дугаар оруулна уу!' },
                      ]}
                    >
                      <Input prefix={<PhoneOutlined />} placeholder="Энд бичих"/>
                    </Form.Item>

                    <Form.Item
                      label="Нууц үг давтах"
                      name="confirmPassword"
                      dependencies={['password']}
                      hasFeedback
                      rules={[
                        { required: true, message: 'Нууц үгээ давтан оруулна уу!' },
                        ({ getFieldValue }) => ({
                          validator(_, value) {
                            if (!value || getFieldValue('password') === value) {
                              return Promise.resolve();
                            }
                            return Promise.reject(new Error('Нууц үг тохирохгүй байна!'));
                          },
                        }),
                      ]}
                    >
                      <Input.Password prefix={<LockOutlined />} placeholder="Энд бичих"/>
                    </Form.Item>
                  </Col>
                </Row>

                <Form.Item>
                  <Button type="primary" htmlType="submit" block loading={loading}>
                    Бүртгүүлэх
                  </Button>
                </Form.Item>
              </Form>
            )}
          </Card>
        </div>
      </div>
    </>
  );
}
