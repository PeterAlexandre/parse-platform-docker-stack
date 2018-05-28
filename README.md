docker-compose up -d
docker-compose logs -f parse_server
docker-compose rm -sf
docker-compose exec parse_server

Remember to create the /tmp/cloudcode before start the containers.