# Security Model

Define three roles; adjust as needed.

| Table          | Admin | Planner | Operator |
|----------------|:-----:|:-------:|:-------:|
| products       | CRUD  | R       | R       |
| work_orders    | CRUD  | CRUD    | RC      |
| wo_steps       | CRUD  | RC      | CRUD    |
| stations       | CRUD  | R       | R       |
| packing_lists  | CRUD  | CRUD    | C,R     |

Legend: C=create, R=read, U=update, D=delete.  
Field-level security: none initially.  
Ownership: see `docs/data-dictionary.md`.
