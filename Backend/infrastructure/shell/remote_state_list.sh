#!/bin/bash


for state in $(terraform state list);
do
    terraform state rm $state
done