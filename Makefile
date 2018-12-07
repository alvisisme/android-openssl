all: env build

env:
	docker-compose build

build:
	docker-compose run android-build-openssl

dist:
	rm -rf dist/*
	cp build/lib/libssl.a dist/libssl.a
	cp build/lib/libcrypto.a dist/libcrypto.a
	cp -r build/include/openssl dist/openssl

.PHONY: env build dist