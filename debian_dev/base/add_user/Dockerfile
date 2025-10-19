FROM iregistry.baidu-int.com/baidu-base/ubuntu:latest

ARG term
ARG colorterm
ARG lang
ARG lc_all

ENV TERM=${term}
ENV COLORTERM=${colorterm}
ENV LANG="${lang}" 
ENV LC_ALL="${lc_all}" 

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y sudo bns && \
    echo 'zhuchengrui ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/zhuchengrui && \
    chmod 0440 /etc/sudoers.d/zhuchengrui && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /home/zhuchengrui
USER zhuchengrui
