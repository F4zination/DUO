containerName=duo_server
imageName=duo_backend
db_conn=postgres://duo_user:Testimesti123@0.0.0.0:5432/duo?sslmode=disable

runNative:
	go run main.go

run:
	docker run -p 8080:8080 --name $(containerName) $(imageName)

delete:
	docker rm $(containerName)

rerun:
	make delete && make run

build:
	docker build -t $(imageName) .

rebuild:
	docker rm $(containerName) && docker rmi $(imageName) && make build

sqlc:
	docker run --rm -v "$(shell cd):/src" -w /src kjconroy/sqlc generate 

migrateup:
	docker run -v $(shell cd)/db/migration:/migrations --rm --network host migrate/migrate \
    -path=/migrations/ -database $(db_conn) up 1

migratedown:
	docker run -v $(shell cd)/db/migration:/migrations --rm --network host migrate/migrate \
    -path=/migrations/ -database $(db_conn) down 1

migratecreate:
	docker run -v $(shell cd)/db/migration:/migrations --rm --network host migrate/migrate create -seq -ext sql -dir /migrations $(name)

migrateupall:
	docker run -v $(shell cd)/db/migration:/migrations --rm --network host migrate/migrate \
    -path=/migrations/ -database $(db_conn) up

.PHONY: run runNative rebuild build delete rerun migrateup migratedown migratecreate migrateupall sqlc