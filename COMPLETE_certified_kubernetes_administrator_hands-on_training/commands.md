## Kubectl configuration (Kubeconfig)
cd ~/.kube
vim config

## Recommendations
Kubernetes The Hard Way - https://github.com/kelseyhightower/kubernetes-the-hard-way

## Upgrade with Kubeadm
apt-cache madison kubeadm
sudo kubeadm upgrade plan
sudo apt-mark unhold kubeadm && \
sudo apt-get update && sudo apt-get install -y kubeadm='1.28.2-00' && \
sudo apt-mark hold kubeadm
kubeadm version
sudo kubeadm upgrade apply v1.28.2

kubectl drain kubeadmwn01 --ignore-daemonsets

##### ssh into a worker node
sudo apt-mark unhold kubelet kubectl && \
sudo apt-get update && sudo apt-get install -y kubelet='1.28.2-00' kubectl='1.28.2-00' && \
sudo apt-mark hold kubelet kubectl
sudo systemctl daemon-reload
sudo systemctl restart kubelet

##### ssh into control plane and run the command:
kubectl uncordon kubeadmwn01

## Implementing third-party Secrets solution
helm repo add hashicorp https://helm.releases.hashicorp.com
helm install vault hashicorp/vault --set='ui.enabled=true' --set='ui.serviceType=LoadBalancer' --namespace vault --create-namespace
kubectl exec --stdin=true --tty=true vault-0 -n vault -- vault operator init
kubectl exec --stdin=true --tty=true vault-0 -n vault -- vault operator unseal [key]

## Sidecar container
Istio: https://github.com/istio/istio

## Helm Charts
helm create mychart
cd mychart
helm install nginxapp .
helm list
helm upgrade nginxapp .

## K8s security overview
OWASP Kuberntes Top 10: https://owasp.org/www-project-kubernetes-top-ten/
