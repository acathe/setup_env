FROM debian:trixie

ARG user
ARG lang=C.UTF-8
ARG encoding=UTF-8
ARG timezone=Etc/UTC

RUN apt-get update \
    && apt-get install -y locales \
    && rm -rf /var/lib/apt/lists/* \
    && echo "${lang} ${encoding}" > /etc/locale.gen \
    && locale-gen \
    && update-locale LANG="${lang}"

RUN apt-get update \
    && apt-get install -y tzdata \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf "/usr/share/zoneinfo/${timezone}" /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update \
    && apt-get install -y sudo \
    && rm -rf /var/lib/apt/lists/* \
    && echo "${user} ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/${user}" \
    && chmod 0440 "/etc/sudoers.d/${user}"

WORKDIR /home/${user}
USER ${user}
