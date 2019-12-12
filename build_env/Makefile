run:
	docker run -p 8080:1313 -v $(shell pwd)/../source:/tmp/working -u 500:500 -it hug hugo serve -D --bind 0.0.0.0
build:
	docker run -p 8080:1313 -v $(shell pwd)/../source:/tmp/working -u 500:500 -it hug hugo -D
	aws s3 sync --delete /home/ec2-user/environment/source/bitester-blog/public s3://blog.bytester.net	
run2:
	docker run -p 8080:1313 -v $(shell pwd)/../source:/tmp/working -u 500:500 -it hug /bin/bash
