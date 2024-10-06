#!/bin/bash

# Check if the test-pod is running
pod_status=$(kubectl get pod test-pod --no-headers 2>/dev/null | awk '{print $3}')

# Verify if the pod status is "Running"
if [[ "$pod_status" == "Running" ]]; then
  echo "The pod 'test-pod' is running successfully."
  exit 0
else
  echo "The pod 'test-pod' is not running or does not exist."
  exit 1
fi