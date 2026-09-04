"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useState, useEffect } from "react";
import { cn } from "@/lib/utils";
import {
  LayoutDashboard,
  Truck,
  ShoppingCart,
  Grid3x3,
  Bell,
  FileText,
  BarChart3,
  User,
  Settings,
  Key,
  Home,
  ChevronDown,
  ChevronRight,
} from "lucide-react";

interface MenuItemType {
  key: string;
  icon: React.ReactNode;
  label: string;
  permission?: string;
  children?: MenuItemType[];
}

function getUserPermissions(): string[] {
  try {
    const userStr = localStorage.getItem("user");
    if (!userStr) return [];
    const user = JSON.parse(userStr);
    return user.permissions || [];
  } catch {
    return [];
  }
}

function hasPermission(permission: string, userPermissions: string[]): boolean {
  if (!permission) return true;
  return userPermissions.includes(permission);
}

function filterMenuByPermission(
  items: MenuItemType[],
  userPermissions: string[]
): MenuItemType[] {
  return items
    .map((item) => {
      if (item.children) {
        const filteredChildren = filterMenuByPermission(item.children, userPermissions);
        const hasParentPermission = hasPermission(item.permission || "", userPermissions);
        if (hasParentPermission || filteredChildren.length > 0) {
          return { ...item, children: filteredChildren };
        }
        return null;
      }
      return hasPermission(item.permission || "", userPermissions) ? item : null;
    })
    .filter((item): item is MenuItemType => {
      if (!item) return false;
      if (item.children && item.children.length === 0) return false;
      return true;
    });
}

const menuItems: MenuItemType[] = [
  { key: "/admin", icon: <LayoutDashboard className="w-4 h-4" />, label: "Хянах самбар", permission: "dashboard:view_dashboard" },
  { key: "/admin/delivery", icon: <Truck className="w-4 h-4" />, label: "Хүргэлт", permission: "delivery:view_delivery" },
  { key: "/admin/order", icon: <ShoppingCart className="w-4 h-4" />, label: "Татан авалт", permission: "order:view_order" },
  { key: "/admin/region", icon: <Grid3x3 className="w-4 h-4" />, label: "Бүс", permission: "region:view_region" },
  { key: "/admin/notification", icon: <Bell className="w-4 h-4" />, label: "Масс мэдэгдэл", permission: "notification:view_notification" },
  {
    key: "good",
    icon: <FileText className="w-4 h-4" />,
    label: "Агуулахын бараа",
    permission: "good:view_good",
    children: [
      { key: "/admin/good", icon: <ShoppingCart className="w-4 h-4" />, label: "Барааны жагсаалт", permission: "good:view_good" },
      { key: "/admin/good-request", icon: <FileText className="w-4 h-4" />, label: "Барааны хүсэлт", permission: "good:view_good" },
    ],
  },
  {
    key: "report",
    icon: <FileText className="w-4 h-4" />,
    label: "Тайлан",
    permission: "reports:view_reports",
    children: [
      { key: "/admin/report", icon: <FileText className="w-4 h-4" />, label: "Тайлан", permission: "reports:view_reports" },
      { key: "/admin/report/product", icon: <FileText className="w-4 h-4" />, label: "Барааны тайлан", permission: "reports:view_reports" },
      { key: "/admin/report/driver", icon: <BarChart3 className="w-4 h-4" />, label: "Жолоочийн тайлан", permission: "reports:view_reports" },
    ],
  },
  { key: "/admin/log", icon: <FileText className="w-4 h-4" />, label: "Үйлдлийн лог", permission: "log:view_log" },
  {
    key: "user",
    icon: <FileText className="w-4 h-4" />,
    label: "Хэрэглэгч",
    permission: "log:view_log",
    children: [
      { key: "/admin/user", icon: <User className="w-4 h-4" />, label: "Харилцагч нар", permission: "log:view_log" },
    ],
  },
  {
    key: "settings",
    icon: <Settings className="w-4 h-4" />,
    label: "Тохиргоо",
    permission: "settings:view_settings",
    children: [
      { key: "/admin/status", label: "Хүргэлтийн төлөвүүд", icon: <User className="w-4 h-4" />, permission: "status:view_status" },
      { key: "/admin/role", label: "Эрхийн зохицуулалт", icon: <Key className="w-4 h-4" />, permission: "role:view_role" },
      { key: "/admin/warehouse", label: "Агуулах бүртгэх", icon: <Home className="w-4 h-4" />, permission: "warehouse:view_warehouse" },
    ],
  },
];

export function Sidebar() {
  const pathname = usePathname();
  const [userPermissions, setUserPermissions] = useState<string[]>([]);
  const [expandedKeys, setExpandedKeys] = useState<Set<string>>(new Set());
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setUserPermissions(getUserPermissions());
    setMounted(true);
  }, []);

  const filteredMenuItems = mounted
    ? filterMenuByPermission(menuItems, userPermissions)
    : [];

  const toggleExpand = (key: string) => {
    setExpandedKeys((prev) => {
      const next = new Set(prev);
      if (next.has(key)) next.delete(key);
      else next.add(key);
      return next;
    });
  };

  const isActive = (key: string): boolean => {
    if (key === pathname) return true;
    const item = menuItems.find((entry) => entry.key === key);
    return !!item?.children?.some((child) => child.key === pathname);
  };

  const renderMenuItem = (item: MenuItemType, level = 0) => {
    const hasChildren = item.children && item.children.length > 0;
    const isExpanded = expandedKeys.has(item.key);
    const active = isActive(item.key);

    if (hasChildren) {
      return (
        <div key={item.key} className="flex flex-col">
          <button
            onClick={() => toggleExpand(item.key)}
            className={cn(
              "flex items-center justify-between w-full px-3 py-2 rounded-md text-sm font-medium transition",
              "hover:bg-muted",
              active ? "bg-muted text-primary" : "text-muted-foreground"
            )}
            style={{ paddingLeft: `${12 + level * 16}px` }}
          >
            <div className="flex items-center gap-2">
              {item.icon}
              <span>{item.label}</span>
            </div>
            {isExpanded ? <ChevronDown className="w-4 h-4" /> : <ChevronRight className="w-4 h-4" />}
          </button>
          {isExpanded && (
            <div className="flex flex-col">
              {item.children?.map((child) => renderMenuItem(child, level + 1))}
            </div>
          )}
        </div>
      );
    }

    return (
      <Link
        key={item.key}
        href={item.key}
        className={cn(
          "flex items-center gap-2 px-3 py-2 rounded-md text-sm font-medium transition",
          "hover:bg-muted",
          active ? "bg-muted text-primary" : "text-muted-foreground"
        )}
        style={{ paddingLeft: `${12 + level * 16}px` }}
      >
        {item.icon}
        <span>{item.label}</span>
      </Link>
    );
  };

  return (
    <aside className="w-64 bg-background border-r flex flex-col h-screen sticky top-0">
      <div className="p-4 border-b">
        <h1 className="text-lg font-bold">Telmuun Delivery</h1>
      </div>
      <nav className="flex-1 overflow-y-auto p-4 space-y-1">
        {filteredMenuItems.map((item) => renderMenuItem(item))}
      </nav>
    </aside>
  );
}
