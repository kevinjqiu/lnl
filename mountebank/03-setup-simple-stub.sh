set -v

echo "### Setup a simple stub: returns everyone's favourite http status code always"
read

curl -XPOST $MB:2525/imposters -d'{
    "port": 5001,
    "protocol": "http",
    "stubs": [{
        "responses": [
            {
                "is": {
                    "statusCode": 418,
                    "headers": {
                        "Content-Type": "text/plain"
                    },
                    "body": "I am a tea pot"
                }
            }
        ]
    }]
}'

echo ""
echo "### Make request to the stub service"
read

curl -v $MB:5001

echo ""
echo "### Another request will always return you the same result"
read

curl -v $MB:5001/abc
