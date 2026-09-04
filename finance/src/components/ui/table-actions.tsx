"use client";

import * as React from "react";
import { Eye, Lock, Pencil, Trash2, type LucideIcon } from "lucide-react";
import { cn } from "@/lib/utils";

const baseClass =
  "inline-flex h-8 w-8 shrink-0 items-center justify-center rounded-md border transition-colors disabled:pointer-events-none disabled:opacity-50";

const variants = {
  default:
    "border-border bg-background text-muted-foreground hover:bg-muted hover:text-foreground",
  edit:
    "border-border bg-background text-muted-foreground hover:bg-muted hover:text-foreground",
  view:
    "border-border bg-background text-muted-foreground hover:bg-muted hover:text-foreground",
  secondary:
    "border-border bg-background text-muted-foreground hover:bg-muted hover:text-foreground",
  delete:
    "border-transparent bg-red-50 text-red-500 hover:bg-red-100 hover:text-red-600",
} as const;

type ActionVariant = keyof typeof variants;

interface TableActionButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: ActionVariant;
  icon?: LucideIcon;
  title?: string;
}

export function TableActionButton({
  variant = "default",
  icon: Icon,
  className,
  title,
  children,
  type = "button",
  ...props
}: TableActionButtonProps) {
  return (
    <button
      type={type}
      title={title}
      className={cn(baseClass, variants[variant], className)}
      {...props}
    >
      {Icon ? <Icon className="h-4 w-4" /> : children}
    </button>
  );
}

export function TableEditButton(
  props: Omit<TableActionButtonProps, "variant" | "icon">
) {
  return (
    <TableActionButton
      variant="edit"
      icon={Pencil}
      title={props.title || "Засах"}
      {...props}
    />
  );
}

export function TableDeleteButton(
  props: Omit<TableActionButtonProps, "variant" | "icon">
) {
  return (
    <TableActionButton
      variant="delete"
      icon={Trash2}
      title={props.title || "Устгах"}
      {...props}
    />
  );
}

export function TableViewButton(
  props: Omit<TableActionButtonProps, "variant" | "icon">
) {
  return (
    <TableActionButton
      variant="view"
      icon={Eye}
      title={props.title || "Харах"}
      {...props}
    />
  );
}

export function TableLockButton(
  props: Omit<TableActionButtonProps, "variant" | "icon">
) {
  return (
    <TableActionButton
      variant="secondary"
      icon={Lock}
      title={props.title || "Нууц үг"}
      {...props}
    />
  );
}

export function TableActions({
  className,
  children,
}: {
  className?: string;
  children: React.ReactNode;
}) {
  return (
    <div className={cn("flex items-center justify-end gap-1.5", className)}>
      {children}
    </div>
  );
}
