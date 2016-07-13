source fun.sh

step "### Different endpoint/method returns different response"

curl -XPOST $MB:2525/imposters -d'{
    "port": 5002,
    "protocol": "http",
    "stubs": [{
        "predicates": [
            {
                "equals": {
                    "method": "POST",
                    "path": "/lp"
                }
            }
        ],
        "responses": [
            {
                "is": {
                    "statusCode": 201,
                    "headers": {
                        "Content-Type": "application/json"
                    },
                    "body": "{\"id\": \"LPID\"}"
                }
            }
        ]
    },
    {
        "predicates": [
            {
                "equals": {
                    "method": "GET",
                    "path": "/lp/LPID"
                }
            }
        ],
        "responses": [
            {
                "is": {
                    "statusCode": 200,
                    "headers": {
                        "Content-Type": "application/json"
                    },
                    "body": "{\"id\": \"LPID\", \"name\": \"Global Rewards\"}"
                }
            }
        ]
    }]
}'
