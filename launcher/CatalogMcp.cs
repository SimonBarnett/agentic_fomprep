// Local stdio port of v2/apps/mcp-catalog (lib/mcp.ts + lib/catalog.ts): same tools, same results,
// served from the agentic_fomprep clone so it works without the hosted catalog.
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;

namespace PriorityAgent;

static class CatalogMcp
{
    static string Root = "";
    static readonly string[] Protocols = { "2025-06-18", "2025-03-26", "2024-11-05" };
    static readonly HashSet<string> Skip = new(StringComparer.OrdinalIgnoreCase) { "node_modules", ".git", ".next" };

    public static int Serve(string catalogDir)
    {
        Root = catalogDir;
        var stdin = new StreamReader(Console.OpenStandardInput(), new UTF8Encoding(false));
        var stdout = new StreamWriter(Console.OpenStandardOutput(), new UTF8Encoding(false)) { AutoFlush = true, NewLine = "\n" };
        string? line;
        while ((line = stdin.ReadLine()) != null)
        {
            if (string.IsNullOrWhiteSpace(line)) continue;
            JsonNode? resp;
            try { resp = Handle(JsonNode.Parse(line)); }
            catch (Exception ex) { resp = Error(null, -32700, "parse error: " + ex.Message); }
            if (resp != null) stdout.WriteLine(resp.ToJsonString(Relaxed));
        }
        return 0;
    }

    sealed record Skill(string Id, string Dir, JsonObject Meta, string SkillMd, JsonNode? Schema, List<(string path, long bytes)> Runner);

    static List<Skill> ListSkills()
    {
        var list = new List<Skill>();
        if (!Directory.Exists(Root)) return list;
        foreach (var dir in Directory.GetDirectories(Root))
        {
            string metaPath = Path.Combine(dir, "meta.json");
            if (!File.Exists(metaPath)) continue;
            try
            {
                var meta = JsonNode.Parse(File.ReadAllText(metaPath))!.AsObject();
                string id = (string?)meta["name"] is { Length: > 0 } n ? n : Path.GetFileName(dir);
                meta["name"] = id;
                string md = File.Exists(Path.Combine(dir, "SKILL.md")) ? File.ReadAllText(Path.Combine(dir, "SKILL.md")) : "";
                string sp = Path.Combine(dir, "instance-schema.json");
                JsonNode? schema = File.Exists(sp) ? JsonNode.Parse(File.ReadAllText(sp)) : null;
                list.Add(new Skill(id, dir, meta, md, schema, RunnerFiles(Path.Combine(dir, "runner"), "")));
            }
            catch { /* skip malformed skill folder */ }
        }
        return list.OrderBy(s => s.Id, StringComparer.Ordinal).ToList();
    }

    static List<(string, long)> RunnerFiles(string dir, string rel)
    {
        var o = new List<(string, long)>();
        if (!Directory.Exists(dir)) return o;
        foreach (var e in Directory.EnumerateFileSystemEntries(dir).OrderBy(x => x, StringComparer.Ordinal))
        {
            string name = Path.GetFileName(e);
            if (Skip.Contains(name)) continue;
            string r = rel == "" ? name : rel + "/" + name;
            if (Directory.Exists(e)) o.AddRange(RunnerFiles(e, r));
            else o.Add((r, new FileInfo(e).Length));
        }
        return o;
    }

    static Skill? GetSkill(string? name)
    {
        var all = ListSkills();
        if (string.IsNullOrWhiteSpace(name)) return all.Count == 1 ? all[0] : null;
        return all.FirstOrDefault(s => s.Id.Equals(name.Trim(), StringComparison.OrdinalIgnoreCase));
    }

    static JsonNode Text(string t, bool isError = false)
    {
        var o = new JsonObject { ["content"] = new JsonArray(new JsonObject { ["type"] = "text", ["text"] = t }) };
        if (isError) o["isError"] = true;
        return o;
    }

    static readonly JsonSerializerOptions Relaxed = new() { Encoder = System.Text.Encodings.Web.JavaScriptEncoder.UnsafeRelaxedJsonEscaping };
    static JsonNode Json(JsonNode n) => Text(n.ToJsonString(new JsonSerializerOptions { WriteIndented = true, Encoder = Relaxed.Encoder }));

    static JsonNode Tools() => JsonNode.Parse("""
    [
      {"name":"list_catalog","description":"List skills published on mcp-priority (local catalog from the agentic_fomprep clone). Adding a folder under catalog/ with meta.json registers a new skill. This server does not compile Priority forms.","inputSchema":{"type":"object","properties":{},"additionalProperties":false}},
      {"name":"get_skill","description":"Return SKILL.md for a catalog skill. Pass name when more than one skill exists.","inputSchema":{"type":"object","properties":{"name":{"type":"string","description":"Skill folder / meta.name"}},"additionalProperties":false}},
      {"name":"get_instance_schema","description":"JSON Schema for the user-owned instance allowlist (no secrets).","inputSchema":{"type":"object","properties":{"name":{"type":"string"}},"additionalProperties":false}},
      {"name":"get_runner_files","description":"Manifest of portable runner files for a skill. Optional path returns one file body. Does not execute prepare.","inputSchema":{"type":"object","properties":{"name":{"type":"string"},"path":{"type":"string","description":"Relative path under runner/"}},"additionalProperties":false}}
    ]
    """)!;

    static JsonNode CallTool(string name, JsonObject args)
    {
        string? skillName = args["name"]?.GetValueKind() == JsonValueKind.String ? (string?)args["name"] : null;
        if (name == "list_catalog")
        {
            var skills = new JsonArray();
            foreach (var s in ListSkills())
                skills.Add(new JsonObject { ["name"] = s.Id, ["title"] = s.Meta["title"]?.DeepClone(), ["description"] = s.Meta["description"]?.DeepClone(),
                    ["version"] = s.Meta["version"]?.DeepClone(), ["runnerFileCount"] = s.Runner.Count });
            return Json(new JsonObject { ["host"] = "local stdio (PriorityAgent.exe --mcp-catalog)", ["catalog"] = Root,
                ["execute"] = "local - user instances.json + CredMan; this MCP does not prepare forms",
                ["addSkill"] = "add v2/apps/mcp-catalog/catalog/<name>/meta.json + SKILL.md", ["skills"] = skills });
        }
        Skill? skill = GetSkill(skillName);
        if (skill == null)
        {
            var all = ListSkills();
            return Text(skillName == null && all.Count > 1 ? $"name required; catalog has: {string.Join(", ", all.Select(s => s.Id))}" : $"unknown skill '{skillName}'", true);
        }
        switch (name)
        {
            case "get_skill": return Text(skill.SkillMd);
            case "get_instance_schema": return skill.Schema == null ? Text("no instance-schema.json", true) : Json(skill.Schema.DeepClone());
            case "get_runner_files":
                string rel = args["path"]?.GetValueKind() == JsonValueKind.String ? (string)args["path"]! : "";
                if (rel != "")
                {
                    string safe = rel.Replace('\\', '/').TrimStart('/');
                    string root = Path.GetFullPath(Path.Combine(skill.Dir, "runner"));
                    string full = Path.GetFullPath(Path.Combine(root, safe));
                    if (safe.Contains("..") || !full.StartsWith(root, StringComparison.OrdinalIgnoreCase) || !File.Exists(full)) return Text("file not found", true);
                    return Text(File.ReadAllText(full));
                }
                var files = new JsonArray();
                foreach (var (p, b) in skill.Runner) files.Add(new JsonObject { ["path"] = p, ["bytes"] = b });
                return Json(new JsonObject { ["skill"] = skill.Id, ["files"] = files, ["hint"] = "call again with path to fetch one file" });
        }
        return Text($"unknown tool {name}", true);
    }

    static JsonNode Ok(JsonNode? id, JsonNode result) => new JsonObject { ["jsonrpc"] = "2.0", ["id"] = id?.DeepClone(), ["result"] = result };
    static JsonNode Error(JsonNode? id, int code, string msg) => new JsonObject { ["jsonrpc"] = "2.0", ["id"] = id?.DeepClone(), ["error"] = new JsonObject { ["code"] = code, ["message"] = msg } };

    static JsonNode? Handle(JsonNode? msg)
    {
        if (msg is not JsonObject m || (string?)m["method"] is not string method)
            return msg is JsonObject o && o.ContainsKey("id") ? Error(o["id"], -32600, "invalid request") : null;
        var id = m["id"];
        bool isNotification = !m.ContainsKey("id");
        var p = m["params"] as JsonObject ?? new JsonObject();
        if (method.StartsWith("notifications/") || method == "initialized") return null;
        JsonNode? r = method switch
        {
            "initialize" => Ok(id, new JsonObject
            {
                ["protocolVersion"] = Protocols.Contains((string?)p["protocolVersion"]) ? (string?)p["protocolVersion"] : "2024-11-05",
                ["capabilities"] = new JsonObject { ["tools"] = new JsonObject(), ["resources"] = new JsonObject() },
                ["serverInfo"] = new JsonObject { ["name"] = "mcp-priority", ["version"] = "1.0.0-local" },
                ["instructions"] = "Catalog only. list_catalog then get_skill. Prepare forms locally from user instances.json.",
            }),
            "ping" => Ok(id, new JsonObject()),
            "tools/list" => Ok(id, new JsonObject { ["tools"] = Tools() }),
            "tools/call" => Ok(id, CallTool((string?)p["name"] ?? "", p["arguments"] as JsonObject ?? new JsonObject())),
            "resources/list" => Ok(id, new JsonObject { ["resources"] = new JsonArray(ListSkills().Select(s => (JsonNode)new JsonObject
                { ["uri"] = $"skill://{s.Id}", ["name"] = s.Meta["title"]?.DeepClone() ?? s.Id, ["mimeType"] = "text/markdown" }).ToArray()) }),
            "resources/read" => ReadResource(id, (string?)p["uri"] ?? ""),
            _ => Error(id, -32601, $"method not found: {method}"),
        };
        return isNotification ? null : r;
    }

    static JsonNode ReadResource(JsonNode? id, string uri)
    {
        var mm = System.Text.RegularExpressions.Regex.Match(uri, "^skill://([^/]+)$");
        var s = mm.Success ? GetSkill(mm.Groups[1].Value) : null;
        if (s == null) return Error(id, -32002, "unknown resource");
        return Ok(id, new JsonObject { ["contents"] = new JsonArray(new JsonObject { ["uri"] = uri, ["mimeType"] = "text/markdown", ["text"] = s.SkillMd }) });
    }
}
