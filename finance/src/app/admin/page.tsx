'use client';

import React, { useEffect, useState } from 'react';
import { Card, Row, Col, Spin } from 'antd';
import {
  ResponsiveContainer,
  ComposedChart,
  Bar,
  Line,
  XAxis,
  YAxis,
  Tooltip,
  Legend,
  CartesianGrid,
} from 'recharts';
import {
  TeamOutlined,
  ShoppingOutlined,
  CarOutlined,
  UserOutlined,
} from '@ant-design/icons';

const nameMap = {
  total: 'Нийт хүргэлт',
  success: 'Амжилттай хүргэлт',
};

export default function Dashboard() {
  const [user, setUser] = useState<any>(null);
  const [username, setUsername] = useState<string | null>(null);
  const [stats, setStats] = useState<any[]>([]);
  const [chartData, setChartData] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [showChart, setShowChart] = useState(false);

  useEffect(() => {
    document.title = 'Хянах самбар';

    const fetchStats = async () => {
      try {
        setLoading(true);

        // Load user from localStorage
        const userData =
          typeof window !== 'undefined' ? localStorage.getItem('user') : null;
        const parsedUser = userData ? JSON.parse(userData) : null;
        setUser(parsedUser);
        setUsername(
          typeof window !== 'undefined'
            ? localStorage.getItem('username')
            : null
        );

        // Build stats API URL
        let url = `${process.env.NEXT_PUBLIC_API_URL}/api/delivery/statistic`;
        if (parsedUser?.role === 2 && parsedUser?.id) {
          url += `?merchant_id=${parsedUser.id}`;
        }

        const res = await fetch(url);
        const data = await res.json();

        if (data.success) {
          const deliveriesToday = data.deliveries_today ?? 0;
          const ordersToday = data.orders_today ?? 0;
          const goodsToday = data.goods_today ?? 0;
          const successRate = data.success_rate_percent ?? 0;

          setStats([
            {
              title: 'Нийт хүргэлт',
              value: deliveriesToday,
              color: '#1890ff',
              icon: <CarOutlined style={{ fontSize: 36, marginBottom: 12 }} />,
            },
            {
              title: 'Нийт татан авалт',
              value: ordersToday,
              color: '#eb2f96',
              icon: (
                <ShoppingOutlined style={{ fontSize: 36, marginBottom: 12 }} />
              ),
            },
            {
              title: 'Нийт агуулахын бараа',
              value: goodsToday,
              color: '#fa8c16',
              icon: <TeamOutlined style={{ fontSize: 36, marginBottom: 12 }} />,
            },
            {
              title: 'Гүйцэтгэлийн хувь',
              value: successRate,
              color: '#52c41a',
              icon: <UserOutlined style={{ fontSize: 36, marginBottom: 12 }} />,
            },
          ]);

          setShowChart(deliveriesToday > 0);
        }

        // Dummy last 30 days chart data
        const dummyChart = [];
        const today = new Date();
        for (let i = 29; i >= 0; i--) {
          const day = new Date(today);
          day.setDate(today.getDate() - i);
          const dateStr = day.toISOString().slice(0, 10);
          const total = Math.floor(100 + Math.random() * 200);
          const success = Math.floor(total * (0.75 + Math.random() * 0.25));
          dummyChart.push({ date: dateStr, total, success });
        }
        setChartData(dummyChart);
      } catch (err) {
        console.error('Failed to fetch stats:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchStats();
  }, []);

  if (loading) {
    return (
      <div style={{ padding: 100, textAlign: 'center' }}>
        <Spin size="large" />
      </div>
    );
  }

  return (
    <div style={{ padding: 24 }}>
      <h1 style={{ color: '#082c5c' }}>Хянах самбар</h1>

      {/* Stats Cards */}
      <Row gutter={[32, 32]} style={{ marginTop: 24 }}>
        {stats.map(({ title, value, color, icon }) => (
          <Col xs={24} sm={12} md={6} key={title}>
            <Card
              bordered={false}
              style={{
                backgroundColor: color,
                color: '#fff',
                borderRadius: 16,
                boxShadow: '0 6px 18px rgba(0,0,0,0.2)',
                textAlign: 'center',
                padding: '30px 0',
                userSelect: 'none',
                cursor: 'default',
                transition: 'transform 0.3s ease',
              }}
              bodyStyle={{
                padding: 0,
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
              }}
              onMouseEnter={(e) =>
                (e.currentTarget.style.transform = 'scale(1.05)')
              }
              onMouseLeave={(e) =>
                (e.currentTarget.style.transform = 'scale(1)')
              }
            >
              {icon}
              <h3
                style={{
                  margin: 0,
                  fontSize: 20,
                  fontWeight: '600',
                  marginBottom: 10,
                }}
              >
                {title}
              </h3>
              <span style={{ fontSize: 38, fontWeight: '700' }}>{value}</span>
            </Card>
          </Col>
        ))}
      </Row>

      {/* Delivery Chart */}
      {showChart && (
        <div style={{ width: '100%', height: 350, marginTop: 48 }}>
          <h2
            style={{ textAlign: 'center', color: '#082c5c', marginBottom: 20 }}
          >
            Хүргэлтийн мэдээ (сүүлийн 30 өдөр)
          </h2>
          <ResponsiveContainer>
            <ComposedChart
              data={chartData}
              margin={{ top: 10, right: 30, bottom: 30, left: 0 }}
            >
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis
                dataKey="date"
                tickFormatter={(str) => str.slice(5)}
                interval={4}
                stroke="#082c5c"
              />
              <YAxis stroke="#082c5c" />
              <Tooltip
                formatter={(value, name) => {
                  if (typeof name === 'string' && name in nameMap) {
                    return [value, nameMap[name as keyof typeof nameMap]];
                  }
                  return [value, name];
                }}
                labelFormatter={(label) => `Огноо: ${label}`}
              />
              <Legend
                verticalAlign="top"
                height={36}
                wrapperStyle={{ color: '#082c5c', fontWeight: '600' }}
                formatter={(value) => {
                  if (typeof value === 'string' && value in nameMap) {
                    return nameMap[value as keyof typeof nameMap];
                  }
                  return value;
                }}
              />
              <Bar
                dataKey="total"
                name="Нийт хүргэлт"
                barSize={18}
                fill="#1890ff"
                radius={[6, 6, 0, 0]}
              />
              <Line
                type="monotone"
                dataKey="success"
                name="Амжилттай хүргэлт"
                stroke="#52c41a"
                strokeWidth={3}
                dot={{ r: 3 }}
                activeDot={{ r: 6 }}
              />
            </ComposedChart>
          </ResponsiveContainer>
        </div>
      )}
    </div>
  );
}
//tulbur tulugdsun esehiig jagsaaltad yalgah, anh uusgehed tulbur tulsun gej checkleed uusgeh, oron nutgiih gej neg uusgeh, oron nutgiinh bol hurgesen darah ued utas, mashinii nomer bicheed hadgalana, ugui bol hurgegdku , joloochiin tailan dr nogoortson bol -3999 g zuer 0 blgah, 
//hariltsagch report harah hesgiig zasah
