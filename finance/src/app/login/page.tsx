'use client';

import React, { useState, useEffect, FormEvent } from 'react';
import { notification } from 'antd';
import { CloseOutlined } from '@ant-design/icons';
import { useRouter } from 'next/navigation';

interface Order {
  id: number;
  phone: string;
  address: string;
  status: string;
  created_at: string;
}

export default function LoginPage() {
  const [loading, setLoading] = useState(false);
  const [title, setTitle] = useState('');
  const router = useRouter();
  const [phone, setPhone] = useState('');
  const [orders, setOrders] = useState<Order[] | null>(null);
  const [modalOpen, setModalOpen] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

  useEffect(() => {
    setTitle('Нэвтрэх');
    document.title = 'Нэвтрэх';
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

  const handleLogin = async (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    if (!username || !password) {
      openNotification('error', 'Нэвтрэх нэр болон нууц үгээ оруулна уу!');
      return;
    }
    setLoading(true);
    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/auth/login`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ username, password }),
      });
      const data = await res.json();
      if (res.ok && data.success) {
        openNotification('success', 'Амжилттай нэвтрэлээ!');
        const { token, user } = data;
        localStorage.setItem('token', token);
        localStorage.setItem('user', JSON.stringify(user));
        localStorage.setItem('permissions', JSON.stringify(user.permissions));
        localStorage.setItem('role', user.role?.toString() ?? '');
        localStorage.setItem('username', user.username);
        router.push('/admin');
      } else {
        openNotification('error', data.message || 'Нэвтрэх нэр эсвэл нууц үг буруу байна!');
      }
    } catch (error) {
      console.error(error);
      openNotification('error', 'Сервертэй холбогдож чадсангүй!');
    } finally {
      setLoading(false);
    }
  };

  const handleCheckSubmit = async (e: FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError(null);
    setOrders(null);
    setModalOpen(true);

    try {
      const res = await fetch('/api/delivery/check-delivery', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ phone }),
      });
      if (!res.ok) throw new Error('Алдаа гарлаа. Дахин оролдоно уу.');
      const data: Order[] = await res.json();
      setOrders(data);
    } catch (err: any) {
      setError(err.message || 'Алдаа гарлаа. Дахин оролдоно уу.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div
      className="min-h-screen w-screen bg-cover bg-center flex items-center justify-center px-4"
      style={{ backgroundImage: 'url(/zs.png)' }}
    >
      {/* Card container with responsive max-width */}
      <div className="w-full max-w-md bg-white rounded-xl shadow-lg p-6 border-l-4 border-blue-600">
        {/* Order Check Section */}
        <h5 className="mb-4 text-lg font-semibold flex items-center gap-2 text-black">
          🚚 Захиалга шалгах
        </h5>
        <form onSubmit={handleCheckSubmit} className="mb-6">
          <input
            type="text"
            name="phone"
            placeholder="Утасны дугаар"
            className="w-full border border-gray-300 rounded px-3 py-2 mb-3 focus:outline-none focus:ring-2 focus:ring-blue-600 text-black"
            required
            value={phone}
            onChange={(e) => setPhone(e.target.value)}
          />
          <button
            type="submit"
            className="w-full bg-blue-600 text-white py-2 rounded hover:bg-blue-700 transition"
            disabled={loading}
          >
            Шалгах
          </button>
        </form>

        {/* Modal for Order Info */}
        {modalOpen && (
          <div
            className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 px-4"
            onClick={() => setModalOpen(false)}
          >
            <div
              className="bg-white rounded-lg shadow-lg max-w-3xl w-full mx-4 p-6"
              onClick={(e) => e.stopPropagation()}
            >
              <div className="flex justify-between items-center mb-4">
                <h5 className="text-white bg-blue-600 px-4 py-2 rounded">
                  Захиалгын мэдээлэл
                </h5>
                <button
                  className="text-black hover:text-gray-600 text-xl font-bold"
                  onClick={() => setModalOpen(false)}
                  aria-label="Close modal"
                >
                  &times;
                </button>
              </div>

              <div>
                {loading && (
                  <p className="text-center text-gray-700">Уншиж байна...</p>
                )}
                {error && (
                  <div className="text-center text-red-600">{error}</div>
                )}
                {!loading && !error && orders && orders.length === 0 && (
                  <div className="text-center text-yellow-700">
                    Хайлтаар илэрсэн захиалга алга
                  </div>
                )}
              </div>
            </div>
          </div>
        )}

        <hr className="my-6" />

        {/* Login Section */}
        <h5 className="mb-4 text-lg font-semibold text-black">🔐 Нэвтрэх</h5>
        <form onSubmit={handleLogin}>
          <div className="mb-3">
            <input
              type="text"
              name="name"
              placeholder="Нэвтрэх нэр"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              className="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-600 text-black"
              required
            />
          </div>
          <div className="mb-3">
            <input
              type="password"
              name="password"
              placeholder="Нууц үг"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-600 text-black"
              required
            />
          </div>
          <button
            type="submit"
            className="w-full bg-green-600 text-white py-2 rounded hover:bg-green-700 transition"
            disabled={loading}
          >
            Нэвтрэх
          </button>
        </form>
      </div>
    </div>
  );
}
