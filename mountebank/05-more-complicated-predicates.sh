source fun.sh

step "### Different endpoint/method returns different response"
step "The stub service returns 403 Forbidden if no authorization header is sent"

curl -XPOST $MB:2525/imposters -d'{
    "port": 5003,
    "protocol": "http",
    "stubs": [{
        "predicates": [
            {
                "and": [
                {
                    "equals": {
                        "method": "POST",
                        "path": "/lps"
                    }
                },
                {
                    "exists": {
                        "headers": {
                            "Authorization": true
                        }
                    }
                }
                ]
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
                "and": [
                {
                    "equals": {
                        "method": "POST",
                        "path": "/lps"
                    }
                },
                {
                    "exists": {
                        "headers": {
                            "Authorization": false
                        }
                    }
                }
                ]
            }
        ],
        "responses": [
            {
                "is": {
                    "statusCode": 403,
                    "headers": {
                        "Content-Type": "application/json"
                    },
                    "body": "{\"message\": \"Nope\"}"
                }
            }
        ]
    }]
}'


step "Send POST request without authorization header..."

curl -XPOST $MB:5003/lps


step "Send POST request with authorization header..."

curl -XPOST -u admin:password $MB:5003/lps
