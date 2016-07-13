source fun.sh

step "### Setup a simple stub: returns everyone's favourite http status code always"

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

step "### Make request to the stub service"

curl -v $MB:5001

step "### Another request will always return you the same result"

curl -v $MB:5001/abc
