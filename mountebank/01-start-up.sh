docker pull kevinjqiu/mountebank
docker run --name mountebank -d kevinjqiu/mountebank
docker inspect mountebank | grep IPAdd
