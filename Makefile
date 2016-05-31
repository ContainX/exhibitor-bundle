LAST_TAG := $(shell git describe --abbrev=0 --tags)
ZK_VERSION = 3.4.6
EXHIBITOR_VER = 1.5.6
EXECUTABLE := exhibitor-bundle_$(EXHIBITOR_VER)-$(ZK_VERSION)-$(TRAVIS_BUILD_NUMBER).tgz

all: compile

compile:
	docker build -t build -f Dockerfile.build .
	docker create --name build-cont build
	docker cp build-cont:/src/exhibitor-bundle.tgz ./$(EXECUTABLE)
	docker rm -f build-cont

release:
	git tag -a v$(RELEASE) -m 'release $(RELEASE)'
	git push && git push --tags
	docker run -it containx/github-release release -u containx -r exhibitor-bundle -t v$(RELEASE) -n v$(RELEASE)
  docker run -it -v $(pwd):/data containx/github-release release -u containx -r exhibitor-bundle -t v$(RELEASE) -n v$(RELEASE) -f $(EXECUTABLE)
