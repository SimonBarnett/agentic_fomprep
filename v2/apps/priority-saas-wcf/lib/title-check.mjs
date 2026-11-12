/** FR #414 / FR-032: WINDBI dictionary titles max 20 characters. */

export const DICTIONARY_TITLE_MAX = 20;

export function checkDictionaryTitle(title) {
  const t = String(title ?? '');
  if (t.length > DICTIONARY_TITLE_MAX) {
    return {
      ok: false,
      reason: 'title_too_long',
      max: DICTIONARY_TITLE_MAX,
      length: t.length,
    };
  }
  return { ok: true, title: t };
}
