"use client";

import * as React from "react";
import { CalendarDays, Phone, Search, X } from "lucide-react";
import { cn } from "@/lib/utils";

export function FilterBar({
  className,
  children,
  actions,
}: {
  className?: string;
  children: React.ReactNode;
  actions?: React.ReactNode;
}) {
  return (
    <div
      className={cn(
        "mb-3 rounded-xl border border-border/80 bg-card shadow-sm",
        className
      )}
    >
      <div className="flex flex-wrap items-end gap-2.5 p-3">{children}</div>
      {actions ? (
        <div className="flex flex-wrap items-center gap-2 border-t border-border/60 px-3 py-2.5">
          {actions}
        </div>
      ) : null}
    </div>
  );
}

export function FilterField({
  label,
  className,
  children,
}: {
  label?: string;
  className?: string;
  children: React.ReactNode;
}) {
  return (
    <div className={cn("flex min-w-0 flex-col gap-1", className)}>
      {label ? (
        <span className="px-0.5 text-[11px] font-medium uppercase tracking-wide text-muted-foreground">
          {label}
        </span>
      ) : null}
      {children}
    </div>
  );
}

type FilterInputProps = React.ComponentProps<"input"> & {
  icon?: "search" | "phone" | "none";
};

export function FilterInput({
  className,
  icon = "search",
  ...props
}: FilterInputProps) {
  const Icon =
    icon === "phone" ? Phone : icon === "search" ? Search : null;

  return (
    <div className={cn("relative", className)}>
      {Icon ? (
        <Icon className="pointer-events-none absolute left-2.5 top-1/2 h-3.5 w-3.5 -translate-y-1/2 text-muted-foreground" />
      ) : null}
      <input
        data-slot="filter-input"
        className={cn(
          "h-8 w-full rounded-lg border border-border bg-background text-sm text-foreground outline-none transition-colors",
          "placeholder:text-muted-foreground/80",
          "hover:border-muted-foreground/40",
          "focus:border-foreground/30 focus:ring-2 focus:ring-foreground/5",
          "disabled:cursor-not-allowed disabled:opacity-50",
          Icon ? "pl-8 pr-2.5" : "px-2.5"
        )}
        {...props}
      />
    </div>
  );
}

export function FilterDate({
  className,
  ...props
}: React.ComponentProps<"input">) {
  return (
    <div className={cn("relative", className)}>
      <CalendarDays className="pointer-events-none absolute left-2.5 top-1/2 h-3.5 w-3.5 -translate-y-1/2 text-muted-foreground" />
      <input
        type="date"
        data-slot="filter-date"
        className={cn(
          "h-8 w-full rounded-lg border border-border bg-background pl-8 pr-2 text-sm text-foreground outline-none transition-colors",
          "hover:border-muted-foreground/40",
          "focus:border-foreground/30 focus:ring-2 focus:ring-foreground/5",
          "disabled:cursor-not-allowed disabled:opacity-50",
          "[color-scheme:light]"
        )}
        {...props}
      />
    </div>
  );
}

export function FilterChip({
  active,
  className,
  style,
  children,
  onClick,
  ...props
}: React.ButtonHTMLAttributes<HTMLButtonElement> & { active?: boolean }) {
  return (
    <button
      type="button"
      onClick={onClick}
      className={cn(
        "inline-flex h-7 items-center rounded-full border px-2.5 text-xs font-medium transition-all",
        active
          ? "border-emerald-500/50 ring-2 ring-emerald-500/20"
          : "border-transparent opacity-90 hover:opacity-100",
        className
      )}
      style={style}
      {...props}
    >
      {children}
    </button>
  );
}

export function FilterClearButton({
  onClick,
  className,
}: {
  onClick: () => void;
  className?: string;
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      className={cn(
        "inline-flex h-8 items-center gap-1.5 rounded-lg border border-border bg-background px-2.5 text-xs font-medium text-muted-foreground transition-colors hover:bg-muted hover:text-foreground",
        className
      )}
    >
      <X className="h-3.5 w-3.5" />
      Цэвэрлэх
    </button>
  );
}
