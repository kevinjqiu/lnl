source fun.sh

step "### Create an imposter (stubbed service)"

curl -XPOST $MB:2525/imposters -d'{
    "port": 5000,
    "protocol": "http"
}'


step "### Now, curl the stubbed service. You will get nothing"

curl -v $MB:5000

step "### Curl the imposter will give you the imposter info"

curl $MB:2525/imposters/5000
