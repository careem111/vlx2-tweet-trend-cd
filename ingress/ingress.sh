#!/bin/bash
helm repo add traefik https://helm.traefik.io/traefik 
helm repo update traefik
helm install vlx-tweet-traefik traefik/traefik

kubectl apply -f ingress-rule.yaml

kubectl get svc