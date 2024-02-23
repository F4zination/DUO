FROM golang:1.22.0-bookworm

RUN apt update
RUN apt install -y protobuf-compiler apt-transport-https
RUN sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
RUN sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
RUN apt update
RUN apt install -y dart

#install go plugins
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2
RUN dart pub global activate protoc_plugin

ENV PATH="$PATH:$(go env GOPATH)/bin:/root/.pub-cache/bin"

ENTRYPOINT ["/bin/bash", "-c"]
