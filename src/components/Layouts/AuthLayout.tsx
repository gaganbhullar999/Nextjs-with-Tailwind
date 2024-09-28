"use client";
import React, { useState, ReactNode } from "react";

export default function AuthLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const [sidebarOpen, setSidebarOpen] = useState(false);
  return (
    <>
      {children}
    </>
  );
}
