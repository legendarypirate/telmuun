"use client";

import { App, ConfigProvider, theme } from "antd";

export function AntdProvider({ children }: { children: React.ReactNode }) {
  return (
    <ConfigProvider
      theme={{
        token: {
          colorPrimary: "#4f46e5",
          borderRadius: 12,
          fontFamily: "var(--font-rubik), sans-serif",
        },
        algorithm: theme.defaultAlgorithm,
      }}
    >
      <App>{children}</App>
    </ConfigProvider>
  );
}
