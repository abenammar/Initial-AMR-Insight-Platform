.PHONY: up down logs backend-test frontend-build clean

up:
	docker compose up --build

down:
	docker compose down -v

logs:
	docker compose logs -f

backend-test:
	cd backend && mvn test

frontend-build:
	cd frontend && npm ci && npm run build

clean:
	rm -rf backend/target frontend/dist frontend/node_modules
