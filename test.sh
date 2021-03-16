#!/usr/bin/bash

# templorary set local dns resolver as default one (it doesn't forward requests)
ssh -i rsa_key ansible@127.0.0.1 -p22022 "sudo bash -c 'echo \" nameserver 127.0.0.1\" > /etc/resolv.conf'"

echo '
echo " - check if nginx.john.doe returns localhost"
dig +short nginx.john.doe | grep -q 127.0.0.1 && echo OK || echo NOTOK!

echo " - check if apache.john.doe returns localhost"
dig +short apache.john.doe

echo " - check if apache.john.doe has phpinfo() in title"
curl http://apache.john.doe 2>/dev/null | grep "<title>" | grep -q "phpinfo\(\)" && echo OK || echo NOTOK!

echo " - check if nginx.john.doe/wp-admin/ has <h1>Welcome</h1>"
curl -L http://nginx.john.doe/wp-admin/ 2>/dev/null | grep -q "<h1>Welcome</h1>" && echo OK || echo NOTOK!
' | ssh -i rsa_key ansible@127.0.0.1 -p22022 "cat > test.sh"



ssh -i rsa_key ansible@127.0.0.1 -p22022 "bash ./test.sh"
