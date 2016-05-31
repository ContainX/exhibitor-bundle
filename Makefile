LAST_TAG := $(shell git describe --abbrev=0 --tags)
ZK_VERSION = 3.4.6
EXHIBITOR_VER = 1.5.6
EXECUTABLE := exhibitor-bundle.tgz

all: compile

compile:
	docker build -t build -f Dockerfile.build .
	docker create --name build-cont build
	docker cp build-cont:/src/exhibitor-bundle.tgz ./$(EXECUTABLE)
	docker rm -f build-cont

release-docker:
	git tag -a $(RELEASE) -m 'release $(RELEASE)'
	git push && git push --tags
	docker run -it -e GITHUB_TOKEN=$(GITHUB_TOKEN) containx/github-release release -u containx -r exhibitor-bundle -t $(RELEASE) -n $(RELEASE)
  docker run -it -e GITHUB_TOKEN=$(GITHUB_TOKEN) -v $(pwd):/data containx/github-release upload -u containx -r exhibitor-bundle -t $(RELEASE) -n $(EXECUTABLE) -f $(EXECUTABLE)

release:
#		git tag -a $(RELEASE) -m 'release $(RELEASE)'
#		git push && git push --tags
#		github-release release -u containx -r exhibitor-bundle -t $(RELEASE) -n $(RELEASE)
	  github-release upload -u containx -r exhibitor-bundle -t $(RELEASE) -n $(EXECUTABLE) -f $(EXECUTABLE)
