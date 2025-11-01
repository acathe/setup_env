ARG from=dev-container/terminal:latest

FROM ${from}

RUN sudo apt-get update \
    && sudo apt-get install -y clang-format unzip \
    && sudo rm -rf /var/lib/apt/lists/*

RUN thrift_version="$(curl -s https://downloads.apache.org/thrift/ | grep -oP '(?<=href=")[0-9.]+(?=/")' | sort -V | tail -n1)" \
    && curl -fsSLO "http://www.apache.org/dyn/closer.cgi?path=/thrift/$thrift_version/thrift-$thrift_version.tar.gz" \
    && tar -C "$HOME/.local/bin" -xzf "thrift-$thrift_version.tar.gz" \
    && rm -rf "thrift-$thrift_version.tar.gz"
