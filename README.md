# For Docker Machine & Compose User

    $(docker-machine env <vmname>)
    docker-compose up -d
    curl -i http://$(docker-machine ip <vmname>):8888/
