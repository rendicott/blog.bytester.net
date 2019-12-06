.PHONY: ecr
REGION = $(shell aws configure get region)
ACCOUNT = $(shell aws --output text sts get-caller-identity | cut -f 1)

ecr:
	./ecr.sh
run:
	docker run -p 8080:1313 -v $(shell pwd)/../source:/tmp/working -u 500:500 -it hug hugo serve -D --bind 0.0.0.0
build_local:
	docker run -p 8080:1313 -v $(shell pwd)/../source:/tmp/working -u 500:500 -it hug hugo -D
	aws s3 sync /home/ec2-user/environment/source/bitester-static s3://blog.bitester.com	
run2:
	docker run -p 8080:1313 -v $(shell pwd)/../source:/tmp/working -u 500:500 -it hug /bin/bash
