build:
	docker build -t rancher-docs .

run:
	docker run -p 80:80 rancher-docs

