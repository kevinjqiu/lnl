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
                    "path": "/lps"
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
                    "path": "/lps/LPID"
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

step "### Create an LP by sending a POST request"
curl -XPOST $MB:5002/lps

step "### Get the \"created\" LP"
curl $MB:5002/lps/LPID
