source fun.sh

step "### You can also add behaviour to your stub. e.g., add a latency"

curl -XPOST $MB:2525/imposters -d'{
    "port": 5004,
    "protocol": "http",
    "stubs": [
    {
        "responses": [
        {
            "is": {
                "statusCode": 504,
                "headers": {
                    "Content-Type": "text/html"
                },
                "body": "<html><body>Service unavailable</body></html>"
            },
            "_behaviors": {
                "wait": 1000
            }
        }
        ]
    }]
}'

step "### You just added 1s delay to that endpoint"

curl -v $MB:5004/
