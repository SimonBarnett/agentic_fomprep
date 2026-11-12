/**
 * FR #414 / FR-032: WINDBI dictionary titles ≤ 20 characters.
 * Call before any dictionary title write / SDK DDL path.
 */

export const DICTIONARY_TITLE_MAX = 20;

/**
 * @param {unknown} title
 * @returns {{ ok: true, title: string, length: number, max: number } | { ok: false, reason: 'title_too_long', title: string, length: number, max: number }}
 */
export function checkDictionaryTitle(title) {
  const t = title == null ? '' : String(title);
  const length = t.length;
  if (length > DICTIONARY_TITLE_MAX) {
    return {
      ok: false,
      reason: 'title_too_long',
      title: t,
      length,
      max: DICTIONARY_TITLE_MAX,
    };
  }
  return { ok: true, title: t, length, max: DICTIONARY_TITLE_MAX };
}
