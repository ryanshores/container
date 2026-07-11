build:
	container build --tag local/node-postgres-redis:latest .
	container machine create --name node-postgres-redis local/node-postgres-redis:latest
	container machine run --tty --interactive --name node-postgres-redis

test:
	container build --tag local/node-postgres-redis:test .
	container machine create --name node-postgres-redis-test local/node-postgres-redis:test
	container machine run --tty --interactive --name node-postgres-redis-test
