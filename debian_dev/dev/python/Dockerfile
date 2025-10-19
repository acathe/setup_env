ARG tag
ARG pre_stage

FROM dev_env:${tag}-${pre_stage}

COPY ./env.sh ${PWD}/env.sh

RUN bash ${PWD}/env.sh
