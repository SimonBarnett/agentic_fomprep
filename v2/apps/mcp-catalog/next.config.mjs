/** @type {import('next').NextConfig} */
const nextConfig = {
  // Skill leaflets and runners are read from catalog/ on each request.
  // Trace those files into the Next server bundle. Amplify Hosting compute
  // packages the traced files; it does not deploy output: 'standalone'.
  experimental: {
    outputFileTracingIncludes: {
      '/': ['./catalog/**/*'],
      '/mcp': ['./catalog/**/*'],
    },
  },
  async headers() {
    return [
      {
        source: '/mcp',
        headers: [{ key: 'Cache-Control', value: 'no-store' }],
      },
    ];
  },
};

export default nextConfig;
