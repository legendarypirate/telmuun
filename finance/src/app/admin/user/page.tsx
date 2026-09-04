"use client";

import React, { useEffect, useState } from "react";
import { toast } from "sonner";
import { useQueryClient } from "@tanstack/react-query";
import { useUsers } from "@/hooks/use-lookups";
import { queryKeys } from "@/lib/api";
import { Lock, Trash2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import {
  Dialog,
  DialogContent,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Sheet, SheetContent, SheetHeader, SheetTitle } from "@/components/ui/sheet";

interface User {
  id: number;
  username: string;
  email: string;
  phone: string;
  role_id: number;
  createdAt: string;
  updatedAt: string;
}

const ROLE_LABELS: Record<number, string> = {
  1: "admin",
  2: "customer",
  3: "driver",
};

export default function UsersPage() {
  const queryClient = useQueryClient();
  const { data: users = [], isFetching: loading } = useUsers();
  const [drawerVisible, setDrawerVisible] = useState(false);
  const [passwordModalVisible, setPasswordModalVisible] = useState(false);
  const [deleteOpen, setDeleteOpen] = useState(false);
  const [selectedUser, setSelectedUser] = useState<User | null>(null);
  const [form, setForm] = useState({
    username: "",
    email: "",
    phone: "",
    role_id: "",
    password: "",
  });
  const [newPassword, setNewPassword] = useState("");

  const fetchData = () => queryClient.invalidateQueries({ queryKey: queryKeys.users });

  useEffect(() => {
    document.title = "Хэрэглэгч";
  }, []);

  const confirmDelete = async () => {
    if (!selectedUser) return;
    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/user/${selectedUser.id}`, {
        method: "DELETE",
      });
      const json = await res.json();

      if (json.success) {
        toast.success("Амжилттай устгалаа!");
        fetchData();
      } else {
        toast.error(json.message || "Устгахад алдаа гарлаа");
      }
    } catch (err) {
      console.error(err);
      toast.error("Устгахад алдаа гарлаа");
    }
    setDeleteOpen(false);
  };

  const handleDrawerClose = () => {
    setDrawerVisible(false);
    setForm({ username: "", email: "", phone: "", role_id: "", password: "" });
  };

  const handleFormSubmit = async () => {
    try {
      const values = {
        username: form.username,
        email: form.email,
        phone: form.phone,
        role_id: Number(form.role_id),
        password: form.password,
      };
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/user`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(values),
      });
      const result = await response.json();
      if (response.ok && result.success) {
        toast.success("Хэрэглэгч амжилттай үүслээ");
        fetchData();
        handleDrawerClose();
      } else {
        toast.error(result.message || "Алдаа гарлаа");
      }
    } catch (error) {
      console.error(error);
      toast.error("Хэлбэр буруу байна");
    }
  };

  const handlePasswordChangeSubmit = async () => {
    try {
      const response = await fetch(
        `${process.env.NEXT_PUBLIC_API_URL}/api/user/${selectedUser?.id}/password`,
        {
          method: "PATCH",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ password: newPassword }),
        }
      );
      const result = await response.json();
      if (response.ok && result.success) {
        toast.success("Нууц үг амжилттай шинэчлэгдлээ");
        setPasswordModalVisible(false);
      } else {
        toast.error(result.message || "Алдаа гарлаа");
      }
    } catch (error) {
      console.error(error);
      toast.error("Хэлбэр буруу байна");
    }
  };

  return (
    <div>
      <div className="mb-6 flex items-center justify-between">
        <h1 className="text-3xl font-bold">Хэрэглэгч</h1>
        <Button onClick={() => setDrawerVisible(true)}>+ Хэрэглэгч үүсгэх</Button>
      </div>

      <div className="border rounded-md">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Username</TableHead>
              <TableHead>Email</TableHead>
              <TableHead>Phone</TableHead>
              <TableHead>Role</TableHead>
              <TableHead>Actions</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {loading ? (
              <TableRow>
                <TableCell colSpan={5} className="py-8 text-center text-muted-foreground">
                  Ачааллаж байна...
                </TableCell>
              </TableRow>
            ) : (
              users.map((record) => (
                <TableRow key={record.id}>
                  <TableCell>{record.username}</TableCell>
                  <TableCell>{record.email}</TableCell>
                  <TableCell>{record.phone}</TableCell>
                  <TableCell>{ROLE_LABELS[record.role_id] || `Role ${record.role_id}`}</TableCell>
                  <TableCell className="flex gap-1">
                    <Button
                      variant="ghost"
                      size="sm"
                      onClick={() => {
                        setSelectedUser(record);
                        setNewPassword("");
                        setPasswordModalVisible(true);
                      }}
                    >
                      <Lock className="h-4 w-4" /> Change Password
                    </Button>
                    <Button
                      variant="ghost"
                      size="sm"
                      onClick={() => {
                        setSelectedUser(record);
                        setDeleteOpen(true);
                      }}
                    >
                      <Trash2 className="h-4 w-4 text-red-500" /> Delete
                    </Button>
                  </TableCell>
                </TableRow>
              ))
            )}
          </TableBody>
        </Table>
      </div>

      <Sheet open={drawerVisible} onOpenChange={(open) => (open ? setDrawerVisible(true) : handleDrawerClose())}>
        <SheetContent>
          <SheetHeader>
            <SheetTitle>Хэрэглэгч үүсгэх</SheetTitle>
          </SheetHeader>
          <div className="mt-4 space-y-3">
            <div className="space-y-2">
              <Label>Username</Label>
              <Input placeholder="Username" value={form.username} onChange={(e) => setForm((p) => ({ ...p, username: e.target.value }))} />
            </div>
            <div className="space-y-2">
              <Label>Email</Label>
              <Input placeholder="Email" value={form.email} onChange={(e) => setForm((p) => ({ ...p, email: e.target.value }))} />
            </div>
            <div className="space-y-2">
              <Label>Phone</Label>
              <Input placeholder="Phone" value={form.phone} onChange={(e) => setForm((p) => ({ ...p, phone: e.target.value }))} />
            </div>
            <div className="space-y-2">
              <Label>Role</Label>
              <Select value={form.role_id} onValueChange={(v) => setForm((p) => ({ ...p, role_id: v }))}>
                <SelectTrigger><SelectValue placeholder="Select role" /></SelectTrigger>
                <SelectContent>
                  <SelectItem value="1">Admin</SelectItem>
                  <SelectItem value="2">Customer</SelectItem>
                  <SelectItem value="3">Driver</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-2">
              <Label>Password</Label>
              <Input type="password" placeholder="Password" value={form.password} onChange={(e) => setForm((p) => ({ ...p, password: e.target.value }))} />
            </div>
            <Button className="w-full" onClick={handleFormSubmit}>Хадгалах</Button>
          </div>
        </SheetContent>
      </Sheet>

      <Dialog open={passwordModalVisible} onOpenChange={setPasswordModalVisible}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Нууц үг шинэчлэх: {selectedUser?.username}</DialogTitle>
          </DialogHeader>
          <div className="space-y-2">
            <Label>Шинэ нууц үг</Label>
            <Input type="password" value={newPassword} onChange={(e) => setNewPassword(e.target.value)} />
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setPasswordModalVisible(false)}>Цуцлах</Button>
            <Button onClick={handlePasswordChangeSubmit}>Шинэчлэх</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      <Dialog open={deleteOpen} onOpenChange={setDeleteOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Устгахдаа итгэлтэй байна уу?</DialogTitle>
          </DialogHeader>
          <p className="text-sm text-muted-foreground">&quot;{selectedUser?.username}&quot; устгах</p>
          <DialogFooter>
            <Button variant="outline" onClick={() => setDeleteOpen(false)}>Үгүй</Button>
            <Button variant="destructive" onClick={confirmDelete}>Тийм</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
