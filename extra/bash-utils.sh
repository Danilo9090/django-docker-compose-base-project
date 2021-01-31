# Shortcut bash functions

# docker-compose shortcut
function dc(){
    DOCKER_FILE="docker-local.yml"
    if [ -f $DOCKER_FILE ]; then
        docker-compose -f $DOCKER_FILE $@
    else
        docker-compose $@
    fi
}
# end

# Limpa imagens docker
dcleanup(){
    docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
    docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}
# end

# Function to reload bash configs

reload_bashrc(){
    source ~/.bashrc
}
# end

# Function to clean *.pyc files
pyclean(){
    find . -name "*.pyc" -delete
}
# end

# Dockerenter functions
function dockerenter(){
    DOCKER_PS_LINE=`docker ps | awk '{print $1,$2,$NF}' | grep -m 1 $1`
    CONTAINER_NAME=`echo $DOCKER_PS_LINE | awk '{print $2}'`
    CONTAINER_ID=`echo $DOCKER_PS_LINE | awk '{print $1}'`

    if [ -n "$CONTAINER_ID" ]; then
        echo "Logged in: $CONTAINER_NAME"
        docker exec -it $CONTAINER_ID /bin/bash
    else
        echo "No container found for term: '$1'"
    fi
}

function dockerentersh(){
    DOCKER_PS_LINE=`docker ps | awk '{print $1,$2,$NF}' | grep -m 1 $1`
    CONTAINER_NAME=`echo $DOCKER_PS_LINE | awk '{print $2}'`
    CONTAINER_ID=`echo $DOCKER_PS_LINE | awk '{print $1}'`

    if [ -n "$CONTAINER_ID" ]; then
        echo "Logged in: $CONTAINER_NAME"
        docker exec -it $CONTAINER_ID /bin/sh
    else
        echo "No container found for term: '$1'"
    fi
}

function dockerattach(){
    DOCKER_PS_LINE=`docker ps | awk '{print $1,$2,$NF}' | grep -m 1 $1`
    CONTAINER_NAME=`echo $DOCKER_PS_LINE | awk '{print $2}'`
    CONTAINER_ID=`echo $DOCKER_PS_LINE | awk '{print $1}'`

    if [ -n "$CONTAINER_ID" ]; then
        echo "Logged in: $CONTAINER_NAME"
        docker attach $CONTAINER_ID
    else
        echo "No container found for term: '$1'"
    fi
}
# end
