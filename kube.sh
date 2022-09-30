#!/bin/bash

export KUBECONFIG=./playbook/admin.conf

echo "----------- Nodes"
kubectl get nodes
sleep 5s
echo "----------- Namespaces"
kubectl get namespaces
sleep 5s
echo "----------- Pods"
kubectl get pods
sleep 5s
echo "----------- Kube Bench Logs"
kubectl logs $(kubectl get po -l app=kube-bench -o name)
