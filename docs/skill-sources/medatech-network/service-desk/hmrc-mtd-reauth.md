# HMRC MTD reauthentication restored the VAT submission

Issue type: Online VAT (UK) submission fails because HMRC authorization is missing or expired, and reauthentication makes that submission succeed.

This is not SC263549. That earlier call only instructed Get New Token and did not record a completed token renewal or a successful VAT submission. Do not close it with this evidence.

Known path, 2026-10-20 17:07 BST: Financials > Nominal Ledger > Financial Statements > Taxes > VAT Reports > VAT > Online VAT (UK) > Set Up for HMRC's MTD. On 2026-10-21 08:43 BST the customer said they reauthenticated and it went through. Opened 2026-10-20 17:09 BST. The original screenshot error was not available as text.

An 18-month reauthorization interval was mentioned historically. Do not treat that as the current expiry rule.

## Prerequisites

The tax owner runs the supported authorization. Never collect a login, OTP, or token. Do not file the return twice. This harvest does not authorize the submission.

## Steps

1. Separate a business or validation error from an authorization failure. Keep the exact error text when you have it. This call did not include that text.
2. The authorized taxpayer runs Set Up for HMRC's MTD and completes the supported reauthentication. Do not call the HMRC API yourself.
3. Before submitting again, check whether the original return was already accepted.
4. Submit only with the tax owner's approval, and keep the HMRC response. Do not fabricate a receipt.

## Verification

Proven: the customer reauthenticated and the submission went through (SC263292).

Not proven: an error code, a token expiry time, an HMRC receipt in the file, and the current reauthorization interval.

## Stop or escalate

Stop if the error is not an authorization failure, if a return may already have been accepted, or if anyone asks for a token. The tax owner owns the filing.
