build:
	docker build . -t hug

run:
	docker run -p 8080:1313 -v $(shell pwd)/../.:/tmp/working/blog.bytester.net -u 1000:1000 -it hug hugo serve -D --bind 0.0.0.0
deploy:
	docker run -p 8080:1313 -v $(shell pwd)/../source:/tmp/working -u 500:500 -it hug hugo -D
	aws s3 sync --delete /home/ec2-user/environment/source/blog.bytester.net/public s3://blog.bytester.net	
run2:
	docker run -p 8080:1313 -v $(shell pwd)/../.:/tmp/working/blog.bytester.net -u 1000:1000 -it hug /bin/bash
