FROM debian:trixie

ARG user
ARG lang
ARG encoding
ARG language
ARG tz
ARG term=xterm-256color

SHELL ["/bin/bash", "-c"]

ENV LANG=${lang}.${encoding}
ENV LANGUAGE=${language}
ENV TZ=${tz}
ENV TERM=${term}

RUN apt-get update \
    && apt-get install -y locales \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i ${lang} -c -f ${encoding} -A /usr/share/locale/locale.alias ${lang}.${encoding}

RUN apt-get update \
    && apt-get install -y sudo \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m -s "$(command -v bash)" "${user}" \
    && echo "${user} ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/${user}" \
    && chmod 0440 "/etc/sudoers.d/${user}"

WORKDIR /home/${user}
USER ${user}
