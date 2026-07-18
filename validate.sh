#!/usr/bin/env sh
set -eu
(cd backend && mvn test)
(cd frontend && npm ci && npm run build)
echo "Validation completed successfully."
