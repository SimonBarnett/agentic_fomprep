import assert from 'node:assert/strict';
import test from 'node:test';
import { catalogPublicOrigin } from './public-origin.mjs';

const unset = { env: null };

test('defaults to the requested publish origin', () => {
  assert.equal(catalogPublicOrigin(unset), 'https://mcp.ntsa.uk');
});

test('uses an allowlisted request host and ignores a fallback env', () => {
  assert.equal(
    catalogPublicOrigin({ host: 'mcp.ntsa.uk', proto: 'https', env: 'https://mcp-priority.ntsa.uk' }),
    'https://mcp.ntsa.uk'
  );
  assert.equal(
    catalogPublicOrigin({ host: 'MCP-PRIORITY.NTSA.UK', proto: 'https', env: null }),
    'https://mcp-priority.ntsa.uk'
  );
  assert.equal(
    catalogPublicOrigin({
      host: 'main.d1example.amplifyapp.com',
      proto: 'https',
      env: null,
    }),
    'https://main.d1example.amplifyapp.com'
  );
});

test('keeps the local port and prefers the direct host over a forwarded host', () => {
  assert.equal(
    catalogPublicOrigin({
      host: '127.0.0.1:3456',
      forwardedHost: 'mcp.ntsa.uk',
      env: 'https://mcp.ntsa.uk',
    }),
    'http://127.0.0.1:3456'
  );
});

test('rejects public http, credentials, paths, and lookalike hosts', () => {
  assert.equal(catalogPublicOrigin({ host: 'mcp.ntsa.uk', proto: 'http', env: null }), 'https://mcp.ntsa.uk');
  assert.equal(catalogPublicOrigin({ host: 'evil.example', env: null }), 'https://mcp.ntsa.uk');
  assert.equal(catalogPublicOrigin({ host: 'mcp.ntsa.uk.evil.com', proto: 'https', env: null }), 'https://mcp.ntsa.uk');
  assert.equal(catalogPublicOrigin({ host: 'notamplifyapp.com', proto: 'https', env: null }), 'https://mcp.ntsa.uk');
  assert.equal(catalogPublicOrigin({ env: 'https://user:pass@mcp.ntsa.uk' }), 'https://mcp.ntsa.uk');
  assert.equal(catalogPublicOrigin({ env: 'https://mcp.ntsa.uk/mcp' }), 'https://mcp.ntsa.uk');
  assert.equal(catalogPublicOrigin({ env: 'https://mcp-priority.ntsa.uk' }), 'https://mcp-priority.ntsa.uk');
});
