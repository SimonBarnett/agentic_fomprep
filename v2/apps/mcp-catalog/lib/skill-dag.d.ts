export function dagDataDir(): string;
export function loadDag(force?: boolean): {
  dag: Record<string, unknown>;
  index: Record<string, unknown>;
  nodesById: Map<string, Record<string, unknown>>;
  deps: Map<string, Set<string>>;
  contains: Map<string, Set<string>>;
  skillTopics: Map<string, string>;
  dagPath: string;
};
export function resolveSkills(
  task: string,
  opts?: {
    maxLessons?: number;
    maxSkills?: number;
    maxBytes?: number;
    allowLarge?: boolean;
    singleFileCeiling?: number;
  },
): Record<string, unknown>;
export function getDagIndex(): Record<string, unknown>;
export function getDagNode(
  id: string,
): { ok: true; node: Record<string, unknown>; edges: unknown[] } | { ok: false; error: string };
export function getSkillDagPage(
  cursor?: string | null,
  pageSize?: number,
): Record<string, unknown>;
export function resetDagCache(): void;
