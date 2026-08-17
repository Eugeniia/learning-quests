### Docker SWARM
With Docker SWARM you can combine multiple Docker machines together into a single cluster. Docker SWARM will take care of distributing your services into separate hosts for high availability. It also help us in balancing load across different systems and hardware. 

Requirements: Nodes - Swarm Manager (or Master) and workers

docker swarm init (on Swarm Manager node)
docker swarm join --token <token> (on Worker node)

Swarm Manager (or Master) node is a node where Swarm cluster is initiated. It is responsible for managing the cluster state, managing the workers. It's recommended to have a few Swarm Manager nodes (with one Leader responsible for making the decisions to avoid conflict of interest).

Docker recommends 7 managers (but better no more). No limits on managers. Better to choose odd number of nodes, e.g. 3, 5 or 7.

There is a distributed consensus mechanism called Raft. It decides who is gonna be a leader amonge the manager nodes, and that all decisions are in concent with other manager nodes.
Quorum - when a decision is made by the majority of the manager nodes.

Quorum of N = (N+1)/2

Fault Tolerance = the opposite of Quorum, i.e. the total of failing nodes.

Fault Tolerance of N = (N -1)/2


If only one of the three managers are healthy, and the other two can't be easily back (that's why you can't make any decision based on quorum), then you can run this command to recreate a new cluster with only one available manager node to bring the cluster back to the healthy state.
docker swarm init --force-new-cluster

To promote existing worker node to a manager node (can only be done from a master node):
docker node promote

Manager node is also a worker node, to disable it from "worker" node responsibilities, run this command:
docker node update --availability drain <Node>

1. Create Swarm cluster
docker swarm init (check --advertise-addr option)
docker swarm join --token <TOKEN>

2. Add Worker nodes
docker swarm join --token <TOKEN>
docker node ls
docker node rm <NODE_NAME>
docker swarm join-token worker

3. Add Manager nodes
docker swarm join-token manager
docker swarm join --token <TOKEN>

4. Quorum
shutdown now (to intentially shutdown one of the nodes)

docker swarm init --advertise-addr $(ifconfig eth0 | grep 'inet ' | awk '{print $2}' | sed 's/addr://')

# Docker service
Docker orchestration using docker services. Docker services - one or more of a single application or service that runs across the swarm cluster.
docker service create --replicas=3 my-web-server (run it on a manager node)

There are two types of services:
1) Replicated (with "--replicas" option)
docker service create --replicas=3 --name web-server my-web-server

2) Global (service running on all worker nodes)
docker service create --mode global my-monitoring-agent

To update the service with 4 replicas:
docker service update --replicas=4 web-server

Examples:
docker service create nginx
docker service --help
docker service ls
docker service ps <service_ID>
docker service rm <service_ID>

Since our application is a web application so it needs ports to be published. The web application exports port 80. Add a port publish option to publish port 80 to port 8080 on the host:
docker service create --replicas 3 --name vote -p 8080:80 voting-app

We would like to attach the services to a dedicated front-end network. Add a network option to attach the service to front-end network:
docker service create --replicas 3 --name vote -p 8080:80 --network front-end voting-app
  
We have the service running with 3 containers. At a later point in time we decide to update the service to have 6 containers. Input a command in the command file to update service "vote" to have 6 replicas:
docker service update --replicas=6 vote

# Advanced networking
Default networks:
1. Bridge (the default network the container gets attached to). It's a private internal network created by docker on the host. ALl containers are attached to this network by default and they usually get the IP addresses in the range of 172.17.0.* series. To access any of these containers from the outside world, map ports of these containers to the port on the docker host.
docker run ubuntu
2. None. Containers don't have access to the external network or other containers.
docker run Ubuntu --network=none
3. Host. Container uses the host network. You're not able to run multiple web containers on the same host on the same port as the port is now common for all containers in the host network.  
docker run Ubuntu --network=host

1. Overlay network
docker network create --driver overlay --subnet 10.0.9.0/24 my-over1
docker service create --replicas 2 --network my-overlay-network nginx
2. Ingress network
Routing mesh across all docker hosts.
Embedded DNS.

# Docker stacks
docker stack deploy (similar to "docker-compose up", to avoid running multiple "docker service" commands)

Stack is a group of interrelated services that together form an entire application.

docker stack deploy voting=app-stack --compose-file docker-stack.yml
docker service ls

Docker swarm visualizer.

# CI/CD (Continuous Integration / Continuous Delivery & Deployment)
CI: code > code repo (GitHub) > Build System (Jenkins) > Test Framework (Robot Framework)
CD: CI > release management (Serena) > Production Environment (GCP, Pivotal CF)

Dockerhub - public Docker Registry. You can set up your private Docker Registry.

docker pull registry

"Play with Docker" (PWD) environment

docker version
docker run -d -p 5000:5000 --restart always --name registry registry:2
docker pull hello-world
docker images
docker tag hello-world localhost:5000/hello-world
docker push localhost:5000/hello-world
docker exec -it registry /bin/sh
ls /var/lib/registry/docker/registry/v2/repositories/hello-world

# Docker Cloud
Docker's own cloud-based container-hosting platform. 
cloud.docker.com

# Kubernetes - advanced container orchestration technology.
There are kube master (~swarm manager) and kube node (or minion) (~swarm worker) nodes.
K8s doesn't run containers directly on worker nodes (like docker swarm does). K8s wraps a container inside the virtual block (known as pod). A single pod can have multiple containers (usually of different type) within it. IP address is assigned at the pod level so all containers within the same pod share the same network namespace and can communicate with each other using the hostname "localhost" + they also share the same storage volumes (allowing the containers to access the same shared data). Also, your app is scaled at the pod level. 

Docker swarm services is similar to the K8s deployment. K8s deployment creates a replicaSet to create multiple instances of pods.   

Docker swarm links are similar to the K8s services. In K8s we use services to enable communication between pods and to enable external access to the application. There are internal services (e.g. ClusterIP) and external services (e.g. LoadBalancer) in K8s.

kubectl delete -f . (to delete all pods and services at once)
