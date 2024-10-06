#!/bin/bash

# Check if the test-pod exists in the default namespace
pod_status=$(kubectl get pod test-pod --no-headers 2>/dev/null)

# Verify if the pod exists
if [[ -n "$pod_status" ]]; then
  echo "Pod 'test-pod' exists."
  exit 0
else
  echo "Pod 'test-pod' does not exist. Please check if the pod was created correctly."
  exit 1
fi