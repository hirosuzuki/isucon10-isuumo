build:
	go build

load-init-files:
	scp isu10q-a:/etc/nginx/nginx.conf nginx.conf
	scp isu10q-a:/home/isucon/isuumo/webapp/mysql/db/0_Schema.sql 0_Schema.sql
	scp isu10q-a:/home/isucon/isucon10-qualify/webapp/go/go.mod go.mod
	scp isu10q-a:/home/isucon/isucon10-qualify/webapp/go/go.sum go.sum
	scp isu10q-a:/home/isucon/isucon10-qualify/webapp/go/main.go main.go
	scp isu10q-a:/home/isucon/env.sh env.sh

mysql-deploy:
	ssh isu10q-b sudo tee /etc/mysql/my.cnf < my.cnf > /dev/null
	ssh isu10q-b sudo systemctl restart mysql
	ssh isu10q-c sudo tee /etc/mysql/my.cnf < my.cnf > /dev/null
	ssh isu10q-c sudo systemctl restart mysql

deploy:
	go build
	ssh isu10q-a sudo tee /etc/nginx/nginx.conf < nginx.conf > /dev/null
	ssh isu10q-a sudo mv /var/log/nginx/access.log /var/log/nginx/access.log-`date +%Y%m%d-%H%M%S` || true
	ssh isu10q-a sudo systemctl restart nginx
	ssh isu10q-a sudo chmod 644 /var/log/nginx/access.log || true
	ssh isu10q-a sudo systemctl stop isuumo.go.service
	scp isuumo isu10q-a:/home/isucon/isuumo/webapp/go/isuumo
	scp env.sh isu10q-a:/home/isucon/env.sh
	scp 0_Schema.sql isu10q-a:/home/isucon/isuumo/webapp/mysql/db/0_Schema.sql
	ssh isu10q-a sudo systemctl start isuumo.go.service

import_logs:
	sh import_logs.sh

pprof:
	go tool pprof -http="127.0.0.1:8020" logs/latest/cpu.pprof