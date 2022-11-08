#!/bin/bash


for name in $(kubectl get ns | grep Terminating | cut -d ' ' -f1);
do
  kubectl get ns $name -o json | \
  jq '.spec.finalizers=[]' | \
  curl -X PUT http://localhost:8001/api/v1/namespaces/$name/finalize -H "Content-Type: application/json" --data @-
done