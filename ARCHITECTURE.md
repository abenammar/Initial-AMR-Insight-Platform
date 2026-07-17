# Architecture

## Components

1. **Frontend** — React and TypeScript single-page application with Recharts visualisations.
2. **Backend** — Spring Boot REST API. JPA is used for transactional entities; `JdbcTemplate` is used for analytical aggregation queries.
3. **Database** — PostgreSQL with Flyway-managed schema and demo data.
4. **Delivery** — Docker images, Kubernetes manifests, and an Argo CD `Application` example.

## Backend layers

- `api`: controllers, validation, and exception mapping
- `service`: analytical query orchestration
- `domain`: JPA entities and enums
- `repository`: Spring Data repositories
- `db/migration`: immutable schema and seed migrations

## Security model

Read-only `GET /api/**` routes are public in the demo profile. Mutating routes require HTTP Basic authentication with credentials supplied through environment variables. A real hospital deployment should add an identity provider, role-based permissions, audit logging, secret management, and network controls.

## Scalability

Analytical indexes are included on dates, organisms, antibiotics, and susceptibility status. For very large datasets, consider table partitioning by collection year, materialised surveillance views, and a dedicated ingestion pipeline.
