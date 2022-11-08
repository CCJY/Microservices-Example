#!/bin/bash

for name in $(kubectl get pvc -A | cut -d ' ' -f1 | grep pv);
do
    kubectl delete pvc $name
done

for name in $(kubectl get pv -A | cut -d ' ' -f1 | grep pv);
do
    kubectl delete pv $name
done