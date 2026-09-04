import { User } from "../types/delivery";

const API_URL = process.env.NEXT_PUBLIC_API_URL || "";

function getAuthHeaders(): Record<string, string> {
  const token = typeof window !== "undefined" ? localStorage.getItem("token") : null;
  return {
    "Content-Type": "application/json",
    ...(token ? { Authorization: `Bearer ${token}` } : {}),
  };
}

async function apiGet<T = any>(endpoint: string): Promise<T> {
  const res = await fetch(`${API_URL}/api${endpoint}`, {
    method: "GET",
    headers: getAuthHeaders(),
  });
  const data = await res.json().catch(() => ({}));
  if (!res.ok) throw new Error((data as any).message || `Request failed: ${res.status}`);
  return data as T;
}

export const fetchMerchants = async (): Promise<User[]> => {
  const result = await apiGet<{ success: boolean; data: User[]; message?: string }>("/user/merchant");
  if (result.success) return result.data || [];
  throw new Error(result.message || "Failed to fetch merchants");
};

export const fetchDrivers = async (): Promise<User[]> => {
  const result = await apiGet<{ success: boolean; data: User[]; message?: string }>("/user/driver");
  if (result.success) return result.data || [];
  throw new Error(result.message || "Failed to fetch drivers");
};
