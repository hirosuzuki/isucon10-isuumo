#!/bin/sh

TraceID=$(date +%Y%m%d-%H%M%S)

mkdir -p ./logs/$TraceID/
ln -sfT $TraceID ./logs/latest

ssh isu10q-a sudo pkill -HUP isuumo
scp isu10q-a:/var/log/nginx/access.log \
    isu10q-a:/tmp/cpu.pprof \
    isu10q-a:/tmp/perf.log \
    isu10q-a:/tmp/sql.log \
    isu10q-a:/tmp/webroute.log \
    ./logs/$TraceID/

ssh isu10q-a sudo chmod 644 /tmp/mysql-slow.log
scp isu10q-a:/tmp/mysql-slow.log \
    ./logs/$TraceID/
