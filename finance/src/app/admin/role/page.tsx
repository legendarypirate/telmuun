"use client";

import React, { useEffect, useState } from "react";
import { useRoles, usePermissions } from "@/hooks/use-lookups";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { TableActions, TableEditButton } from "@/components/ui/table-actions";
import { Sheet, SheetContent, SheetHeader, SheetTitle } from "@/components/ui/sheet";

interface Role {
  id: number;
  name: string;
  createdAt: string;
  updatedAt: string;
}

interface Permission {
  id: number;
  module: string;
  action: string;
}

export default function RolePermissionPage() {
  const { data: roles = [], isFetching: loading } = useRoles();
  const { data: permissions = [] } = usePermissions();
  const [drawerVisible, setDrawerVisible] = useState(false);
  const [selectedRole, setSelectedRole] = useState<Role | null>(null);
  const [rolePermissions, setRolePermissions] = useState<number[]>([]);

  useEffect(() => {
    document.title = "Эрхийн зохицуулалт";
  }, []);

  const openPermissionDrawer = async (role: Role) => {
    setSelectedRole(role);
    setDrawerVisible(true);
    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/role_permission/${role.id}`);
      const result = await res.json();
      if (result.success && Array.isArray(result.data)) {
        const permissionIds = result.data.map((p: Permission) => p.id);
        setRolePermissions(permissionIds);
      }
    } catch (err) {
      console.error("Failed to fetch role permissions", err);
    }
  };

  const handleSubmit = async () => {
    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/role_permission/${selectedRole?.id}`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ permissions: rolePermissions }),
      });
      const result = await res.json();
      if (res.ok) {
        toast.success("Permissions updated");
        setDrawerVisible(false);
        setRolePermissions([]);
      } else {
        toast.error(result.message || "Failed to update permissions");
      }
    } catch {
      toast.error("Error submitting permissions");
    }
  };

  return (
    <div>
      <h1 className="mb-6 text-3xl font-bold">Role Permissions</h1>
      <div className="border rounded-md">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Role</TableHead>
              <TableHead>Үйлдэл</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {loading ? (
              <TableRow>
                <TableCell colSpan={2} className="py-8 text-center text-muted-foreground">
                  Ачааллаж байна...
                </TableCell>
              </TableRow>
            ) : (
              roles.map((record) => (
                <TableRow key={record.id}>
                  <TableCell>{record.name}</TableCell>
                  <TableCell>
                    <TableActions>
                      <TableEditButton
                        onClick={() => openPermissionDrawer(record)}
                        title="Edit Permissions"
                      />
                    </TableActions>
                  </TableCell>
                </TableRow>
              ))
            )}
          </TableBody>
        </Table>
      </div>

      <Sheet
        open={drawerVisible}
        onOpenChange={(open) => {
          setDrawerVisible(open);
          if (!open) {
            setSelectedRole(null);
            setRolePermissions([]);
          }
        }}
      >
        <SheetContent>
          <SheetHeader>
            <SheetTitle>Edit Permissions: {selectedRole?.name}</SheetTitle>
          </SheetHeader>
          <div className="mt-4 space-y-3">
            <Label>Permissions</Label>
            {permissions.map((p) => (
              <div key={p.id} className="flex items-center gap-3">
                <Switch
                  checked={rolePermissions.includes(p.id)}
                  onCheckedChange={(checked) => {
                    if (checked) {
                      setRolePermissions((prev) => [...prev, p.id]);
                    } else {
                      setRolePermissions((prev) => prev.filter((id) => id !== p.id));
                    }
                  }}
                />
                <span className="text-sm">{`${p.module} - ${p.action}`}</span>
              </div>
            ))}
            <hr className="my-4" />
            <Button className="w-full" onClick={handleSubmit}>
              Save Permissions
            </Button>
          </div>
        </SheetContent>
      </Sheet>
    </div>
  );
}
