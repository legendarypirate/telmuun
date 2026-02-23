'use client';

import React, { useState, useTransition, useEffect } from 'react';
import { Layout, Menu, message, Spin, Modal, Dropdown, Avatar, MenuProps } from 'antd';
import {
  DashboardOutlined, UserOutlined, SettingOutlined, TruckOutlined, ShoppingCartOutlined,
  AppstoreAddOutlined, BellOutlined, HomeOutlined, FileTextOutlined, KeyOutlined,
  LogoutOutlined, BarChartOutlined, ShoppingOutlined
} from '@ant-design/icons';
import { usePathname, useRouter } from 'next/navigation';

const { Header, Sider, Content } = Layout;

// --- Types ---
interface MyMenuItem {
  key: string;
  icon?: React.ReactNode;
  label: React.ReactNode;
  permission?: string;
  children?: MyMenuItem[];
}

// --- Helpers ---
function getUserPermissions(): string[] {
  try {
    const userStr = localStorage.getItem('user');
    if (!userStr) return [];
    const user = JSON.parse(userStr);
    return user.permissions || [];
  } catch (e) {
    console.error('Failed to parse user from localStorage', e);
    return [];
  }
}

function getUserName(): string {
  try {
    const userStr = localStorage.getItem('user');
    if (!userStr) return 'Хэрэглэгч';
    const user = JSON.parse(userStr);
    return user.name || 'Хэрэглэгч';
  } catch {
    return 'Хэрэглэгч';
  }
}

function hasPermission(permission: string, userPermissions: string[]): boolean {
  if (!permission) return true;
  return userPermissions.includes(permission);
}

function filterMenuByPermission(items: MyMenuItem[], userPermissions: string[]): MyMenuItem[] {
  return items
    .filter(item => hasPermission(item.permission || '', userPermissions))
    .map(item => ({
      ...item,
      children: item.children ? filterMenuByPermission(item.children, userPermissions) : undefined
    }));
}

// Convert custom menu to Ant Design MenuProps['items']
function convertToAntMenuItems(items: MyMenuItem[]): MenuProps['items'] {
  return items.map(item => ({
    key: item.key,
    icon: item.icon,
    label: item.label,
    children: item.children ? convertToAntMenuItems(item.children) : undefined,
  }));
}

// --- Component ---
export default function AdminLayout({ children }: { children: React.ReactNode }) {
  const router = useRouter();
  const pathname = usePathname();
  const [loading, setLoading] = useState(false);
  const [isPending, startTransition] = useTransition();
  const [userPermissions, setUserPermissions] = useState<string[]>([]);
  const [userName, setUserName] = useState<string>('Хэрэглэгч');

  useEffect(() => {
    setUserPermissions(getUserPermissions());
    setUserName(getUserName());
  }, []);

  const handleLogout = () => {
    message.success('Амжилттай гарлаа');
    localStorage.removeItem('user');
    localStorage.removeItem('token');
    router.push('/');
  };

  const showConfirm = () => {
    Modal.confirm({
      title: 'Та гарахдаа итгэлтэй байна уу?',
      okText: 'Тийм',
      cancelText: 'Үгүй',
      centered: true,
      width: 500,
      onOk: handleLogout,
    });
  };

  const userMenu = (
    <Menu>
      <Menu.Item key="userinfo" icon={<UserOutlined />} disabled>
        Таны нэр: {userName}
      </Menu.Item>
      <Menu.Divider />
      <Menu.Item key="logout" icon={<LogoutOutlined />} onClick={showConfirm} danger>
        Гарах
      </Menu.Item>
    </Menu>
  );

  const handleMenuClick: MenuProps['onClick'] = (e) => {
    setLoading(true);
    router.push(e.key);
    setTimeout(() => setLoading(false), 500);
  };

  // --- Menu items ---
  const menuItems: MyMenuItem[] = [
    { key: '/admin', icon: <DashboardOutlined />, label: 'Хянах самбар', permission: 'dashboard:view_dashboard' },
    { key: '/admin/delivery', icon: <TruckOutlined />, label: 'Хүргэлт', permission: 'delivery:view_delivery' },
    { key: '/admin/order', icon: <ShoppingCartOutlined />, label: 'Татан авалт', permission: 'order:view_order' },
    { key: '/admin/region', icon: <AppstoreAddOutlined />, label: 'Бүс', permission: 'region:view_region' },
    { key: '/admin/notification', icon: <BellOutlined />, label: 'Масс мэдэгдэл', permission: 'notification:view_notification' },
    {
      key: 'good',
      icon: <FileTextOutlined />,
      label: 'Агуулахын бараа',
      permission: 'good:view_good',
      children: [
        { key: '/admin/good', icon: <ShoppingOutlined />, label: 'Барааны жагсаалт', permission: 'good:view_good' },
        { key: '/admin/request', icon: <BarChartOutlined />, label: 'Барааны хүсэлт', permission: 'good:view_good' },
      ],
    },
    {
      key: 'report',
      icon: <FileTextOutlined />,
      label: 'Тайлан',
      children: [
        { key: '/admin/driverreport', icon: <BarChartOutlined />, label: 'Жолоочийн тайлан', permission: 'reports:view_reports' },
        { key: '/admin/merchantreport', icon: <BarChartOutlined />, label: 'Харилцагчийн тайлан', permission: 'reports:view_reports' },

      ],
    },
    { key: '/admin/log', icon: <FileTextOutlined />, label: 'Үйлдлийн лог', permission: 'log:view_log' },
     {
      key: 'user',
      icon: <FileTextOutlined />,
      label: 'Хэрэглэгч',
      permission: 'log:view_log',
      children: [
        { key: '/admin/user', icon: <UserOutlined />, label: 'Хэрэглэгч нар', },
        { key: '/admin/request', icon: <FileTextOutlined />, label: 'Ирсэн хүсэлтүүд', },
      ],
    },
    {
      key: 'settings',
      icon: <SettingOutlined />,
      label: 'Тохиргоо',
      permission: 'settings:view_settings',
      children: [
        { key: '/admin/status', label: 'Хүргэлтийн төлөвүүд', icon: <UserOutlined />, permission: 'status:view_status' },
        { key: '/admin/role', label: 'Эрхийн зохицуулалт', icon: <KeyOutlined />, permission: 'role:view_role' },
        { key: '/admin/warehouse', label: 'Агуулах бүртгэх', icon: <HomeOutlined />, permission: 'warehouse:view_warehouse' },
      ],
    }
  ];

  const filteredMenuItems = convertToAntMenuItems(
    filterMenuByPermission(menuItems, userPermissions)
  );

  return (
    <Layout style={{ minHeight: '100vh' }}>
<Sider
  breakpoint="lg"
  collapsedWidth="0"
  style={{ background: '#004e6c' }}
>
  <div className="logo" style={{
    color: '#fff',
    padding: 16,
    textAlign: 'center',
    fontWeight: 'bold',
    fontSize: 14,
  }}>
    Telmuun Delivery
  </div>

  <Menu
    theme="dark"        // keep dark for white text
    mode="inline"
    selectedKeys={[pathname]}
    onClick={handleMenuClick}
    items={filteredMenuItems}
    style={{ background: 'transparent' }} // inherit Sider bg
  />
</Sider>



      <Layout>
        <Header
  style={{
    background: '#fff', // same deep color
    padding: '0 24px',
    display: 'flex',
    justifyContent: 'flex-end',
    alignItems: 'center',
  }}
>
  <Dropdown overlay={userMenu} trigger={['click']} placement="bottomRight" arrow>
    <Avatar
      size="large"
      style={{ cursor: 'pointer', backgroundColor: '#fff', color: '#0e9c94' }}
      icon={<UserOutlined />}
    />
  </Dropdown>
</Header>

        <Content style={{ margin: '24px 16px 0' }}>
          <Spin spinning={loading || isPending} tip="Ачааллаж байна..." size="large">
            <div style={{ padding: 24, background: '#fff', minHeight: 360 }}>
              {children}
            </div>
          </Spin>
        </Content>
      </Layout>
    </Layout>
  );
}
