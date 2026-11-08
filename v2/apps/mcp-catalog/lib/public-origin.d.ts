export type OriginInput = {
  host?: string | null;
  forwardedHost?: string | null;
  proto?: string | null;
  /** Pass null to ignore the environment. Omit to read CATALOG_PUBLIC_ORIGIN. */
  env?: string | null;
};

/** See public-origin.mjs. */
export function catalogPublicOrigin(input?: OriginInput): string;
