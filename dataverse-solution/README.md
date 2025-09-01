# Dataverse Production Starter (Cursor AI + Git + GitHub)

This repository is a **starter kit** for building a production Dataverse solution with:
- **Cursor AI** (authoring/specs/PR reviews),
- **Git & GitHub** (source control),
- **Power Platform CLI (PAC)** + **GitHub Actions** (ALM Dev→Test→Prod).

## Structure
```
dataverse-solution/
├─ docs/                      # DBML, data dictionary, security, ALM, automations
├─ solutions/src/             # Unpacked Dataverse solution (tracked in Git)
├─ plugins/                   # C# plugins & tests (optional)
├─ flows/                     # Extra JSON drafts/specs for Power Automate
├─ env/                       # Environment variables & connection references
└─ .github/workflows/         # CI pipelines for export/unpack and pack/import
```

## Quick start
1. Create **Dev/Test/Prod** environments in Dataverse and a solution in **Dev**.
2. Register an **Azure AD App**; create an **Application User** in each environment and assign roles.
3. Fork/clone this repo and add **GitHub Secrets**:
   - `PP_TENANT_ID`, `PP_CLIENT_ID`, `PP_CLIENT_SECRET`
   - `PP_DEV_ENV_URL`, `PP_TEST_ENV_URL`, `PP_PROD_ENV_URL`
4. Commit your changes in **Dev**, then run **Export & Unpack** (workflow) to capture them in Git.
5. Open a PR → merge to `release/*` to deploy to **Test** (managed).
6. Promote to `main` to deploy to **Prod** (managed).

See `docs/alm.md` for end-to-end details.
