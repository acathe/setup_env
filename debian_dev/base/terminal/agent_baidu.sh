#!/usr/bin/env bash

agent_baidu() {
    case "$1" in
    enable)
        export HTTP_PROXY="http://agent.baidu.com:8891"
        export HTTPS_PROXY="$HTTP_PROXY"
        export NO_PROXY="127.0.0.1,localhost,local,.local,172.0.0.0/24,10.0.0.0/24,.baidu.com,.baidu-int.com,.cn"
        ;;
    disable)
        unset HTTP_PROXY
        unset HTTPS_PROXY
        unset NO_PROXY
        ;;
    *)
        echo "用法: agent_baidu {enable|disable}"
        ;;
    esac
}
