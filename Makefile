up:
	docker-compose up

test:
	go test -parallel 20 ./...

test_v:
	go test -v ./...

test_short:
	go test ./... -short

test_race:
	go test ./... -short -race

test_stress:
	go test -tags=stress -timeout=30m ./...

test_reconnect:
	go test -tags=reconnect ./...

validate_examples:
	go run dev/update-examples-deps/main.go
	bash dev/validate_examples.sh


fmt:
	go fmt ./...
	goimports -l -w .

generate_gomod:
	rm go.mod go.sum || true
	go mod init github.com/ThreeDotsLabs/watermill-kafka
# todo - change to last release
	go get github.com/ThreeDotsLabs/watermill@master

	go install ./...
	sed -i '\|go |d' go.mod
	go mod edit -fmt
	go mod tidy

