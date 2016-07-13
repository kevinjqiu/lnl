set -v

curl -XPOST $MB:2525/imposters -d'{
    "port": 5000,
    "protocol": "http"
}'


echo ""
echo "### Now, curl the stubbed service"
read


curl -v $MB:5000
# will get nothing, since we haven't set up any stubs yet

echo ""
echo "### Curl the imposter will give you the imposter info"
read

curl $MB:2525/imposters/5000
