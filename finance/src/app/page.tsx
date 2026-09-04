"use client";

import { FormEvent, useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent, CardHeader } from "@/components/ui/card";

export default function LoginPage() {
  const [loading, setLoading] = useState(false);
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const router = useRouter();

  useEffect(() => {
    document.title = "Нэвтрэх";
  }, []);

  const handleLogin = async (e: FormEvent) => {
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
        localStorage.setItem("token", data.token);
        localStorage.setItem("user", JSON.stringify(data.user));
        localStorage.setItem("permissions", JSON.stringify(data.user.permissions));
        localStorage.setItem("role", data.user.role?.toString() ?? "");
        localStorage.setItem("username", data.user.username);
        toast.success("Амжилттай нэвтрэлээ!");
        router.push("/admin");
      } else {
        toast.error(data.message || "Нэвтрэх нэр эсвэл нууц үг буруу байна!");
      }
    } catch {
      toast.error("Сервертэй холбогдож чадсангүй!");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div
      className="min-h-screen w-screen flex items-center justify-center px-4"
      style={{ backgroundImage: "url(/backgr.jpg)", backgroundSize: "cover", backgroundPosition: "center" }}
    >
      <Card className="w-full max-w-sm">
        <CardHeader>
          <h1 className="text-2xl font-bold text-center">Нэвтрэх</h1>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleLogin} className="space-y-4">
            <Input placeholder="Нэвтрэх нэр" value={username} onChange={(e) => setUsername(e.target.value)} />
            <Input type="password" placeholder="Нууц үг" value={password} onChange={(e) => setPassword(e.target.value)} />
            <Button type="submit" className="w-full" disabled={loading}>
              {loading ? "Нэвтрэж байна..." : "Нэвтрэх"}
            </Button>
          </form>
        </CardContent>
      </Card>
    </div>
  );
}
