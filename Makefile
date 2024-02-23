buildgoprotoc:
	docker build -t protoc_container -f helpers/protoc.dockerfile .

goprotoc:
	del /S /Q $(shell cd)\duo_backend\pb\*
	docker run --rm -v $(shell cd)/duo_backend/pb:/out -v $(shell cd)/proto:/proto protoc_container "protoc --proto_path=/proto --go_out=/out --go_opt=paths=source_relative --go-grpc_out=/out --go-grpc_opt=paths=source_relative /proto/*.proto"

dartprotoc:
	del /S /Q $(shell cd)\duo_client\lib\pb\*
	docker run --rm -v $(shell cd)/duo_client/lib/pb:/out -v $(shell cd)/proto:/proto protoc_container "protoc --proto_path=/proto --dart_out=/out /proto/*.proto"

allprotoc:
	make goprotoc
	make dartprotoc

deleteprotoc:
	docker rmi protoc_container

.PHONY: buildgoprotoc goprotoc dartprotoc allprotoc deleteprotoc