# Data Dictionary (Dataverse mapping)

> **How to use:** Keep this as the authoritative specification for tables and columns. Cursor AI can read this file to generate forms, flows, and plugins.

## Global Conventions
- **Publisher prefix:** `prod_`
- **Ownership:** default **User/Team** unless noted.
- **Primary Name column:** `{table}_name` (Text) unless a natural key makes sense.
- **Alternate Keys:** use for human-readable unique fields (e.g., SKU, Station Code, Packing List Number).

## Tables

### products (Organization-owned; primary name: `prod_name`)
- `prod_name` (Text, req) — Product display name
- `prod_sku` (Text, req, **Alternate Key**) — Unique SKU
- Relations:
  - 1:N → work_orders (`prod_product` lookup on work_orders)

### work_orders (User/Team-owned; primary name: `prod_wo_number`)
- `prod_wo_number` (Text, req) — Human-readable WO number (auto-sequence)
- `prod_product` (Lookup → products, req)
- `prod_qty` (Whole Number, req, min 1)
- `prod_status` (Choice: PLANNED, IN_PROGRESS, DONE, REWORK; default: PLANNED)
- `prod_due_date` (Date only)
- Calculated/Rollup:
  - `prod_progress_pct` (Calculated) from wo_steps (good_qty vs qty)

### stations (Organization-owned; primary name: `prod_station_name`)
- `prod_station_name` (Text, req)
- `prod_station_code` (Text, req, **Alternate Key**)

### wo_steps (User/Team-owned; primary name: `prod_wostep_name`)
- `prod_wostep_name` (Text) — e.g., `{WO}-{Station}-{seq}`
- `prod_wo` (Lookup → work_orders, req) [Cascade: **Restrict** on delete]
- `prod_station` (Lookup → stations, req) [Cascade: **None**]
- `prod_started_at` (DateTime), `prod_finished_at` (DateTime)
- `prod_good_qty` (Whole Number, default 0), `prod_scrap_qty` (Whole Number, default 0)

### packing_lists (User/Team-owned; primary name: `prod_pl_number`)
- `prod_pl_number` (Text, req, **Alternate Key**) — PL number
- `prod_wo` (Lookup → work_orders, req) [Cascade: **Restrict**]
- `prod_created_at` (DateTime, default now)

## Choices (Global Option Sets)
- `prod_wo_status`:
  - PLANNED (100000000)
  - IN_PROGRESS (100000001)
  - DONE (100000002)
  - REWORK (100000003)

## Relationship Catalog
- products (1) → work_orders (N) via `prod_product` [Cascade: Reparent/No delete cascade]
- work_orders (1) → wo_steps (N) via `prod_wo` [Cascade: Restrict delete]
- stations (1) → wo_steps (N) via `prod_station` [Cascade: None]
- work_orders (1) → packing_lists (N) via `prod_wo` [Cascade: Restrict delete]

