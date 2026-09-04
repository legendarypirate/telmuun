const API_URL = process.env.NEXT_PUBLIC_API_URL || "";

export function getAuthHeaders(): Record<string, string> {
  const token = typeof window !== "undefined" ? localStorage.getItem("token") : null;
  return {
    "Content-Type": "application/json",
    ...(token ? { Authorization: `Bearer ${token}` } : {}),
  };
}

export async function apiGet<T = any>(path: string): Promise<T> {
  const res = await fetch(`${API_URL}${path}`, { headers: getAuthHeaders() });
  const data = await res.json().catch(() => ({}));
  if (!res.ok || data.success === false) {
    throw new Error(data.message || `Request failed: ${res.status}`);
  }
  return data as T;
}

export const queryKeys = {
  deliveries: (params: Record<string, unknown>) => ["deliveries", params] as const,
  goods: (merchantId?: number) => ["goods", merchantId ?? "all"] as const,
  goodHistory: (id: number) => ["good-history", id] as const,
  merchants: ["merchants"] as const,
  drivers: ["drivers"] as const,
  statuses: ["statuses"] as const,
  wares: ["wares"] as const,
  users: ["users"] as const,
  requests: (merchantId?: number) => ["requests", merchantId ?? "all"] as const,
  reports: (params: Record<string, unknown>) => ["reports", params] as const,
  productReport: (params: Record<string, unknown>) => ["product-report", params] as const,
  driverReport: (params: Record<string, unknown>) => ["driver-report", params] as const,
  roles: ["roles"] as const,
  permissions: ["permissions"] as const,
  regions: ["regions"] as const,
  notifications: ["notifications"] as const,
  orders: (params: Record<string, unknown>) => ["orders", params] as const,
  dashboard: (merchantId?: number) => ["dashboard", merchantId ?? "all"] as const,
};
