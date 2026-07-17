# API notes

The OpenAPI definition is generated at runtime at `/v3/api-docs` and rendered through Swagger UI at `/swagger-ui.html`.

## Example

```bash
curl 'http://localhost:8080/api/dashboard/susceptibility?organism=Acinetobacter%20species'
```

Authenticated write request:

```bash
curl -u admin:change-me-now   -H 'Content-Type: application/json'   -d '{"patientReference":"P-DEMO-01","organismId":1,"collectionDate":"2026-07-17","ward":"ICU","specimenType":"Blood"}'   http://localhost:8080/api/specimens
```
