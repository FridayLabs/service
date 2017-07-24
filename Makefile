
DIR := ${CURDIR}
PORT := 8081

all: build

build:
	docker build -t fridaylabs/service .

dev: build
	docker run -it -v ${DIR}:/var/www -p ${PORT}:80 fridaylabs/service