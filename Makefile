build:
	docker build -t rancher-docs:build -f Dockerfile.build .

run:
	docker build -t rancher-docs .
	docker run -p 80:80 rancher-docs
