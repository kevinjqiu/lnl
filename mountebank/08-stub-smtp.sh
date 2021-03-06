source fun.sh

step "### setup a stub smtp server is just as easy"

curl -XPOST $MB:2525/imposters -d'{
    "port": 5006,
    "protocol": "smtp"
}'

step "### Let's send a fake email to myself"

echo "hello from mountebank" | mailx -S smtp=$MB:5006 -s 'Hi' kevin.qiu@points.com

step "### We can retrieve the SMTP request"

curl $MB:2525/imposters/5006 | jq .
