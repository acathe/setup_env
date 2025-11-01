ARG from=dev-container/terminal:latest

FROM ${from}

RUN sudo apt-get update \
    && sudo apt-get install -y clang-format unzip \
    && sudo rm -rf /var/lib/apt/lists/*

RUN protoc_version="$(curl -s https://api.github.com/repos/protocolbuffers/protobuf/releases/latest | grep tag_name | sed -E 's/.*"v([0-9.]+)".*/\1/')" \
    && curl -fsSLO "https://github.com/protocolbuffers/protobuf/releases/download/v$protoc_version/protoc-$protoc_version-linux-x86_64.zip" \
    && unzip "./protoc-$protoc_version-linux-x86_64.zip" -d $HOME/.local \
    && rm "./protoc-$protoc_version-linux-x86_64.zip"
