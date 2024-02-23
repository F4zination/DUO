containerName=duo_server
imageName=duo_backend

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

.PHONY: run runNative rebuild build