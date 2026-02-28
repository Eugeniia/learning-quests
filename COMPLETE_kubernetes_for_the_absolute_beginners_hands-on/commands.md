## Useful commands
kunectl get all
kubectl explain deployment | head -n3

kubectl create -f mydeployment.yml --record
kubectl rollout status deployment/myapp-deployment
kubectl rollout history deployment/myapp-deployment
kubectl apply -f mydeployment.yml # make a change before deploying
kubectl rollout status deployment/myapp-deployment
kubectl rollout history deployment/myapp-deployment
kubectl set image deployment/myapp-deployment nging-container=nginx:1.12-perl
kubectl rollout status deployment/myapp-deployment
kubectl rollout history deployment/myapp-deployment
kubectl rollout undo deployment myapp-deployment
kubectl rollout status deployment/myapp-deployment
kubectl rollout history deployment/myapp-deployment

## Useful links
https://github.com/kodekloudhub/certified-kubernetes-administrator-course
