#Applying the manifests
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml

#Verifying the deployments
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml

#Scale up
kubectl scale deployment calendar-app --replicas=5
kubectl get pods -w 

#Scale down
kubectl scale deployment calendar-app --replicas=2
kubectl get pods -w

#Self-healing
kubectl get pods #copy the name or id of the pod

kubectl delete pod <pod-name/id>

kubectl get pods #kube automatically creates a pod to replace the deleted pod

#Clean up
kubectl delete -f ingress.yaml
kubectl delete -f service.yaml
kubectl delete -f deployment.yaml
gcloud container clusters delete calendar-cluster --zone=us-central1-a
