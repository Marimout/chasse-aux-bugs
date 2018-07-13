# Setup

```
./setup.sh
```

## build Docker image

```
./build-docker-image.sh <EMAIL> <USERNAME>
```

## run Docker container as an interactive session

```
docker run -it --rm -p 3000:3000 -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix chasse-aux-bugs-env
```

> tip: make aliases :smile:

### my aliases

```
alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'
alias docker_clean_images='docker rmi $(docker images -a --filter=dangling=true -q)'

alias build_chasse_bugs_env="cd ${HOME}/chasse-aux-bugs/dev-env-setup && ./build-docker-image.sh $EMAIL $USER"

alias bcb="docker_clean_ps; docker_clean_images; build_chasse_bugs_env"
alias rcb="docker run -it --rm -p 3000:3000 -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix chasse-aux-bugs-env"
```
