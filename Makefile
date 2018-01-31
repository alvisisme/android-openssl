all: env build

env:
	docker build -t android-openssl-build .

build:
	rm -rf out
	mkdir -p out
	docker run --rm -v `pwd`/out:/home/dev/out android-openssl-build