ATHENS_UPSTREAM=https://github.com/gomods/athens/archive/main.zip

.PHONY: build
build:
	curl --location $(ATHENS_UPSTREAM) --output build/athens.zip
	unzip build/athens.zip -d build
	docker build . --tag dricottone/athens:latest

.PHONY: clean
clean:
	rm -rf build/*

