all: compile

compile:
	docker build -t build -f Dockerfile.build .
	docker create --name build-cont build
	docker cp build-cont:/src/exhibitor/exhibitor.tgz ./
	docker rm -f build-cont
