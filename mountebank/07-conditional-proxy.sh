source fun.sh

step "### proxy some requests to the real server"

curl -XPOST $MB:2525/imposters -d'{
    "port": 5005,
    "protocol": "http",
    "stubs": [
    {
        "predicates": [{
            "equals": {
                "path": "/stub_ip"
            }
        }],
        "responses": [
        {
            "is": {
                "body": "8.8.8.8"
            }
        }
        ]
    },
    {
        "predicates": [{
            "equals": {
                "path": "/ip"
            }
        }],
        "responses": [
        {
            "proxy": {
                "to": "http://httpbin.org",
                "mode": "proxyAlways"
            }
        }
        ]
    }]
}'

step "### some requests are sent to the origin server"

curl $MB:5005/ip

step "### some requests returns the stub"

curl $MB:5005/stub_ip
