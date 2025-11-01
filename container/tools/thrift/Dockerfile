ARG from=dev-container/terminal:latest

FROM ${from}

ARG thrift_version

RUN curl -fsSLO "http://www.apache.org/dyn/closer.cgi?path=/thrift/${thrift_version}/thrift-${thrift_version}.tar.gz" \
    && tar -C "$HOME/.local/bin" -xzf "./thrift-${thrift_version}.tar.gz" \
    && rm -rf "./thrift-${thrift_version}.tar.gz"
