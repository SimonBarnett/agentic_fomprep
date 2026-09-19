import { listSkills } from '../lib/catalog';

export const dynamic = 'force-dynamic';

export default function Home() {
  const skills = listSkills();
  return (
    <main>
      <h1>mcp-priority.ntsa.uk</h1>
      <p>
        Catalog MCP for Priority agent skills. Agents <strong>grab</strong> a skill here, then run it
        against instances the <strong>user</strong> allowlisted. This host does not compile forms and
        cannot see on-prem SQL.
      </p>
      <h2>Add the MCP</h2>
      <pre>{`grok mcp add --transport http priority-formprep https://mcp-priority.ntsa.uk/mcp`}</pre>
      <p>Cursor / Claude: HTTP MCP URL <code>https://mcp-priority.ntsa.uk/mcp</code> (JSON-RPC POST).</p>
      <h2>Skills</h2>
      <p>
        Add another skill later by dropping <code>catalog/&lt;name&gt;/meta.json</code> and{' '}
        <code>SKILL.md</code> — no MCP code change.
      </p>
      <ul>
        {skills.map((s) => (
          <li key={s.id}>
            <strong>{s.meta.title}</strong> (<code>{s.id}</code>) v{s.meta.version}
            <div>{s.meta.description}</div>
          </li>
        ))}
      </ul>
      <h2>Execute plane (local plugins)</h2>
      <p>
        User file <code>%USERPROFILE%\.priority-formprep\instances.json</code> (schema from{' '}
        <code>get_instance_schema</code>). CredMan for passwords. Local Grok plugins:{' '}
        <code>priority-formprep</code> (<code>prepare_form</code>),{' '}
        <code>priority-shell-compile</code> (<code>compile_shell</code>),{' '}
        <code>priority-shell-install</code> (<code>install_shell</code>). Compile and install are
        separate tools. This host does not run them.
      </p>
      <h2>Hard rules</h2>
      <ul>
        <li>Never SQL-flip UPD=N.</li>
        <li>Success = UPD=N and LASTPREPDATE advanced.</li>
        <li>Never invent a WCF URL; only user-listed instance ids.</li>
      </ul>
    </main>
  );
}
