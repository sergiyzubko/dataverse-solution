# Relationships & Cascade Rules

- **products (1) → work_orders (N)** via `prod_product`
  - Delete: **No Cascade** (prevent deleting product if WOs exist).
  - Reparent: Allowed.

- **work_orders (1) → wo_steps (N)** via `prod_wo`
  - Delete: **Restrict** (must remove steps first).

- **stations (1) → wo_steps (N)** via `prod_station`
  - Delete: **None** (allow station archival without cascading).

- **work_orders (1) → packing_lists (N)** via `prod_wo`
  - Delete: **Restrict**.
