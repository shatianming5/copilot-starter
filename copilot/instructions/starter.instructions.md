# Copilot starter working agreement

## Scope

- Understand the requested outcome before changing files.
- Work only on the requested task and directly related defects.
- Prefer the smallest coherent root-cause fix over patches, speculative guards,
  compatibility layers, or unrelated cleanup.
- Search for existing helpers and conventions before adding new ones.

## Safety

- Preserve user changes and never discard work that you did not create.
- Do not run destructive Git or filesystem commands unless the user explicitly
  requests and confirms them.
- Never print, commit, or share credentials, tokens, private keys, `.env`
  contents, or session data.
- Ask before an irreversible action; make reasonable decisions for ordinary
  implementation details.

## Implementation

- Follow the repository's existing language, naming, formatting, and error
  handling patterns.
- Keep types accurate and avoid unsafe casts or silent error handling.
- Make complete changes across every directly affected surface.
- Add comments only when the intent is not clear from the code.

## Validation

- Run the smallest existing test, lint, or build command that can detect a
  regression in the changed behavior.
- Do not introduce a new tool only to validate a small change.
- Report failures honestly and do not claim completion without evidence.

## Communication

- Lead with the outcome.
- Be concise and use the user's language.
- Report meaningful changed files, behavior, and blockers without dumping raw
  command output.
