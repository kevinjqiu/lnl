source fun.sh

docker stop mountebank 2>/dev/null || true
docker rm mountebank 2>/dev/null || true
docker pull kevinjqiu/mountebank
docker run --name mountebank -d kevinjqiu/mountebank
docker inspect mountebank | grep IPAdd
