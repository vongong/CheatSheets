
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

## Architecture
- Worker Nodes 
  - process
    - Container runtime
    - kublet: scheduler for container and server
    - kube proxy: routes request to correct service on worker nodes
  - needs more resources
- Master Nodes 
  - process
    - api server
      - acts like gateway to cluster (web/kubectl)
      - authenticator
    - scheduler: start work on worker nodes (kublet)
    - coller manager: detect state change of pods
    - etcd: key value store state (cluster brain)
      - not app data
  - needs less resources

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