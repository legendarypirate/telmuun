"use client";

import { FormEvent, useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent, CardHeader } from "@/components/ui/card";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";

interface Order {
  id: number;
  phone: string;
  address: string;
  status: string;
  created_at: string;
}

export default function LoginPage() {
  const [loading, setLoading] = useState(false);
  const router = useRouter();
  const [phone, setPhone] = useState("");
  const [orders, setOrders] = useState<Order[] | null>(null);
  const [modalOpen, setModalOpen] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");

  useEffect(() => {
    document.title = "Нэвтрэх";
  }, []);

  const handleLogin = async (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    if (!username || !password) {
      toast.error("Нэвтрэх нэр болон нууц үгээ оруулна уу!");
      return;
    }
    setLoading(true);
    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/auth/login`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username, password }),
      });
      const data = await res.json();
      if (res.ok && data.success) {
        toast.success("Амжилттай нэвтрэлээ!");
        const { token, user } = data;
        localStorage.setItem("token", token);
        localStorage.setItem("user", JSON.stringify(user));
        localStorage.setItem("permissions", JSON.stringify(user.permissions));
        localStorage.setItem("role", user.role?.toString() ?? "");
        localStorage.setItem("username", user.username);
        router.push("/admin");
      } else {
        toast.error(data.message || "Нэвтрэх нэр эсвэл нууц үг буруу байна!");
      }
    } catch (err) {
      console.error(err);
      toast.error("Сервертэй холбогдож чадсангүй!");
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
      const res = await fetch("/api/delivery/check-delivery", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ phone }),
      });
      if (!res.ok) throw new Error("Алдаа гарлаа. Дахин оролдоно уу.");
      const data: Order[] = await res.json();
      setOrders(data);
    } catch (err: any) {
      setError(err.message || "Алдаа гарлаа. Дахин оролдоно уу.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div
      className="min-h-screen w-screen flex items-center justify-center px-4 bg-cover bg-center"
      style={{ backgroundImage: "url(/zs.png)" }}
    >
      <Card className="w-full max-w-md border-l-4 border-blue-600">
        <CardHeader>
          <h5 className="text-lg font-semibold">Захиалга шалгах</h5>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleCheckSubmit} className="mb-6 space-y-3">
            <Input
              type="text"
              name="phone"
              placeholder="Утасны дугаар"
              required
              value={phone}
              onChange={(e) => setPhone(e.target.value)}
            />
            <Button type="submit" className="w-full" disabled={loading}>
              Шалгах
            </Button>
          </form>

          <Dialog open={modalOpen} onOpenChange={setModalOpen}>
            <DialogContent className="max-w-3xl">
              <DialogHeader>
                <DialogTitle className="bg-blue-600 text-white px-4 py-2 rounded">
                  Захиалгын мэдээлэл
                </DialogTitle>
              </DialogHeader>
              {loading && <p className="text-center text-muted-foreground">Уншиж байна...</p>}
              {error && <div className="text-center text-red-600">{error}</div>}
              {!loading && !error && orders && orders.length === 0 && (
                <div className="text-center text-yellow-700">Хайлтаар илэрсэн захиалга алга</div>
              )}
            </DialogContent>
          </Dialog>

          <hr className="my-6" />

          <h5 className="mb-4 text-lg font-semibold">Нэвтрэх</h5>
          <form onSubmit={handleLogin} className="space-y-3">
            <Input
              type="text"
              name="name"
              placeholder="Нэвтрэх нэр"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              required
            />
            <Input
              type="password"
              name="password"
              placeholder="Нууц үг"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
            <Button type="submit" className="w-full" disabled={loading}>
              Нэвтрэх
            </Button>
          </form>
        </CardContent>
      </Card>
    </div>
  );
}
