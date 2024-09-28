"use client";
import "jsvectormap/dist/css/jsvectormap.css";
import "flatpickr/dist/flatpickr.min.css";
import "@/css/satoshi.css";
import "@/css/style.css";
import React, { useEffect, useState } from "react";
import Loader from "@/components/common/Loader";
import { QueryClientProvider, QueryClient } from '@tanstack/react-query'
import { ReactQueryDevtools } from '@tanstack/react-query-devtools'
import { SessionProvider } from "next-auth/react";

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  const [loading, setLoading] = useState<boolean>(true);

  // const pathname = usePathname();

  useEffect(() => {
    setTimeout(() => setLoading(false), 1000);
  }, []);

  const queryClient = new QueryClient()

  return (
    <QueryClientProvider client={queryClient}>
      <SessionProvider>
        <html lang="en">
          <body suppressHydrationWarning={true}>
            <div className="dark:bg-boxdark-2 dark:text-bodydark">
              {loading ? <Loader /> : children}
            </div>
            <ReactQueryDevtools initialIsOpen={false} />
          </body>
        </html>
      </SessionProvider>
    </QueryClientProvider>

  );
}
