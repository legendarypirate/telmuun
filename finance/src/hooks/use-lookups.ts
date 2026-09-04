"use client";

import { useQuery } from "@tanstack/react-query";
import { apiGet, queryKeys } from "@/lib/api";

export function useMerchants() {
  return useQuery({
    queryKey: queryKeys.merchants,
    queryFn: async () => {
      const result = await apiGet<{ success: boolean; data: any[] }>("/api/user/merchant");
      return (result.data || []).filter((m) => m && m.id != null && (m.status == null || m.status === 2));
    },
    staleTime: 5 * 60_000,
  });
}

export function useDrivers() {
  return useQuery({
    queryKey: queryKeys.drivers,
    queryFn: async () => {
      const result = await apiGet<{ success: boolean; data: any[] }>("/api/user/driver");
      return result.data || [];
    },
    staleTime: 5 * 60_000,
  });
}

export function useStatuses() {
  return useQuery({
    queryKey: queryKeys.statuses,
    queryFn: async () => {
      const result = await apiGet<{ success: boolean; data: any[] }>("/api/status");
      return result.data || [];
    },
    staleTime: 10 * 60_000,
  });
}

export function useWares() {
  return useQuery({
    queryKey: queryKeys.wares,
    queryFn: async () => {
      const result = await apiGet<{ success: boolean; data: any[] }>("/api/ware");
      return result.data || [];
    },
    staleTime: 10 * 60_000,
  });
}

export function useGoods(merchantId?: number) {
  return useQuery({
    queryKey: queryKeys.goods(merchantId),
    queryFn: async () => {
      const qs = merchantId ? `?merchant_id=${merchantId}` : "";
      const result = await apiGet<{ success: boolean; data: any[] }>(`/api/good${qs}`);
      return Array.isArray(result.data) ? result.data : [];
    },
    staleTime: 30_000,
  });
}

export function useUsers() {
  return useQuery({
    queryKey: queryKeys.users,
    queryFn: async () => {
      const result = await apiGet<{ success: boolean; data: any[] }>("/api/user");
      return result.data || [];
    },
    staleTime: 60_000,
  });
}

export function useRoles() {
  return useQuery({
    queryKey: queryKeys.roles,
    queryFn: async () => {
      const result = await apiGet<{ success: boolean; data: any[] }>("/api/role");
      return result.data || [];
    },
    staleTime: 5 * 60_000,
  });
}

export function usePermissions() {
  return useQuery({
    queryKey: queryKeys.permissions,
    queryFn: async () => {
      const result = await apiGet<{ success: boolean; data: any[] }>("/api/permission");
      return result.data || [];
    },
    staleTime: 10 * 60_000,
  });
}

export function useRegions() {
  return useQuery({
    queryKey: queryKeys.regions,
    queryFn: async () => {
      const result = await apiGet<{ success: boolean; data: any[] }>("/api/region");
      return result.data || [];
    },
    staleTime: 5 * 60_000,
  });
}

export function useNotifications() {
  return useQuery({
    queryKey: queryKeys.notifications,
    queryFn: async () => {
      const result = await apiGet<{ success: boolean; data: any[] }>("/api/notification");
      return result.data || [];
    },
    staleTime: 30_000,
  });
}

export function useGoodRequests(merchantId?: number, enabled = true) {
  return useQuery({
    queryKey: queryKeys.requests(merchantId),
    queryFn: async () => {
      const qs = merchantId ? `?merchant_id=${merchantId}` : "";
      const result = await apiGet<{ success: boolean; data: any[] }>(`/api/request${qs}`);
      return result.data || [];
    },
    enabled,
    staleTime: 20_000,
  });
}
