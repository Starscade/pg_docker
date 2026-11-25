all:

	@docker build --no-cache -t pg_docker .


run:

	@docker run  -d                                 \
	            --name    pg_docker                 \
	            --network host                      \
	            --restart unless-stopped            \
	             -v       pg_docker:/var/lib/pgdata \
	                      pg_docker


