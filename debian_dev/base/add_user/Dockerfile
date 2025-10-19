FROM iregistry.baidu-int.com/baidu-base/ubuntu:latest

ARG work_user
ARG term
ARG colorterm
ARG lang
ARG lc_all

ENV TERM=${term}
ENV COLORTERM=${colorterm}
ENV LANG="${lang}" 

RUN apt-get update \
    && apt-get upgrade -y \ 
    && apt-get install -y sudo \
    && rm -rf /var/lib/apt/lists/*

RUN usermod -aG sudo "${work_user}"

WORKDIR /home/${work_user}
USER ${work_user}
