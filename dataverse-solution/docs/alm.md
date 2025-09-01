# ALM: Dev → Test → Prod

## Environments
- **Dev**: unmanaged customization inside a Solution.
- **Test**: managed imports from CI.
- **Prod**: managed imports from CI.

## Service Principal & App User
1. Register Azure AD App (Client ID/Secret).  
2. In each environment: **Settings → Users + permissions → Application users → New app user**.  
3. Assign roles (e.g., System Administrator for CI).

## GitHub Secrets
- `PP_TENANT_ID`
- `PP_CLIENT_ID`
- `PP_CLIENT_SECRET`
- `PP_DEV_ENV_URL` (e.g., https://org-dev.crm.dynamics.com)
- `PP_TEST_ENV_URL`
- `PP_PROD_ENV_URL`

## Pipelines
- **Export & Unpack (manual)**: Pull Dev solution into Git (unmanaged).
- **Pack & Import to TEST (on release/\*)**: Build managed, import to Test.
- **Pack & Import to PROD (on main)**: Build managed, import to Prod.

## Local PAC CLI (optional)
```bash
# Install
dotnet tool install --global Microsoft.PowerApps.CLI.Tool
# Auth
pac auth create --tenant <TENANT> --url <ENV_URL> --applicationId <APP_ID> --clientSecret <SECRET>
# Export unmanaged
pac solution export --name <SolutionName> --outputFile ./tmp/solution.zip --managed false
# Unpack
pac solution unpack --zipfile ./tmp/solution.zip --folder ./solutions/src --processCanvasApps true --allowDelete true
# Pack managed
pac solution pack --zipfile ./tmp/managed.zip --folder ./solutions/src --managed true
# Import
pac solution import --path ./tmp/managed.zip --activate-plugins true
```
(Generated: 2025-09-01T11:26:50.110481Z)
