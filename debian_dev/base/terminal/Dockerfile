ARG tag
ARG pre_stage

FROM dev_env:${tag}-${pre_stage}

RUN sudo apt-get update && \
    sudo apt-get upgrade -y && \
    sudo apt-get install -y zsh git && \
    sudo rm -rf /var/lib/apt/lists/*

COPY ./env.sh ${PWD}/env.sh
COPY ./agent_baidu.sh ${PWD}/.local/script.d/agent_baidu.sh
