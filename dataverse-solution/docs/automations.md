# Automations (Power Automate / Plugins)

## Flow: Notify WO due soon
- **Trigger:** When a work_order is created or updated (status not DONE, due_date within 3 days).
- **Actions:** Post Teams message/Email to owner. Include WO number, product, qty, due date.
- **Env Variables:** `EV_TEAMS_WEBHOOK`, `EV_DUE_SOON_DAYS` (default 3).

## Flow: Generate PL number
- **Trigger:** On create `packing_lists`.
- **Action:** Set `prod_pl_number` = `PL-{YYYYMM}-{increment}` using an incremental store.

## Plugin: Validate qty (Create/Update work_orders)
- Reject if `qty <= 0` or status DONE but no `wo_steps` with `good_qty >= qty`.
