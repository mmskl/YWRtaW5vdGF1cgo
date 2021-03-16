#!/usr/bin/bash

echo '
echo " - check if nginx.john.doe returns localhost"
dig +short nginx.john.doe | grep -q 127.0.0.1 && echo OK || echo NOTOK!

echo " - check if apache.john.doe returns localhost"
dig +short apache.john.doe && echo OK || echo NOTOK!

echo " - check if apache.john.doe has phpinfo() in title"
curl http://apache.john.doe 2>/dev/null | grep "<title>" | grep -q phpinfo\(\) && echo OK || echo NOTOK!

echo " - check if php-fpm runs on port 9000"
netstat -tln | grep -q :9000 && echo OK || echo NOTOK!

echo " - check if mariadb runs on port 3306"
netstat -tln | grep -q :3306 && echo OK || echo NOTOK!

echo " - check nginx.john.doe/wp-admin/"
curl -L http://nginx.john.doe/wp-admin/ 2>/dev/null | grep "<title>" | grep -q Installation && echo OK || echo NOTOK!
' > testscript.sh


docker cp testscript.sh debian10:/
docker exec -it debian10 sudo bash /testscript.sh
rm testscript.sh
