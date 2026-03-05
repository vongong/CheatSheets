
# Kubernetes (k8)
its an orchestration platform. It Manages containers and manage container environments. Think Docker as a Container and K8 as the shipping container.
- manage containers across multiple machines
- scaling
- load balancing
- self healing

## Links
- [nana k8 demo](https://gitlab.com/nanuchi/bootcamp-kubernetes)
- [yaml config](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/declarative-config/)

## Glossary
- Nodes: VM
- Pod: smallest k8 component. abstraction over container. each pod get IP Addr(internal). pods are ephemeral.
- Service: Permanant IP; lifecycle not same with pods
  - Type: Internal|External 
  - External: Open access to Exernal services
- ingress: Domain Name forward to Service
- configmap: property data / files; config data (ie urls)
- secret: sensitive config data (ie passwords & credentials). stored base64
- volumes: data storage; persistant data
  - attached storage (local, remote, cloud) to pod

## kubectl commands
```sh
kubectl get ns
kubectl get nodes
kubectl get nodes -n my-ns
kubectl get pod
kubectl get services
kubectl create deployment nginx-depl --image=nginx
kubectl get deployment
kubectl get replicaset
kubectl edit deployment nginx-depl
```