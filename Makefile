all:
	@docker build --no-cache -t pg_docker . \
	&& docker run --rm -it pg_docker
