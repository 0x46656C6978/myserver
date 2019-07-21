## For Windows user only
First, run CMD or PowerShell as administrator and execute the following command

    route /P add 172.17.0.0 MASK 255.255.0.0 10.0.75.2

Want to know why? Read [this](https://forums.docker.com/t/connecting-to-containers-ip-address/18817).

## Executable files
- `bin/build`: alias of `docker-compose build`
- `bin/clean`: perform `docker image prune` to remove unused images
- `bin/db`: access to database console
- `bin/down`: alias of `docker-compose down` with confirmation
- `bin/reset_mysql`: delete all contents in `data/mysql`
- `bin/stop`: alias of `docker-compose stop` with confirmation
- `bin/up`: alias of `docker-compose up`
- `bin/web`: access to web server terminal