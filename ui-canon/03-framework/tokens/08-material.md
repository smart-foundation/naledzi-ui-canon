---
id: FW-TOKENS-MATERIAL
title: "Material tokens"
kind: framework
entity: tokens
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-TOKENS-INDEX, FOUND-DEPTH-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FW-TOK-MATERIAL-001]
---

# Material tokens

Materials are scoped surface qualities (FOUND-DEPTH §6 materials). No glassmorphism as
default; translucency is a scoped material.

| Token ID | Quality | Use |
|---|---|---|
| `TOK-MATERIAL-SOLID` | Opaque surface | Default containers |
| `TOK-MATERIAL-TRANSLUCENT` | Translucent (scrim-backed) | Overlays, popovers where content shows through |
| `TOK-MATERIAL-BLUR-BACKDROP` | Backdrop blur (scoped) | Modal scrim only, where supported |
| `TOK-MATERIAL-MATTE` | Non-reflective | EV/spaceship (glare) |
| `TOK-MATERIAL-TEXTURE-NONE` | No texture | Default |

Translucency requires a fallback (solid) when blur is unavailable (`FOUND-DEPTH-14`).

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-TOK-MATERIAL-001` | Every surface declares a material token; unsupported blur falls back to solid. |