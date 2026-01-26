docker ps
docker run redis
docker run ubuntu sleep 15
docker build . -f Dockerfile -t ev/my-custom-app
docker push ev/my-custom-app

docker run -it ubuntu bash
apt-get update
apt-get install -y python3
apt-get install -y python3-flask
FLASK_APP=app.py flask run --host=0.0.0.0
docker build . -t ev/my-single-webapp
docker images
docker run my-single-webapp
http://172.17.0.3:5000

docker login
docker build . -t ev/my-single-webapp
docker run -e APP_COLOR=blue my-single-webapp
docker inspect my-single-webapp
docker image ls

# Docker PID
dcoker run -d --rm -p 8888:8080 tomcat:8.0
docker exec [container_id] ps -eaf
ps -eaf

# Docker storage
docker info | more
docker system df
docker system df -v
