# Data dictionary

| Table | Purpose | Important fields |
|---|---|---|
| `organisms` | Organism reference data | `name`, `gram_group` |
| `antibiotics` | Antimicrobial reference data | `name`, `atc_code`, `aware_group` |
| `specimens` | Laboratory specimen metadata | synthetic patient reference, organism, date, ward, type |
| `susceptibility_results` | One result per specimen/antibiotic pair | status S/I/R/NOT_TESTED, MIC |
| `consumption_records` | Monthly antibiotic usage | year, month, ward, DDD/100 bed-days, total DDD |
| `clinical_alerts` | Surveillance and data quality workflow | severity, status, details, creation time |
| `deployments` | Runtime/GitOps state | service, environment, version, health, sync status |
| `work_items` | Delivery board | key, title, status, assignee, sprint, points |

All records in the bundled migration are synthetic.
