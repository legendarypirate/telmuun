"use client";

import { ChevronLeft, ChevronRight } from "lucide-react";
import { cn } from "@/lib/utils";

interface TablePaginationProps {
  current: number;
  pageSize: number;
  total: number;
  onPageChange: (page: number) => void;
  onPageSizeChange?: (pageSize: number) => void;
  pageSizeOptions?: number[];
  className?: string;
  showPageSize?: boolean;
}

export function TablePagination({
  current,
  pageSize,
  total,
  onPageChange,
  onPageSizeChange,
  pageSizeOptions = [10, 30, 50, 100],
  className,
  showPageSize = true,
}: TablePaginationProps) {
  const pageCount = Math.max(1, Math.ceil((total || 0) / Math.max(pageSize, 1)));
  const page = Math.min(Math.max(current, 1), pageCount);

  return (
    <div
      className={cn(
  "mt-0 flex flex-wrap items-center justify-between gap-3 border-t border-border/60 px-0 py-2.5",
        className
      )}
    >
      <p className="text-sm text-muted-foreground">
        Бүгд {total.toLocaleString()} мэдээлэл, {page}-р хуудас / нийт{" "}
        {pageCount} хуудас
      </p>

      <div className="flex flex-wrap items-center gap-2">
        {showPageSize && onPageSizeChange && (
          <select
            value={pageSize}
            onChange={(e) => onPageSizeChange(Number(e.target.value))}
            className="h-8 rounded-md border border-border bg-background px-2 text-sm text-foreground outline-none focus:ring-2 focus:ring-ring/40"
            aria-label="Хуудсын хэмжээ"
          >
            {pageSizeOptions.map((n) => (
              <option key={n} value={n}>
                {n}
              </option>
            ))}
          </select>
        )}

        <button
          type="button"
          disabled={page <= 1}
          onClick={() => onPageChange(page - 1)}
          className="inline-flex h-8 items-center gap-1 rounded-md border border-border bg-background px-2.5 text-sm text-muted-foreground transition-colors hover:bg-muted disabled:pointer-events-none disabled:opacity-40"
        >
          <ChevronLeft className="h-4 w-4" />
          Өмнөх
        </button>

        <span className="inline-flex h-8 min-w-8 items-center justify-center rounded-md border border-border bg-background px-2 text-sm font-medium tabular-nums">
          {page}
        </span>

        <button
          type="button"
          disabled={page >= pageCount}
          onClick={() => onPageChange(page + 1)}
          className="inline-flex h-8 items-center gap-1 rounded-md border border-border bg-background px-2.5 text-sm text-muted-foreground transition-colors hover:bg-muted disabled:pointer-events-none disabled:opacity-40"
        >
          Дараах
          <ChevronRight className="h-4 w-4" />
        </button>
      </div>
    </div>
  );
}
