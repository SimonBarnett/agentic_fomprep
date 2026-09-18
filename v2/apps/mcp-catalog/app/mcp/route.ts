import { NextRequest, NextResponse } from 'next/server';
import { corsHeaders, handleMcp } from '../../lib/mcp';

export const dynamic = 'force-dynamic';

export async function OPTIONS() {
  return new NextResponse(null, { status: 204, headers: corsHeaders });
}

export async function GET() {
  return NextResponse.json(
    {
      ok: true,
      transport: 'POST JSON-RPC to /mcp',
      tools: ['list_catalog', 'get_skill', 'get_instance_schema', 'get_runner_files'],
      note: 'This host does not prepare Priority forms.',
    },
    { headers: corsHeaders }
  );
}

export async function POST(req: NextRequest) {
  let body: unknown;
  try {
    body = await req.json();
  } catch {
    return NextResponse.json(
      { jsonrpc: '2.0', error: { code: -32700, message: 'parse error' } },
      { status: 400, headers: corsHeaders }
    );
  }
  const result = handleMcp(body);
  if (result === null) {
    return new NextResponse(null, { status: 204, headers: corsHeaders });
  }
  return NextResponse.json(result, { headers: corsHeaders });
}
