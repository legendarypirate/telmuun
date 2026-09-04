"use client";

import React, { useEffect, useMemo, useState } from "react";
import { toast } from "sonner";
import { useQueryClient } from "@tanstack/react-query";
import { useUsers } from "@/hooks/use-lookups";
import { getAuthHeaders, queryKeys } from "@/lib/api";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  FilterBar,
  FilterField,
  FilterInput,
} from "@/components/ui/filter-bar";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import {
  TableActions,
  TableEditButton,
  TableDeleteButton,
  TableLockButton,
} from "@/components/ui/table-actions";
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
  report_price?: number;
}

const API = process.env.NEXT_PUBLIC_API_URL || "";

export default function UsersPage() {
  const queryClient = useQueryClient();
  const { data: users = [], isFetching: loading } = useUsers();
  const [searchText, setSearchText] = useState("");
  const [drawerVisible, setDrawerVisible] = useState(false);
  const [passwordModalVisible, setPasswordModalVisible] = useState(false);
  const [deleteOpen, setDeleteOpen] = useState(false);
  const [selectedUser, setSelectedUser] = useState<User | null>(null);
  const [editingUser, setEditingUser] = useState<User | null>(null);
  const [form, setForm] = useState({
    username: "",
    email: "",
    phone: "",
    password: "",
    report_price: "7000",
  });
  const [newPassword, setNewPassword] = useState("");

  const customers = useMemo(
    () =>
      (users as User[]).filter((user) => {
        if (user.role_id !== 2) return false;
        const q = searchText.toLowerCase().trim();
        if (!q) return true;
        return (
          (user.username || "").toLowerCase().includes(q) ||
          (user.email || "").toLowerCase().includes(q) ||
          (user.phone || "").toLowerCase().includes(q)
        );
      }),
    [users, searchText]
  );

  const fetchData = () => {
    queryClient.invalidateQueries({ queryKey: queryKeys.users });
    queryClient.invalidateQueries({ queryKey: queryKeys.merchants });
  };

  useEffect(() => {
    document.title = "Харилцагчийн жагсаалт";
  }, []);

  const openCreate = () => {
    setEditingUser(null);
    setForm({ username: "", email: "", phone: "", password: "", report_price: "7000" });
    setDrawerVisible(true);
  };

  const openEdit = (user: User) => {
    setEditingUser(user);
    setForm({
      username: user.username || "",
      email: user.email || "",
      phone: user.phone || "",
      password: "",
      report_price: String(user.report_price || 7000),
    });
    setDrawerVisible(true);
  };

  const handleDrawerClose = () => {
    setDrawerVisible(false);
    setEditingUser(null);
    setForm({ username: "", email: "", phone: "", password: "", report_price: "7000" });
  };

  const handleFormSubmit = async () => {
    try {
      if (editingUser) {
        const response = await fetch(`${API}/api/user/${editingUser.id}`, {
          method: "PUT",
          headers: getAuthHeaders(),
          body: JSON.stringify({
            username: form.username,
            email: form.email.trim(),
            phone: form.phone,
            report_price: Number(form.report_price) || 7000,
          }),
        });
        const result = await response.json();
        if (response.ok && result.success !== false) {
          toast.success("Харилцагч амжилттай шинэчлэгдлээ");
          fetchData();
          handleDrawerClose();
        } else {
          toast.error(result.message || "Алдаа гарлаа");
        }
        return;
      }

      const response = await fetch(`${API}/api/user`, {
        method: "POST",
        headers: getAuthHeaders(),
        body: JSON.stringify({
          username: form.username,
          email: form.email.trim(),
          phone: form.phone,
          role_id: 2,
          password: form.password,
          report_price: Number(form.report_price) || 7000,
        }),
      });
      const result = await response.json();
      if (response.ok && result.success) {
        toast.success("Харилцагч амжилттай үүслээ");
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
      const response = await fetch(`${API}/api/user/${selectedUser?.id}/password`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ password: newPassword }),
      });
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

  const confirmDelete = async () => {
    if (!selectedUser) return;
    try {
      const res = await fetch(`${API}/api/user/${selectedUser.id}`, { method: "DELETE" });
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

  return (
    <div>
      <div className="mb-6 flex items-center justify-between">
        <h1 className="text-3xl font-bold">Харилцагчийн жагсаалт</h1>
        <Button onClick={openCreate}>+ Харилцагч үүсгэх</Button>
      </div>

      <div className="mb-3 flex items-center gap-4">
        <div className="text-sm text-muted-foreground">Нийт: {customers.length}</div>
      </div>

      <FilterBar>
        <FilterField label="Хайх" className="w-72">
          <FilterInput
            icon="search"
            placeholder="Нэр, имэйл, утсаар хайх..."
            value={searchText}
            onChange={(e) => setSearchText(e.target.value)}
          />
        </FilterField>
      </FilterBar>

      <div className="overflow-hidden rounded-xl border border-border/80 bg-card shadow-sm">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Нэр</TableHead>
              <TableHead>Имэйл</TableHead>
              <TableHead>Утас</TableHead>
              <TableHead>Report Price</TableHead>
              <TableHead>Үйлдэл</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {loading ? (
              <TableRow>
                <TableCell colSpan={5} className="py-8 text-center text-muted-foreground">
                  Ачааллаж байна...
                </TableCell>
              </TableRow>
            ) : customers.length === 0 ? (
              <TableRow>
                <TableCell colSpan={5} className="py-8 text-center text-muted-foreground">
                  Харилцагч олдсонгүй
                </TableCell>
              </TableRow>
            ) : (
              customers.map((record) => (
                <TableRow key={record.id}>
                  <TableCell>{record.username}</TableCell>
                  <TableCell>
                    {record.email?.trim() ? (
                      record.email
                    ) : (
                      <span className="text-muted-foreground">Имэйл байхгүй</span>
                    )}
                  </TableCell>
                  <TableCell>{record.phone}</TableCell>
                  <TableCell>{Number(record.report_price || 7000).toLocaleString()} ₮</TableCell>
                  <TableCell>
                    <TableActions>
                      <TableEditButton onClick={() => openEdit(record)} />
                      <TableLockButton
                        onClick={() => {
                          setSelectedUser(record);
                          setNewPassword("");
                          setPasswordModalVisible(true);
                        }}
                      />
                      <TableDeleteButton
                        onClick={() => {
                          setSelectedUser(record);
                          setDeleteOpen(true);
                        }}
                      />
                    </TableActions>
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
            <SheetTitle>{editingUser ? "Харилцагч засах" : "Харилцагч үүсгэх"}</SheetTitle>
          </SheetHeader>
          <div className="mt-4 space-y-3">
            <div className="space-y-2">
              <Label>Нэр</Label>
              <Input value={form.username} onChange={(e) => setForm((p) => ({ ...p, username: e.target.value }))} />
            </div>
            <div className="space-y-2">
              <Label>Имэйл</Label>
              <Input
                type="email"
                placeholder="Имэйл нэмэх эсвэл засах"
                value={form.email}
                onChange={(e) => setForm((p) => ({ ...p, email: e.target.value }))}
              />
            </div>
            <div className="space-y-2">
              <Label>Утас</Label>
              <Input value={form.phone} onChange={(e) => setForm((p) => ({ ...p, phone: e.target.value }))} />
            </div>
            <div className="space-y-2">
              <Label>Report Price</Label>
              <Input
                type="number"
                value={form.report_price}
                onChange={(e) => setForm((p) => ({ ...p, report_price: e.target.value }))}
              />
            </div>
            {!editingUser && (
              <div className="space-y-2">
                <Label>Нууц үг</Label>
                <Input
                  type="password"
                  value={form.password}
                  onChange={(e) => setForm((p) => ({ ...p, password: e.target.value }))}
                />
              </div>
            )}
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
