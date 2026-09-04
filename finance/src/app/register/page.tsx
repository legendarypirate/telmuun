"use client";

import { FormEvent, useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { toast } from "sonner";
import { CheckCircle } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardHeader } from "@/components/ui/card";

export default function RegisterPage() {
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState(false);
  const [userType, setUserType] = useState<"individual" | "organization">("individual");
  const router = useRouter();
  const [form, setForm] = useState({
    lastName: "",
    firstName: "",
    companyName: "",
    registrationNumber: "",
    email: "",
    password: "",
    confirmPassword: "",
    username: "",
    phone: "",
  });

  useEffect(() => {
    document.title = "Бүртгүүлэх";
  }, []);

  const setField = (key: keyof typeof form, value: string) => {
    setForm((prev) => ({ ...prev, [key]: value }));
  };

  const onFinish = async (e: FormEvent) => {
    e.preventDefault();
    setLoading(true);

    if (form.password !== form.confirmPassword) {
      toast.error("Нууц үг тохирохгүй байна!");
      setLoading(false);
      return;
    }

    if (userType === "individual") {
      if (!form.lastName || !form.firstName || !form.registrationNumber || !form.email || !form.password || !form.username || !form.phone) {
        toast.error("Та бүх талбарыг зөв бөглөнө үү!");
        setLoading(false);
        return;
      }
      if (!/^[А-ЯӨҮЁа-яөүё]{2}\d{8}$/.test(form.registrationNumber)) {
        toast.error("Регистрийн дугаар РД12345678 форматаар байх ёстой!");
        setLoading(false);
        return;
      }
    } else {
      if (!form.companyName || !form.registrationNumber || !form.email || !form.password || !form.username || !form.phone) {
        toast.error("Та бүх талбарыг зөв бөглөнө үү!");
        setLoading(false);
        return;
      }
      if (!/^\d{7}$/.test(form.registrationNumber)) {
        toast.error("Регистрийн дугаар 7 оронтой тоо байх ёстой!");
        setLoading(false);
        return;
      }
    }

    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(form.email)) {
      toast.error("Зөв имэйл хаяг оруулна уу!");
      setLoading(false);
      return;
    }
    if (!/^\+?\d{8,15}$/.test(form.phone)) {
      toast.error("Зөв дугаар оруулна уу!");
      setLoading(false);
      return;
    }

    const values =
      userType === "individual"
        ? {
            lastName: form.lastName,
            firstName: form.firstName,
            registrationNumber: form.registrationNumber,
            email: form.email,
            password: form.password,
            confirmPassword: form.confirmPassword,
            username: form.username,
            phone: form.phone,
          }
        : {
            companyName: form.companyName,
            registrationNumber: form.registrationNumber,
            email: form.email,
            password: form.password,
            confirmPassword: form.confirmPassword,
            username: form.username,
            phone: form.phone,
          };

    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/auth/register`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ ...values, userType }),
      });

      const data = await res.json();

      if (res.ok && data.success) {
        toast.success("Таны хүсэлт амжилттай илгээгдлээ, бид тантай 72 цагийн дотор холбогдох болно.");
        setSuccess(true);
      } else if (res.status === 400 && data.message?.includes("аль хэдийн бүртгэгдсэн")) {
        toast.error("Хэрэглэгч бүртгэлтэй байна");
      } else {
        toast.error(data.message || "Бүртгэл амжилтгүй боллоо!");
      }
    } catch {
      toast.error("Сервертэй холбогдож чадсангүй!");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen relative bg-[#dfeaf5]">
      <div className="absolute top-1/2 left-1/2 w-full max-w-[700px] -translate-x-1/2 -translate-y-1/2 px-4">
        <Card>
          <CardHeader>
            <h1 className="text-center font-bold text-xl">Бүртгүүлэх</h1>
          </CardHeader>
          <CardContent>
            {success ? (
              <div className="flex flex-col items-center gap-4 p-6 text-green-600">
                <CheckCircle className="h-16 w-16" />
                <div className="text-center text-base">
                  Таны хүсэлт амжилттай илгээгдлээ, <br />
                  бид тантай 72 цагийн дотор холбогдох болно
                </div>
                <Button className="mt-4" onClick={() => router.push("/")}>
                  Нүүр хуудас руу очих
                </Button>
              </div>
            ) : (
              <form onSubmit={onFinish} className="space-y-4" autoComplete="off">
                <div className="space-y-2">
                  <Label>Бүртгүүлэгчийн төрөл</Label>
                  <div className="flex gap-6">
                    <label className="flex items-center gap-2 text-sm">
                      <input
                        type="radio"
                        name="userType"
                        checked={userType === "individual"}
                        onChange={() => setUserType("individual")}
                      />
                      Хувь хүн
                    </label>
                    <label className="flex items-center gap-2 text-sm">
                      <input
                        type="radio"
                        name="userType"
                        checked={userType === "organization"}
                        onChange={() => setUserType("organization")}
                      />
                      Байгууллага
                    </label>
                  </div>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="space-y-4">
                    {userType === "individual" ? (
                      <>
                        <div className="space-y-2">
                          <Label>Овог</Label>
                          <Input placeholder="Энд бичих" value={form.lastName} onChange={(e) => setField("lastName", e.target.value)} />
                        </div>
                        <div className="space-y-2">
                          <Label>Регистр</Label>
                          <Input placeholder="Энд бичих" value={form.registrationNumber} onChange={(e) => setField("registrationNumber", e.target.value)} />
                        </div>
                      </>
                    ) : (
                      <>
                        <div className="space-y-2">
                          <Label>Байгууллагын нэр</Label>
                          <Input placeholder="Энд бичих" value={form.companyName} onChange={(e) => setField("companyName", e.target.value)} />
                        </div>
                        <div className="space-y-2">
                          <Label>Регистр</Label>
                          <Input placeholder="Энд бичих" value={form.registrationNumber} onChange={(e) => setField("registrationNumber", e.target.value)} />
                        </div>
                      </>
                    )}
                    <div className="space-y-2">
                      <Label>Имэйл</Label>
                      <Input type="email" placeholder="Энд бичих" value={form.email} onChange={(e) => setField("email", e.target.value)} />
                    </div>
                    <div className="space-y-2">
                      <Label>Нууц үг</Label>
                      <Input type="password" placeholder="Энд бичих" value={form.password} onChange={(e) => setField("password", e.target.value)} />
                    </div>
                  </div>

                  <div className="space-y-4">
                    {userType === "individual" && (
                      <div className="space-y-2">
                        <Label>Нэр</Label>
                        <Input placeholder="Энд бичих" value={form.firstName} onChange={(e) => setField("firstName", e.target.value)} />
                      </div>
                    )}
                    <div className="space-y-2">
                      <Label>Дэлгүүрийн нэр</Label>
                      <Input placeholder="Энд бичих" value={form.username} onChange={(e) => setField("username", e.target.value)} />
                    </div>
                    <div className="space-y-2">
                      <Label>Утасны дугаар</Label>
                      <Input placeholder="Энд бичих" value={form.phone} onChange={(e) => setField("phone", e.target.value)} />
                    </div>
                    <div className="space-y-2">
                      <Label>Нууц үг давтах</Label>
                      <Input type="password" placeholder="Энд бичих" value={form.confirmPassword} onChange={(e) => setField("confirmPassword", e.target.value)} />
                    </div>
                  </div>
                </div>

                <Button type="submit" className="w-full" disabled={loading}>
                  {loading ? "Илгээж байна..." : "Бүртгүүлэх"}
                </Button>
              </form>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
