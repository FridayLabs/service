# 12 factor php service skeleton


# TL;DR

### install

macOs: `brew install docker`

Linux/Unix: 
```
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
apt-get update
apt-get install docker-engine
```

### use

`make` to build

`make dev` to build and run local version

Dev version will appear here: [http://localhost:8081](http://localhost:8081) 


# 12 factor Manifest

## Codebase
Create project 
```
composer create-project fridaylabs/service -s dev --no-install --ignore-platform-reqs <SERVICE_NAME>
``` 
and push it to your repo
## Dependencies
Solved by composer
## Config
1. All configs should be pulled from environment. 
1. **Don't use variables like APPLICATION_ENVIRONMENT!**
1. Use `.env` file for local setup 
## Backing services
Use config for connecting with DB, Queue or other services
## Build, release, run
1. Type `make` to build
1. Type `make dev` to build and run local version
1. **TODO:** Push your branch to run tests, merge branch to release
## Processes
1. Make sure, that your app is stateless.
1. Store all your data into remote services
## Port binding
1. App exposing 80 and 443 port.
1. Default dev port is 8081
## Concurrency
Solved by php-fpm
## Disposability
Solved by supervisord
## Dev/prod parity
Solved by docker and composer
## Logs
1. Nginx, php-fpm and app writes logs to stdout
1. Don't write logs to FS
## Admin processes
**TODO**

