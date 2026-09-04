"use client";

import { useEffect } from "react";
import { useQuery } from "@tanstack/react-query";
import { queryKeys } from "@/lib/api";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Package, ShoppingCart, Truck, TrendingUp } from "lucide-react";
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
} from "recharts";

const nameMap = {
  total: "Нийт хүргэлт",
  success: "Амжилттай хүргэлт",
};

export default function Dashboard() {
  useEffect(() => {
    document.title = "Хянах самбар";
  }, []);

  const merchantId =
    typeof window !== "undefined"
      ? (() => {
          try {
            const parsed = JSON.parse(localStorage.getItem("user") || "null");
            return parsed?.role === 2 ? parsed.id : undefined;
          } catch {
            return undefined;
          }
        })()
      : undefined;

  const { data, isLoading: loading } = useQuery({
    queryKey: queryKeys.dashboard(merchantId),
    queryFn: async () => {
      let url = `${process.env.NEXT_PUBLIC_API_URL}/api/delivery/statistic`;
      if (merchantId) url += `?merchant_id=${merchantId}`;
      const res = await fetch(url);
      const result = await res.json();
      const dummyChart = [];
      const today = new Date();
      for (let i = 29; i >= 0; i--) {
        const day = new Date(today);
        day.setDate(today.getDate() - i);
        const total = Math.floor(100 + Math.random() * 200);
        dummyChart.push({
          date: day.toISOString().slice(0, 10),
          total,
          success: Math.floor(total * (0.75 + Math.random() * 0.25)),
        });
      }
      return {
        stats: result.success
          ? [
              { title: "Нийт хүргэлт", value: result.deliveries_today ?? 0, icon: Truck },
              { title: "Нийт татан авалт", value: result.orders_today ?? 0, icon: ShoppingCart },
              { title: "Нийт агуулахын бараа", value: result.goods_today ?? 0, icon: Package },
              { title: "Гүйцэтгэлийн хувь", value: result.success_rate_percent ?? 0, icon: TrendingUp },
            ]
          : [],
        showChart: (result.deliveries_today ?? 0) > 0,
        chartData: dummyChart,
      };
    },
    staleTime: 30_000,
  });

  const stats = data?.stats || [];
  const chartData = data?.chartData || [];
  const showChart = data?.showChart || false;

  if (loading) return <p className="text-muted-foreground">Ачааллаж байна...</p>;

  return (
    <div>
      <h1 className="text-3xl font-bold mb-6">Хянах самбар</h1>
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        {stats.map(({ title, value, icon: Icon }) => (
          <Card key={title}>
            <CardHeader className="flex flex-row items-center justify-between pb-2">
              <CardTitle className="text-sm font-medium">{title}</CardTitle>
              <Icon className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-3xl font-bold">{value}</div>
            </CardContent>
          </Card>
        ))}
      </div>
      {showChart && (
        <Card className="mt-8">
          <CardHeader><CardTitle>Хүргэлтийн мэдээ (сүүлийн 30 өдөр)</CardTitle></CardHeader>
          <CardContent className="h-80">
            <ResponsiveContainer>
              <ComposedChart data={chartData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="date" tickFormatter={(str) => str.slice(5)} interval={4} />
                <YAxis />
                <Tooltip
                  formatter={(value, name) => [value, nameMap[name as keyof typeof nameMap] || name]}
                  labelFormatter={(label) => `Огноо: ${label}`}
                />
                <Legend />
                <Bar dataKey="total" name="Нийт хүргэлт" barSize={18} fill="#18181b" />
                <Line type="monotone" dataKey="success" name="Амжилттай хүргэлт" stroke="#16a34a" strokeWidth={3} />
              </ComposedChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>
      )}
    </div>
  );
}
