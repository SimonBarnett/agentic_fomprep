import type { ReactNode } from 'react';
import './globals.css';

export const metadata = {
  title: 'mcp-priority',
  description: 'Priority agent skill catalog MCP',
};

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
