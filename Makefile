all: env build

env:
	docker build -t android-openssl-build .

build:
	docker run --rm -v `pwd`/out:/home/out android-openssl-build